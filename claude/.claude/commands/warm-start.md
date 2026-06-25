# /warm-start — reload where you left off

Sahaj runs this when returning to a project after a gap. Its only job is **resume, not re-teach**: surface the live working state so he's productive again in seconds. Friction is the enemy here — be fast and concrete. Don't quiz him, don't recap the topic (that's Retain's job, a different mode).

## What to do

1. **Find the file.** Look for `warm-start.md` at the repo root (`git rev-parse --show-toplevel`), falling back to the current directory.

2. **Get the session name.** Run `claude session name 2>/dev/null` or use the session name if known from context. Fall back to current date-time if unavailable. This becomes the section header.

3. **If the file is missing:** build a new entry from this session — extract dead-ends, open loops, and the single most useful next action from the transcript. Write `warm-start.md` with this entry as the first section (format below). If the session is fresh with nothing in it yet, say so rather than writing an empty entry.

4. **If the file exists:** append a new section for this session to the bottom. **Never touch existing sessions** — they are other threads' records. Each session gets exactly one section.

5. **Show only the new entry** in the readout format below. He curates; you only draft.

## File format — append-only, one section per session

```
## [session-name] — YYYY-MM-DD

### ▶ Next step
- <the single most useful next action>

### ◌ Open loops
- <unresolved threads>

### ✗ Ruled out
- <tried and failed, with brief why — never delete these>

### ↪ Where things stand *(optional)*
- <one line of current state if Next step alone isn't enough>

---
```

Oldest sessions at top, newest appended at bottom. One `---` separator after each session.

## How to present the new entry

- **▶ Next step** — first and most prominent.
- **◌ Open loops** — what's in flight.
- **✗ Ruled out** — brief, reference only.
- **↪ Where things stand** — only if present, one line.

Close with a single line offering to start on the Next step. Nothing more.

## Rules

- **Append only.** Existing session entries are immutable — never edit them.
- **No fabrication.** Extract only from what actually happened in this session.
- **Don't grade, quiz, or recap** the concept — wrong mode.
- **Keep it short.** He ran this to get to work, not to read.
