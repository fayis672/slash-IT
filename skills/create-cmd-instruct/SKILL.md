---
description: Reshape my PREVIOUS message using extra instructions, then save it as a slash command
argument-hint: <command-name> | <how to change it> [--global | --project]
disable-model-invocation: true
---

The user wants to take their **previous message** — the most recent user turn in this
conversation *before* this invocation — **modify it according to extra instructions they provide
here**, and save the result as a reusable custom slash command.

Raw arguments: `$ARGUMENTS`

The arguments contain a command **name** and **instructions** for how to change the prompt,
separated by a `|` pipe. An optional scope flag may appear in the name part. Example:
`/slash-it:create-cmd-instruct daily-report --project | output a markdown table and ask for the date`

Do this:

1. Split `$ARGUMENTS` on the first `|`.
   - Left side = the command name (and optional scope flag).
   - Right side = the user's instructions for reshaping the prompt.
   If there is no `|`, treat the first token as the name and the rest as instructions.
2. From the left side, extract the **name** and any **scope flag**:
   - `--global` / `-g` / `global` -> system-wide.  `--project` / `-p` / `project` -> this project.
3. If the name is empty, STOP and ask for it (required). If the instructions are empty, ask what
   changes the user wants.
4. **Determine where to save (scope):**
   - If a scope flag was given, use it.
   - Otherwise ASK with AskUserQuestion: "Where should `/<name>` be saved?" -> **Global** or
     **Project**.
   - Global path:  `~/.claude/commands/`
   - Project path: `<current working directory>/.claude/commands/` — create if missing; fall back
     to Global if not in a project and say so.
5. Normalize the name: lowercase, kebab-case, strip any leading `/` and `.md`.
6. Find the user's previous prompt (the message right before this call).
7. Produce a new prompt = the previous prompt **transformed according to the instructions**, plus
   light optimisation (clarity, structure, grammar) while honoring the original intent. Parameterize
   with `$ARGUMENTS`/`$1`/`$2` where it makes the command reusable.
8. Briefly show the user the resulting prompt so they can see what was saved.
9. Add YAML frontmatter with a one-line `description` and an `argument-hint` if parameters exist.
10. Write the file to `<chosen path>/<name>.md`.
11. If that file already exists, show its current contents and ask before overwriting.
12. Confirm: print the saved file path, the scope, and that `/<name>` is now available.
