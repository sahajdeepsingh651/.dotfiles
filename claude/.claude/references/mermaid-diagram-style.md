# Mermaid Diagram Style Guide

How I want architecture/system diagrams drawn. Extracted from the jscraper diagrams
(`~/obsidian_vault/projects/jscraper/wiki/architecture/architecture-diagram.md`) — read that file
for the full worked example if this guide is ambiguous on a case.

## Core rules, in priority order

1. **Shape encodes role, not node identity.** Pick shape by what the node *does in this diagram*,
   and reuse that shape consistently for every node playing that role. See vocabulary below.
2. **One diagram, one question.** Each diagram answers exactly one lens on the system. If you need
   a second question answered, draw a second diagram — don't overload one picture.
3. **Order diagrams broad → narrow.** Diagram 0 is the whole system in one frame. Later diagrams
   zoom into one path, one structural concern, or one design principle — each narrower or more
   abstract than the last, never a random walk.
4. **Number edges only when order matters.** A diagram tracing a sequence gets `-->|1|`, `-->|2|`, …
   on every edge in that path. A diagram showing pure structure (grouping, isolation, a principle)
   gets no numbers at all. Say explicitly in prose which kind a diagram is, so the absence of
   numbers doesn't look like an omission.
5. **Every diagram gets a prose walkthrough immediately after it.** One short line *before* the
   code block stating the lens/question. After the code block, a numbered list (matching the edge
   numbers) that narrates the flow, with **bolded node names** matching the diagram's labels
   exactly. If a step forks into two branches, say so explicitly and note both branches share that
   step's number.
6. **Dashed edges mark side interactions, not the main sequence:** async/network calls, lookups
   against shared/global state, or anything that isn't the primary path of work. Solid edges are
   the primary path.
7. **Subgraphs group by domain or category**, with an explicit `direction TB`/`direction LR` — never
   leave grouped nodes floating without a subgraph if they conceptually belong together (e.g. "one
   per domain" instances, or "shared state").

## Shape vocabulary

| Mermaid syntax     | Shape          | Use for                                          |
| ------------------- | -------------- | ------------------------------------------------- |
| `["Label"]`         | rectangle      | a process/component that does work                |
| `[["Label"]]`       | subroutine     | a queue or buffer                                 |
| `[("Label")]`       | cylinder       | a persistent store (when acting as *storage*)     |
| `{"Label"}`         | rhombus        | a decision/branch point (when acting as *a check*)|
| `{{"Label"}}`       | hexagon        | a gate/throttle (rate limiter, guard)             |
| `[/"Label"/]`       | parallelogram  | a registry/lookup table                           |
| `(["Label"])`       | stadium        | a start/seed/entry point                          |
| `(("Label"))`       | double circle  | an external system, outside the boundary of what you control |

**The same underlying entity can take a different shape in a different diagram** if it's playing a
different role there. In jscraper's diagram 0, the visited store is a cylinder (`VIS[("Visited
store")]`) because the diagram is about storage relationships. In diagram 1 (the single-worker
pipeline), the same store is drawn as a rhombus (`V{"Visited store"}`) because *that* diagram cares
about the new/seen branch it produces, not its persistence. Shape follows the question the diagram
is answering, not a fixed per-entity taxonomy.

## Edge vocabulary

- `A -->|1| B` — primary sequential flow, numbered.
- `A -.->|1| B` — a side interaction on the same numbered step (e.g. a lookup the main step
  depends on) — dashed keeps it visually secondary to the solid path.
- `A <-.-> B` — bidirectional shared-state access (multiple workers hitting one shared resource).
- `A -- "label · outcome" --> B` — a labeled branch out of a decision node (e.g. `FILT -- "6 ·
  match" --> RES`), used instead of a bare arrow when the edge itself needs to say *which* outcome
  it represents.

## Diagram sequence pattern (for a multi-diagram set)

0. **Full system, one frame.** Every component from the design doc, in a single flowchart. Numbered
   edges tracing the primary end-to-end sequence.
1. **One path, zoomed in.** What happens to a single unit of work (a request, a URL, a record) as
   it moves through the system — same numbering convention, restarted at 1.
2. **A structural concern.** E.g. isolation boundaries, what's replicated vs. shared. Unnumbered —
   this is about shape of the system, not sequence.
3. **A design principle, minimal.** Strip everything but the two things being contrasted (e.g.
   channels vs. mutexes). No arrows if the diagram is a pure grouping/contrast — the point is the
   grouping itself, not a flow.

Not every system needs all four. Draw the ones that add a genuinely new question; skip a zoom level
if diagram 0 already answers it.

## What not to do

- Don't force a sequence number onto a structural or conceptual diagram — it implies an order that
  isn't there.
- Don't reuse rectangle for everything because it's the default — pick shape deliberately per the
  vocabulary above.
- Don't skip the prose walkthrough — the diagram is notation, the walkthrough is what makes it
  checkable against the design doc.
- Don't draw undecided parts as if settled. If a component's behavior is genuinely open, either mark
  it and say so in a line above the diagram, or pull the open questions into a separate table below
  the diagrams (as jscraper does) rather than cluttering the picture itself.

## Applying this to a new system

1. List every component from the design doc.
2. For each, decide its role *in the diagram you're about to draw* (process? store? gate? decision?
   boundary?) and pick its shape from the vocabulary.
3. Draw diagram 0 first: everything, one frame, numbered end-to-end sequence.
4. Ask what questions diagram 0 leaves unanswered (a single item's path? an isolation boundary? a
   principle worth isolating?). Draw one diagram per genuine question, broad to narrow.
5. Write the one-line lens statement before each diagram and the numbered prose walkthrough after,
   before moving to the next diagram.
