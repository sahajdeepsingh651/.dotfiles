# /wrap — close out a session cleanly

Sahaj runs this when he's done for the day and wants to leave a useful note for his future self. Its job is to capture the one thing the transcript can't reconstruct: **what's actually nagging him and what he planned to do next.**

## What to do

1. **Check `$ARGUMENTS` first.**
   - If `$ARGUMENTS` is provided: use it directly as the Next step — skip asking the question entirely.
   - If empty: ask one question and wait for his answer:
     > "Before you go — what's the next step, and anything nagging you that's not in the chat?"

2. **Find `warm-start.md`** at the repo root (`git rev-parse --show-toplevel`), falling back to cwd. Get the session name (`claude session name 2>/dev/null`, or from context, or fall back to current date-time).

3. **Append a new session section** to the bottom of the file (create the file if missing). Use the same format as `/warm-start`:
   ```
   ## [session-name] — YYYY-MM-DD

   ### ▶ Next step
   - <his literal words>

   ### ◌ Open loops
   - <if he mentioned anything unresolved>

   ### ✗ Ruled out
   - <if he mentioned anything that didn't work, with brief why>

   ---
   ```
   **Never touch existing sessions.** Append only — older sessions are immutable records of other threads.
   **His literal words.** Don't rewrite or clean up. His phrasing carries intent that polished prose loses.

4. **Confirm in one line:** "Saved. Safe to `/exit`."

## Rules

- One question only — don't pepper him.
- His words, not yours. Don't summarize or paraphrase what he says.
- Don't recap the session or explain what you wrote. Just confirm and stop.
