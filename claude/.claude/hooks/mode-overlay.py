#!/usr/bin/env python3
"""Mode-gated overlay injection (hybrid policy). Handles two hook events:

UserPromptSubmit:
  card     -- full overlay (every file in CARD_FILES[mode]). Logged with why=:
                switch   mode prefix changed the sticky mode
                distance transcript grew >= CARD_INTERVAL bytes since last card  <-- the auto refresh
                compact  first prompt after a compaction (PostCompact reset)
                first    first card of a session (fallback; usually shows as switch)
                shrink   transcript file shrank since last card (rare)
  tripwire -- one-line gate reminder: every other prompt while a mode is sticky
  ask      -- one-time nudge to ask Sahaj for a mode, when a session has none
  (silence -- no mode set and the ask already fired: no output, no log line)

PostCompact:
  resets the card counter so the next prompt fires a card (why=compact) -- earlier
  injections may have been summarized out of the replay.

Sticky mode: a prefix sets the mode for the session until changed. The colon is REQUIRED --
  a bare "B ..." is prose, not a switch.
    L:   learning something that isn't code (a text, a paper, a domain)
    LC:  learning + coding -- the L gate plus the coding cards
    B:   building        S: ship
  Cards compose: each mode names a list in CARD_FILES, and both the card text and the tripwire
  are read from those same files, so the two can never drift apart.
State per session in ~/.claude/state/mode-overlay/<session_id>.json
Log every injection in ~/.claude/state/mode-overlay.log:
  grep 'why=distance'  -> just the automatic size-triggered re-injections
"""
import json, os, re, sys, datetime

MODES_DIR = os.path.expanduser("~/.claude/modes")
STATE_DIR = os.path.expanduser("~/.claude/state/mode-overlay")
LOG_FILE = os.path.expanduser("~/.claude/state/mode-overlay.log")
CARD_INTERVAL = 120_000  # transcript bytes between full cards (~30k tokens)

# Prefix: L/B/S (case-insensitive), optional C (LC -> L), then a REQUIRED ':'.
# The colon is what makes this unambiguous. Without it, prose starting with the letter was read
# as a switch -- "B and S cant be true at the same time" silently flipped a live L session to B,
# and "b-only.md ..." / "l-only.md ..." matched on the hyphen. 2026-08-01.
PREFIX_RE = re.compile(r"^\s*([LBSlbs])([Cc])?\s*:\s*")
# Typo guard for the colon rule: a bare "L ..." reads as an attempted prefix. Only checked while
# no mode is set -- once a mode is sticky he has no reason to re-prefix, so a leading letter
# mid-session is prose, and nudging on it would reintroduce the ambiguity the colon removed.
NEAR_PREFIX_RE = re.compile(r"^\s*([LBSlbs])([Cc])?\s+\S")

# Tripwires live in the card files themselves, one `TRIPWIRE: ...` line per card, collected over
# the same CARD_FILES list as the card. Single source of truth: a card edit cannot drift from its
# tripwire. (It could before -- the L tripwire still named only one of the gate's two triggers
# weeks after the card gained the second. 2026-08-01.)
TRIPWIRE_RE = re.compile(r"^TRIPWIRE:[ \t]*(.+?)[ \t]*$", re.MULTILINE)
# L is generalized learning (a text, a domain -- not code). C is the coding layer; it only ever
# rides on L, so `C:` alone is not a mode -- coding without the learning gate is just B.
CARD_FILES = {
    "L": ["l-only.md"],
    "LC": ["cb-shared.md", "c-mode.md", "l-only.md"],
    "B": ["cb-shared.md", "b-only.md"],
    "S": ["s-only.md"],
}
ASK_MSG = ("[mode-overlay] No mode is set for this session. Before proceeding, ask Sahaj once "
           "which mode applies (L=learning / LC=learning+coding / B=building / S=ship), "
           "per CLAUDE.md.")


def card_text(name):
    try:
        with open(os.path.join(MODES_DIR, name)) as f:
            return f.read()
    except OSError:
        return None


