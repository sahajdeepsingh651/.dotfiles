Ask the user for the following, one at a time:

1. **Project name**
2. **Language/stack** — if not decided yet, skip and move on. If Go, confirm GitHub username for module path.
3. **Wiki location** — where should the knowledge base live? Default suggestion: `/home/sahaj/obsidian_vault/<project-name>/`
4. **One-line project description** — for the CLAUDE.md and wiki

Once you have all answers, **check what already exists before touching anything:**

```bash
ls <project-name>/           # does the project dir exist?
ls <project-name>/.git       # is it already a git repo?
ls <project-name>/CLAUDE.md  # does a project CLAUDE.md exist?
ls <wiki-location>/SCHEMA.md
ls <wiki-location>/wiki/index.md
ls <wiki-location>/wiki/log.md
```

For each thing that already exists — read it first, then update rather than overwrite. For each thing that doesn't exist — create it fresh.

---

### Step 1 — Git

**If `.git` does not exist:**
```bash
git init <project-name>
```

**If `.gitignore` does not already contain `.env`:**
```bash
printf ".env\n*.log\n" >> <project-name>/.gitignore
```

---

### Step 2 — Language setup (skip if language not decided)

If a language was given, suggest the standard project initialisation for that language — but ask the user to confirm before running. Common patterns:

- **Go:** `go mod init github.com/<username>/<project-name>`, entry point at `cmd/<project-name>/main.go`
- **Node:** `npm init -y`, entry point at `src/index.js`
- **Python:** `python -m venv .venv`, entry point at `src/main.py`

Only run what doesn't already exist.

---

### Step 3 — Wiki scaffold

Always safe to run (idempotent):
```bash
mkdir -p <wiki-location>/wiki/{architecture,decisions,concepts,sources,queries}
mkdir -p <wiki-location>/raw
```

**SCHEMA.md:**
- If it does not exist: create using `/home/sahaj/obsidian_vault/webcrawler/SCHEMA.md` as a template, updated for this project.
- If it exists: read it, update only what's stale (project name, description, stack).

**wiki/index.md:**
- If it does not exist: create with empty category headers.
- If it exists: leave it — it has live content.

**wiki/log.md:**
- If it does not exist: create with `## [DATE] setup | Initial scaffold`.
- If it exists: append `## [DATE] setup | Revisited via /new-project` only if something changed.

---

### Step 4 — Project CLAUDE.md

**If it does not exist:** create with project name, description, wiki location, and stack (if decided).

**If it exists:** read it. If it contains mode system or philosophy (now in global `~/.claude/CLAUDE.md`), remove the redundant sections. Keep only project-specific context. Tell the user what was removed.

---

### Step 5 — Confirm

List what was created, what was updated, and what was left unchanged. Ask: "Anything to add to the wiki before we start?"
