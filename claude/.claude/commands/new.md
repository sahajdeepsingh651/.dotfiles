# /new — one entry point for anything new in the vault

Replaces `/new-project` and `/new-study`. One triage question decides everything else.

**Triage first.** Ask (or confirm from `$ARGUMENTS`): **"Build, learn, standalone thought, discourse, or experiment?"**

- **Build** → `projects/<name>/` — something with code and a goal
- **Learn** → `studies/<slug>/` — a domain or source being digested
- **Standalone** → `notes/<slug>.md` — one decided thought; a single file, no folder, no scaffold
- **Discourse** → `discourse/<slug>/` — a live back-and-forth being forged into a
  protocol or model, not yet a full study, no code involved; it measures nothing of its own
- **Experiment** → `experiments/<slug>/` — a self-experiment, method applied to yourself: a
  conjecture tested against *your own dated observations gathered over time*. Deliverable is a
  finding/model — not software (that's a Project), not a digested source (that's a Study), not a
  rule forged from pure dialogue (that's Discourse).

**Discourse vs Experiment** — the line is *self-generated observations vs. ingested evidence*:
a Discourse measures nothing of its own (the argument's trail is the evidence); an Experiment
runs something and logs its own dated observations. Generating your own measurements over
multiple sessions → Experiment.

Vault rules (from `meta/STRUCTURE.md`): folder = what a note *is*; frontmatter = what varies. **Promote a cluster, don't force a domain** — a lone concept is a note; when several notes cluster around a subject, *suggest* promoting them into a study (Sahaj decides). And never scaffold ahead of need: **a file earns existence by forcing thought when written, or by being genuinely reread.** When in doubt, create less.

**Framing allocation (all types):** he owns conjectures, crux/verdict sentences, the spine, and all
`[[links]]` (linking is thinking — suggest, never make); you own notation/structure, citations, logs,
resistance-log records, and provenance — so borrowed ideas are never mistaken for his.

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

## Discourse → `discourse/<slug>/`

For a live dialogue that's forging a protocol, heuristic, or model out of a question he brought
— not a source being digested (that's a Study), not a self-experiment logging its own data
(that's an Experiment), and not something with code (that's a Project).
The container exists because the *trail of the argument* — where a conjecture got refuted, what
replaced it — is as load-bearing as the final rule, and both need a home separate from each
other so the rule stays lean.

Ask one at a time:

1. **Topic/slug.**
2. **The question or belief that started it**, in his words.

Check what exists first (`ls discourse/<slug>/`) — read-then-update. Then create
**one file and nothing else**:

```
discourse/<slug>/
  <slug>.md              ← his opening conjecture / the emerging model — HIS words
```

**Everything below is on-need — never scaffold it ahead of the trigger** (his rule: a file
earns existence by forcing thought when written). Both existing threads (`coding-with-ai`,
`leaving-well`) grew their subfolders *mid-thread*, not at creation. Create each only when its
trigger actually fires:

- **`conjectures/YYYY-MM-DD-<slug>.md`** — when the model first *revises under resistance*.
  Move the trail here; `<slug>.md` becomes the clean protocol. Append a new dated file on each
  later revision, never edit an old one — the diff between snapshots is the learning. Shape
  below; worked example in `coding-with-ai/conjectures/`.
- **`<slug>-provenance.md`** — when borrowed ideas need separating from his, so the protocol
  stays lean and attribution keeps its own lifecycle. Buckets: **mine, derived** /
  **added as resistance/notation** / **external anchors** (only if sources came in — flag
  UNVERIFIED there until checked).
- **`raw/`** — when external evidence gets pulled in. Immutable; flag UNVERIFIED until checked.

No `wiki/`, no index, no SCHEMA.md — this is lighter than a Study by design; promote to one only
if the thread earns a real cluster (Principle 4 above).

### Conjecture file shape (when one is created)

```yaml
---
date: YYYY-MM-DD
container: discourse/<slug>
status: raw — <one line: what's held up, what hasn't>
tier-survived: 0 (Sahaj + LLM only)
---
```

Then, in order: **his raw conjecture** (verbatim, blockquoted) → **structure held as notation**
(clearly marked as yours, not his content) → **resistance log** (each round: his move, what
refuted it, what replaced it — dated if the thread spans sessions) → **the crux**, if one
emerged → **gap preserved** (don't smooth over what a fix didn't resolve) → **refined
conjecture** → **next conjecture opened**, if the thread forked further.

---

## Experiment → `experiments/<slug>/`

A self-experiment — **method applied to yourself, n=1**. He runs something, logs what happens, and
tests a conjecture against *his own dated observations gathered over time*. Distinct from a Study
(digests an external source), a Discourse (forges a rule from dialogue, no data), and a Project
(deliverable is software). Here the deliverable is a **finding or model** — even when the
experiment grows a small tool to run itself.

> **Keep the conclusion expensive.** ⟵ *his sentence to rewrite.* The finding must be something
> common sense could not hand him — a number, or a model that can be *wrong*. If the conclusion is
> "there are peaks, you can't work forever," the wrong experiment was run. (Worked example:
> `experiments/devtime/devtime.md` → "Keep the conclusion expensive.")

Ask one at a time:

1. **Topic/slug.**
2. **The conjecture** — what he predicts, in his words, sharp enough to be wrong.
3. **The observable** — the signal each run logs (may stay rough at first).

Check what exists first (`ls experiments/<slug>/`) — read-then-update. Then scaffold the
**minimum**:

```
experiments/<slug>/
  <slug>.md    ← design + protocol + the conjecture arc (v0→v1→…), his words. The conjecture
                 history is folded IN HERE — no separate conjectures/ dir (unlike Discourse).
  raw/         ← HIS OWN dated observations, append-only, one file per run/session. Self-
                 generated data — NOT external sources (that meaning of raw/ belongs to a Study).
```

`devtime/` is the worked template — follow its shape. No `wiki/`, no index, no SCHEMA.md at
scaffold time.

On-need, never ahead of the trigger:

- **`how-to-run.md`** — only if the experiment has tooling/automation to launch (as devtime does);
  skip it for a pen-and-paper protocol.
- **`warm-start.md`** — experiments span sessions, so this is the type most likely to want it. But
  **don't create it unprompted** — its absence means "not enrolled" (global rule). Ask *"Enroll
  this in warm-start?"* and scaffold only on a yes.

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

### SCHEMA.md template

Copy `~/.claude/references/study-schema-template.md`, fill the `<...>` placeholders, and write
it as the study's `SCHEMA.md`.

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

## Finish (all five types)

List what was created, updated, and left unchanged — then stop. Don't pre-fill content that's his to write.
