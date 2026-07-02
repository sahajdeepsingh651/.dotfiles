#!/usr/bin/env python3
"""Mode-gated overlay injection (hybrid policy). Handles two hook events:

UserPromptSubmit:
  card     -- full overlay (lb-shared + mode card). Logged with why=:
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

Sticky mode: a prefix (L/B/S, optionally LC) sets the mode for the session until changed.
State per session in ~/.claude/state/mode-overlay/<session_id>.json
Log every injection in ~/.claude/state/mode-overlay.log:
  grep 'why=distance'  -> just the automatic size-triggered re-injections
"""
import json, os, re, sys, datetime

MODES_DIR = os.path.expanduser("~/.claude/modes")
STATE_DIR = os.path.expanduser("~/.claude/state/mode-overlay")
LOG_FILE = os.path.expanduser("~/.claude/state/mode-overlay.log")
CARD_INTERVAL = 120_000  # transcript bytes between full cards (~30k tokens)

# Prefix: L/B/S (case-insensitive), optional C (LC -> L), then ':', '-', '.' or whitespace.
PREFIX_RE = re.compile(r"^\s*([LBSlbs])([Cc])?(?:\s*[:\-–—.]\s*|\s+|\s*$)")

TRIPWIRES = {
    "L": "[mode: L] Gate active: no code reveal before Sahaj produces the contract-bearing token "
         "(compiler-unverifiable contracts). Hypothesis before fixes. Full rules: earlier [L-mode card].",
    "B": "[mode: B] Large/irreversible -> full methodology; everything else -> decide and tell in one line.",
    "S": "[mode: S] Execute. Flag only genuine danger, one sentence. No quizzes.",
}
CARD_FILES = {
    "L": ["lb-shared.md", "l-only.md"],
    "B": ["lb-shared.md", "b-only.md"],
    "S": ["s-only.md"],
}
ASK_MSG = ("[mode-overlay] No mode is set for this session. Before proceeding, ask Sahaj once "
           "which mode applies (L=learning / B=building / S=ship), per CLAUDE.md.")


def read_cards(mode):
    parts = []
    for name in CARD_FILES[mode]:
        path = os.path.join(MODES_DIR, name)
        try:
            with open(path) as f:
                parts.append(f.read().strip())
        except OSError:
            parts.append(f"[mode-overlay: missing {name} — tell Sahaj the hook is misconfigured]")
    return "\n\n".join(parts)


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
        if m.group(2):  # LC and variants fold into L
            new_mode = "L"
        if new_mode != state["mode"]:
            switched = True
        state["mode"] = new_mode

    mode = state["mode"]
    if not mode:
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
        print(TRIPWIRES[mode])
        log(session_id, mode, "tripwire", size)


if __name__ == "__main__":
    try:
        main()
    except Exception:
        sys.exit(0)  # never break the prompt on a hook bug
