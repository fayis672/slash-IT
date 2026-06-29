---
description: List all my custom slash commands with their descriptions. Use when the user wants to see, browse, or review the custom slash commands they have saved.
---

List the user's custom slash commands so they can see what they've saved.

Do this:

1. Read the user's global commands directory `~/.claude/commands/` and find every `*.md` file
   (ignore `README.md`).
2. Also check the current project's `.claude/commands/` directory if it exists.
3. For each command file, show:
   - the command name (filename without `.md`, prefixed with `/`),
   - its `description` from the frontmatter (or the first line if no frontmatter),
   - whether it is **global** (user) or **project**.
4. Present them as a simple, readable list grouped by global vs project.
5. If there are none, say so and remind the user they can create one with `/slash-it:create-cmd <name>`.
