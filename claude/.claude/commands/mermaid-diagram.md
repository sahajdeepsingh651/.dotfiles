# /mermaid-diagram — draw a system diagram in the house mermaid style

Applies `~/.claude/references/mermaid-diagram-style.md` (the style extracted from the jscraper
architecture diagrams) to whatever `$ARGUMENTS` or the surrounding conversation describes.

Diagrams drawn by this command are **vault artifacts, not chat scratch** — they always end up
written to a file in `~/obsidian_vault/`, never left only in the conversation.

## What to do

0. **Establish the destination — before drawing anything.**
   - Check whether this work belongs to an existing vault project: compare the current repo/cwd
     name (`git rev-parse --show-toplevel` basename, or the project named in `$ARGUMENTS` / the
     conversation) against `~/obsidian_vault/projects/*/`.
   - **Match found** → destination is `~/obsidian_vault/projects/<slug>/wiki/architecture/`. Use it
     without asking.
   - **No match / ambiguous / not obviously tied to one project** → ask Sahaj directly: "Which
     project does this belong to — give the slug, or 'none' to just draw it in chat." Never guess a
     project. If he says "none," skip step 6 (no vault write) and stop after step 5.

1. **Get the source material.**
   - If `$ARGUMENTS` is non-empty, treat it as the thing to diagram — pasted text, a description,
     a file path, or a pointer to something already discussed in this conversation.
   - If empty, ask what to diagram: a design doc, a chunk of code, a system just discussed.

2. **Load the style guide** (`~/.claude/references/mermaid-diagram-style.md`) if it isn't already
   in context this session. Follow it exactly — shape-by-role, numbered edges only for sequence,
   a prose walkthrough after every diagram, broad → narrow ordering across a multi-diagram set.

3. **Extract components and roles** from the source material before writing any mermaid syntax.
   For each node, decide what it's playing *in the diagram you're about to draw* — process, store,
   decision, gate, registry, entry point, boundary — per the shape vocabulary table in the style
   guide. The same entity can take a different shape in a different diagram if its role changes.

4. **Decide how many diagrams.** Default to one (diagram 0: full system, one frame). Add a zoom
   — single-path, structural, or conceptual — only if it answers a genuinely new question that
   diagram 0 doesn't. Don't pad with diagrams that repeat what's already visible.

5. **Draw.** One lens-sentence before each code block, stating the question that diagram answers.
   Numbered edges (`-->|1|`, `-->|2|`, …) only on diagrams that trace a sequence; none on
   structural or conceptual diagrams. Dashed edges for side/async/lookup interactions, not the
   main path. Write the walkthrough immediately after each diagram: numbered prose matching the
   edge numbers, **bolded node names** matching the diagram's labels exactly. Call out forks
   explicitly (a step that branches to two outcomes still shares one step number).

6. **File it, at the destination fixed in step 0.**
   - Target file: `wiki/architecture/architecture-diagram.md` inside the project's folder — this
     matches the existing convention (see jscraper's, alarmy's, or enlight-agent's `wiki/architecture/`
     for the exemplar).
   - **File already exists** → append the new diagram(s) as new section(s) continuing the existing
     numbering and heading style; bump the `updated:` date in its frontmatter. Don't fork a second
     file for the same project.
   - **File doesn't exist yet** → create it matching the frontmatter and layout of the existing
     exemplar files (`id`/`aliases`/`tags` frontmatter, a `tags`/`updated` line, a short intro
     paragraph, then the diagram sections). Leave `[[links]]` to related pages as bare suggestions
     in prose rather than inventing wiki pages that don't exist yet.
   - Confirm the exact path written to, in one line, at the end.

## Rules

- Never skip the prose walkthrough — an un-narrated diagram doesn't ship.
- Don't invent a sequence number for a structural/conceptual diagram just for consistency — state
  explicitly which kind each diagram is.
- If the source material is too thin to assign shapes with confidence, ask rather than guessing at
  the architecture.
- Never guess the destination project or silently skip the vault write — if step 0 is ambiguous,
  ask. Silence defaults to "draw only," never to "file somewhere plausible."
