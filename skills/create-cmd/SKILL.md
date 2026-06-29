---
description: Save my PREVIOUS message verbatim as a reusable slash command (name required)
argument-hint: <command-name> [--global | --project]
disable-model-invocation: true
---

The user wants to save their **previous message** — the most recent user turn in this
conversation *before* this invocation — as a reusable custom slash command, **unchanged**.

Raw arguments: `$ARGUMENTS`

Do this:

1. Parse `$ARGUMENTS` into a **name** and an optional **scope flag**:
   - `--global` / `-g` / the word `global` -> save system-wide.
   - `--project` / `-p` / the word `project` -> save to the current project.
   - Everything else is the command name.
2. If no name is given, STOP and ask for one, e.g. `/slash-it:create-cmd fix-bug`. A name is required.
3. **Determine where to save (scope):**
   - If a scope flag was given, use it.
   - Otherwise, ASK the user with AskUserQuestion: "Where should `/<name>` be saved?" with
     options **Global (all projects)** and **Project (this repo only)**.
   - Global path:  `~/.claude/commands/`  (the user's home `.claude/commands` directory)
   - Project path: `<current working directory>/.claude/commands/` — create this folder if it
     doesn't exist. If there is no project / not in a repo, fall back to Global and say so.
4. Normalize the name: lowercase, kebab-case, strip any leading `/` and the `.md` extension.
5. Find the user's previous prompt (the message right before this call). Use its text **verbatim**
   as the command body. Do NOT rewrite, optimise, or summarize it.
6. Add YAML frontmatter with a one-line `description` derived from the prompt.
7. Write the file to `<chosen path>/<name>.md`.
8. If that file already exists, show its current contents and ask before overwriting.
9. Confirm: print the saved file path, the scope (global/project), and that `/<name>` is now
   available (reopen the `/` menu for it to appear).
