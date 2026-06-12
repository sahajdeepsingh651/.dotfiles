# /new — one entry point for anything new in the vault

Replaces `/new-project` and `/new-study`. One triage question decides everything else.

**Triage first.** Ask (or confirm from `$ARGUMENTS`): **"Build, learn, or standalone thought?"**

- **Build** → `projects/<name>/` — something with code and a goal
- **Learn** → `studies/<slug>/` — a domain or source being digested
- **Standalone** → `notes/<slug>.md` — one decided thought; a single file, no folder, no scaffold

Vault rules (from `meta/STRUCTURE.md`): folder = what a note *is*; frontmatter = what varies. **Promote a cluster, don't force a domain** — a lone concept is a note; when several notes cluster around a subject, *suggest* promoting them into a study (Sahaj decides). And never scaffold ahead of need: **a file earns existence by forcing thought when written, or by being genuinely reread.** When in doubt, create less.

Frontmatter for note-like files:

```yaml
---
domain:            # what it's about — security, distributed-systems, ...
context: personal  # work | personal
status: seed       # seed | developing — never "done"
created: YYYY-MM-DD
---
```

---

## Standalone note

1. Ask only the title/topic (and domain if not obvious). One question, not three.
2. Create `notes/<slug>.md` with frontmatter, `# Title`, and whatever content he gives — his words, not a generated essay.
3. **He makes any `[[links]]`** — suggest candidates at most; linking is thinking.
4. Done. No index updates, no folder, nothing else.

---

## Study → `studies/<slug>/`

Ask one at a time:

1. **Topic** — what's being studied.
2. **Spine** — the central question or tension this study exists to resolve. May stay open ("sharpen as sources land").
3. **First source** — URL / PDF / local file / "none yet".

Check what exists first (`ls studies/<slug>/`) — read-then-update anything already there. Then scaffold the **minimum**:

```
studies/<slug>/
  raw/                 ← immutable sources. Read, never modify. (assets/ for figures, on need)
  raw/conjectures/     ← HIS dated conjecture snapshots — append-only once written
  SCHEMA.md            ← the discipline (template below)
  <slug>.md            ← HIS understanding file — he writes it, in his words
  log.md               ← append-only: ## [YYYY-MM-DD] event | one line
```

No `wiki/` tree, no index, no overview at scaffold time — need pulls those into existence (the SCHEMA says how). Stage any source into `raw/` (URL → WebFetch → `.md`; paper → `.pdf`; figures → `raw/assets/`). **Do not summarize or interpret the source at staging time.**

### SCHEMA.md template (fill `<...>`)

````markdown
# <Topic> — Study Schema

How any LLM works in this study. Read this before touching anything here.

## What this is
A study of **<topic>** — <one-line description>.
**The spine:** <central question/tension — or "open; to be sharpened as sources land">.

## The Forge loop (non-negotiable order)
1. **Conjecture before contact.** Before Sahaj reads a source, he writes his naive guess to
   `raw/conjectures/YYYY-MM-DD-<source-slug>.md` — from his own priors. You may **orient** first
   (genre, era, length, the vocabulary needed to parse it) — **never interpret** (claims, takeaways,
   "what it means"). His conjecture must stay independent of the source that will test it.
2. **He reads the raw source himself.** Not your summary of it.
3. **Then you spar — adversary mode, explicitly.** Refute with checkables: point at the passage, the
   counterexample, the failed prediction. Bare verdicts are worthless; your agreement is weak evidence.
   Where his conjecture and the source collide, surface the collision — through questions first.
4. **He writes the understanding** into `<slug>.md`, in his words. Draft only if asked, and he
   rewrites the load-bearing sentences.
5. **Summaries are f(source, his conjecture)** — generated from both, and they must preserve the gap:
   where his model matched, where it broke, what's still open. Never smooth the disagreement away;
   the broken parts are the calibration record.
6. **Conjecture snapshots are append-only.** When his model revises, write a *new* dated file — never
   edit an old one. The diff between snapshots is the learning, recorded.

`/forge` runs this loop on any single conjecture.

## Framing allocation
Every artifact you produce is an act of framing — there is no frame-free notation. So the split is
deliberate: **he owns** theory-sentences, what counts as central, the spine, and all `[[links]]`
(linking is thinking — suggest, never make). **You own** citations, `log.md`, contradiction-flagging,
and tidying.

## Testing ladder
Your criticism is the cheap first filter — and your errors correlate with his. The independent middle
tier is other minds (a blog post, explaining it to a human). The final tier is reality: the primary
text ("does §4 actually say that?"), the historical record, a built thing. Nudge load-bearing
conjectures up the ladder.

## Growth
Start with the one understanding file. When it outgrows itself (multiple sources, recurring concepts),
split into `wiki/` pages and add an index — *when the need is felt, not before*. Integrity test before
any page is called his: **could he defend it with the LLM out of the room?**

## Log
Append `## [YYYY-MM-DD] <ingest|spar|snapshot|query> | <one line>` to `log.md`.
````

After scaffolding, if a source was staged, ask: **"Conjecture first — write your naive guess now?"** Never start interpreting the source.

---

## Project → `projects/<name>/`

Ask one at a time:

1. **Name**
2. **Language/stack** — skip if undecided. If Go, confirm GitHub username for the module path.
3. **One-line description**

Check what exists first (`ls projects/<name>/`, `.git`, `CLAUDE.md`, `SCHEMA.md`) — read-then-update, never blind-overwrite. Then:

1. **Git:** `git init projects/<name>` if no `.git`; ensure `.gitignore` covers `.env`, `*.log`.
2. **Language setup** (confirm before running): Go `go mod init github.com/<user>/<name>` (entry `cmd/<name>/main.go`); Node `npm init -y` (`src/index.js`); Python `python -m venv .venv` (`src/main.py`). Only what doesn't already exist.
3. **Wiki scaffold:** `mkdir -p projects/<name>/{raw,wiki/{architecture,decisions,concepts,sources,queries}}`. `SCHEMA.md` from `projects/jscraper/SCHEMA.md` as template, adapted. `wiki/index.md` (empty category headers) and `wiki/log.md` (`## [DATE] setup | scaffold`) if absent. The framing allocation above applies here too: he writes the verdict-sentences in `decisions/` pages and makes the links; you maintain index, log, citations.
4. **Project CLAUDE.md:** name, description, wiki location, stack. If an existing one duplicates the global philosophy/modes, strip it to project-specific context and tell him what was removed.

---

## Finish (all three types)

List what was created, updated, and left unchanged — then stop. Don't pre-fill content that's his to write.
