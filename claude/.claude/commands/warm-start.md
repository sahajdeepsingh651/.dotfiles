# /warm-start — reload where you left off

Sahaj runs this when returning to a project after a gap. Its only job is **resume, not re-teach**: surface the live working state so he's productive again in seconds. Friction is the enemy here — be fast and concrete. Don't quiz him, don't recap the topic (that's Retain's job, a different mode).

## What to do

1. **Find the file.** Look for `warm-start.md` at the repo root (`git rev-parse --show-toplevel`), falling back to the current directory.
2. **If it's missing:** build it from the *current* session. Read back over what's happened so far and write `warm-start.md` at the repo root, in the template format (Next step / Open loops / Ruled out / Where things stand), capturing the dead-ends tried, the threads left open, and the single most useful next action. Then show the result (below) so he can trim it — he curates, you only draft. Caveat: this reads the *current* session only. If he's just logged in and nothing has happened yet, there's nothing to extract — say so rather than writing an empty file.
3. **If it exists:** read it and **internalize it** — the rest of this session should be context-aware so you can actually help him act on the Next step, not just print it back.

## How to present it — like `/usage`: a clean readout, not a file dump

Lead with what gets him moving, in this order:

- **▶ Next step** — first and most prominent. The one thing to do now.
- **◌ Open loops** — what's in flight or unresolved.
- **✗ Ruled out** — brief, as reference only ("already tried, don't retry"). Don't expand it unless he asks.
- **↪ Where things stand** — only if present, and only a line.

Close with a single line offering to start on the Next step. Nothing more.

## Rules

- **No fabrication.** Reading: display only what's in the file; if a section is empty, say so. Creating: extract only from what actually happened this session — don't invent beyond the transcript.
- **Don't grade, quiz, or recap** the concept — wrong mode.
- **Keep it short.** He ran this to get to work, not to read.
