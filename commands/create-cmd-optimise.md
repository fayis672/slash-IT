---
description: Optimise my PREVIOUS message into a better prompt, then save it as a slash command
argument-hint: <command-name> [--global | --project]
---

The user wants to take their **previous message** — the most recent user turn in this
conversation *before* this `/create-cmd-optimise` invocation — **improve it into a stronger
prompt**, and save the improved version as a reusable custom slash command.

Raw arguments: `$ARGUMENTS`

Do this:

1. Parse `$ARGUMENTS` into a **name** and an optional **scope flag**:
   - `--global` / `-g` / `global` -> save system-wide.
   - `--project` / `-p` / `project` -> save to the current project.
   - Everything else is the command name.
2. If no name is given, STOP and ask for one. A name is required.
3. **Determine where to save (scope):**
   - If a scope flag was given, use it.
   - Otherwise, ASK the user with AskUserQuestion: "Where should `/<name>` be saved?" with
     options **Global (all projects)** and **Project (this repo only)**.
   - Global path:  `~/.claude/commands/`
   - Project path: `<current working directory>/.claude/commands/` — create it if missing. If not
     in a project, fall back to Global and say so.
4. Normalize the name: lowercase, kebab-case, strip any leading `/` and `.md`.
5. Find the user's previous prompt (the message right before this call).
6. Rewrite it into a clear, well-structured, high-quality prompt while **preserving the original
   intent**. Apply prompt-engineering best practices:
   - Make the goal explicit and unambiguous.
   - Add useful structure (numbered steps, expected output format) where it helps.
   - Fix grammar/spelling and tighten vague wording.
   - Where the prompt clearly takes input, parameterize it with `$ARGUMENTS` (or `$1`, `$2`).
   - Do NOT add scope the user never asked for.
7. Briefly show the user a before/after diff of the prompt (1-3 lines is fine).
8. Add YAML frontmatter with a one-line `description` and, if you added parameters, an
   `argument-hint`.
9. Write the file to `<chosen path>/<name>.md`.
10. If that file already exists, show its current contents and ask before overwriting.
11. Confirm: print the saved file path, the scope, and that `/<name>` is now available.
