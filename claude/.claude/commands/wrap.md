# /wrap — close out a session cleanly

Sahaj runs this when he's done for the day and wants to leave a useful note for his future self. Its job is to capture the one thing the transcript can't reconstruct: **what's actually nagging him and what he planned to do next.**

## What to do

1. **Ask one question, wait for his answer:**
   > "Before you go — what's the next step, and anything nagging you that's not in the chat?"
   One question. Don't ask three things. Wait for his reply.

2. **Find `warm-start.md`** at the repo root (`git rev-parse --show-toplevel`), falling back to cwd.
   - If missing: create it first (bootstrap from this session, same as `/warm-start` does), then apply his answer on top.

3. **Write his answer in:**
   - His literal words go into **▶ Next step** (replace whatever's there).
   - If he mentions something that didn't work or a path he's ruling out, append it to **✗ Ruled out**.
   - If he mentions something unresolved, add it to **◌ Open loops**.
   - **Don't rewrite or clean up his words.** His phrasing is the point — it carries intent that polished prose loses.

4. **Confirm in one line:** "Saved. Safe to `/exit`."

## Rules

- One question only — don't pepper him.
- His words, not yours. Don't summarize or paraphrase what he says.
- Don't recap the session or explain what you wrote. Just confirm and stop.
