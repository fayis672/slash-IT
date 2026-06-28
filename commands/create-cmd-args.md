---
description: Turn my PREVIOUS message into a PARAMETERIZED slash command with $ARGUMENTS slots
argument-hint: <command-name> [--global | --project]
---

The user wants to take their **previous message** — the most recent user turn in this
conversation *before* this `/create-cmd-args` invocation — and save it as a reusable custom
slash command that is **parameterized**, so the variable parts become arguments.

Raw arguments: `$ARGUMENTS`

Do this:

1. Parse `$ARGUMENTS` into a **name** and an optional **scope flag**:
   - `--global` / `-g` / `global` -> system-wide.
   - `--project` / `-p` / `project` -> current project.
   - Everything else is the command name.
2. If no name is given, STOP and ask for one. A name is required.
3. **Determine where to save (scope):**
   - If a scope flag was given, use it.
   - Otherwise ASK with AskUserQuestion: "Where should `/<name>` be saved?" -> **Global** or
     **Project**.
   - Global path:  `~/.claude/commands/`
   - Project path: `<current working directory>/.claude/commands/` — create if missing; fall back
     to Global if not in a project and say so.
4. Normalize the name: lowercase, kebab-case, strip any leading `/` and `.md`.
5. Find the user's previous prompt (the message right before this call).
6. Identify the parts of the prompt that are **specific values likely to change each run** — a
   filename, a topic, a function/variable name, a language, a count, etc. Replace them with
   placeholders:
   - One variable  -> `$ARGUMENTS`.
   - Multiple variables -> `$1`, `$2`, `$3` in the order they should be passed.
   Keep the fixed instructions intact.
7. Add YAML frontmatter with a one-line `description` and an `argument-hint` listing the
   placeholders in order, e.g. `argument-hint: <filename> <language>`.
8. Show the user the parameterized prompt and how to call it (e.g. `/<name> utils.js python`).
9. Write the file to `<chosen path>/<name>.md`.
10. If that file already exists, show its current contents and ask before overwriting.
11. Confirm: print the saved file path, the scope, and that `/<name>` is now available.