def read_cards(mode):
    parts = []
    for name in CARD_FILES[mode]:
        raw = card_text(name)
        if raw is None:
            parts.append(f"[mode-overlay: missing {name} — tell Sahaj the hook is misconfigured]")
        else:
            parts.append(TRIPWIRE_RE.sub("", raw).strip())  # tripwire is the compressed twin
    return "\n\n".join(parts)


def read_tripwire(mode):
    bits = []
    for name in CARD_FILES[mode]:
        raw = card_text(name)
        if raw is not None:
            bits += [m.group(1) for m in TRIPWIRE_RE.finditer(raw)]
    if not bits:
        return (f"[mode: {mode}] No TRIPWIRE: line found in "
                f"{', '.join(CARD_FILES[mode])} — tell Sahaj the card is missing its tripwire.")
    return f"[mode: {mode}] " + " ".join(bits)


def log(session_id, mode, tier, size, why=None):
    with open(LOG_FILE, "a") as f:
        stamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        line = f"{stamp} session={session_id[:8]} mode={mode} tier={tier} bytes={size}"
        if why:
            line += f" why={why}"
        f.write(line + "\n")


def main():
    data = json.load(sys.stdin)
    event = data.get("hook_event_name", "UserPromptSubmit")
    session_id = data.get("session_id", "unknown")
    transcript = data.get("transcript_path", "") or ""

    os.makedirs(STATE_DIR, exist_ok=True)
    state_path = os.path.join(STATE_DIR, f"{session_id}.json")
    try:
        with open(state_path) as f:
            state = json.load(f)
    except (OSError, ValueError):
        state = {"mode": None, "last_card_bytes": 0, "asked": False, "compact_pending": False}

    def save():
        with open(state_path, "w") as f:
            json.dump(state, f)

    try:
        size = os.path.getsize(transcript) if transcript else 0
    except OSError:
        size = 0

    if event == "PostCompact":
        state["last_card_bytes"] = 0
        state["compact_pending"] = True
        save()
        log(session_id, state.get("mode") or "-", "compact-reset", size)
        return

    prompt = data.get("prompt", "") or ""
    m = PREFIX_RE.match(prompt)
    switched = False
    if m:
        new_mode = m.group(1).upper()
        if m.group(2) and new_mode == "L":  # LC: -> learning + coding; C only modifies L
            new_mode = "LC"
        if new_mode != state["mode"]:
            switched = True
        state["mode"] = new_mode

    mode = state["mode"]
    if not mode:
        near = NEAR_PREFIX_RE.match(prompt)
        if near and not state.get("nudged"):
            state["nudged"] = True
            save()
            want = near.group(1).upper() + ("C" if near.group(2) else "")
            print(f"[mode-overlay] That looks like a mode prefix without its colon. Ask Sahaj "
                  f'whether he meant "{want}:" — the colon is required, so no mode was set.')
            log(session_id, "-", "nudge", size)
            return
        if not state.get("asked"):
            state["asked"] = True
            save()
            print(ASK_MSG)
            log(session_id, "-", "ask", size)
        return  # silence: mode-less and already asked

    last = state["last_card_bytes"]
    # Decide the card cause in precedence order; None => tripwire.
    why = None
    if switched:
        why = "switch"
    elif state.get("compact_pending"):
        why = "compact"
    elif last == 0:
        why = "first"
    elif size < last:
        why = "shrink"
    elif size - last >= CARD_INTERVAL:
        why = "distance"

    if why:
        state["compact_pending"] = False
        state["last_card_bytes"] = max(size, 1)
        save()
        print(f"[mode-overlay: {mode} | full card · {why}]\n{read_cards(mode)}")
        log(session_id, mode, "card", size, why)
    else:
        save()
        print(read_tripwire(mode))
        log(session_id, mode, "tripwire", size)


if __name__ == "__main__":
    try:
        main()
    except Exception:
        sys.exit(0)  # never break the prompt on a hook bug
