# slash-IT

Turn any message you just typed in **Claude Code** into a reusable slash command —
without leaving the chat. Write a prompt, then run one of these commands to save it
as `/your-command` for next time.

## Commands

| Command | What it does |
|---|---|
| `/create-cmd <name>` | Saves your **previous message verbatim** as a new command. |
| `/create-cmd-optimise <name>` | **Improves** your previous prompt (clarity, structure, grammar), then saves it. |
| `/create-cmd-instruct <name> \| <instructions>` | **Reshapes** your previous prompt using extra instructions, then saves it. |
| `/create-cmd-args <name>` | Turns your previous prompt into a **parameterized** command (`$ARGUMENTS`, `$1`, `$2`). |
| `/list-cmds` | Lists all your custom commands (global + project) with descriptions. |

> A **name is required** for every `create-cmd*` command.

## Install

### Global (available in every project)

Copy the command files into your user commands directory:

```bash
# macOS / Linux
mkdir -p ~/.claude/commands
cp commands/*.md ~/.claude/commands/
```

```powershell
# Windows (PowerShell)
New-Item -ItemType Directory -Force "$HOME\.claude\commands" | Out-Null
Copy-Item commands\*.md "$HOME\.claude\commands\"
```

Or run the helper:

```bash
bash install.sh            # macOS / Linux
```
```powershell
./install.ps1              # Windows
```

### Project-only (share with a repo / team)

Copy the files into your project instead:

```bash
mkdir -p .claude/commands
cp commands/*.md .claude/commands/
```

Then commit `.claude/commands/` so collaborators get the commands too.

## Choosing where saved commands go (scope)

Each `create-cmd*` command can save the command it creates either system-wide or
to the current project:

- `--global` / `-g` → `~/.claude/commands/` (available everywhere)
- `--project` / `-p` → `<current folder>/.claude/commands/` (this repo only)
- **no flag** → it asks you which one before saving

If you choose project scope but aren't in a project, it falls back to global.

## Usage examples

```text
# Save the previous prompt exactly as-is, system-wide
You: Review my code for security bugs and explain each issue.
You: /create-cmd security-check --global

# Optimise the previous prompt, ask where to save
You: write some tests for my code
You: /create-cmd-optimise write-tests

# Reshape the previous prompt with instructions (note the | pipe), project-only
You: summarise this file
You: /create-cmd-instruct summarise -p | output 5 bullet points and a TL;DR line

# Parameterize the variable parts into arguments
You: Translate utils.js to Python
You: /create-cmd-args translate --global
#   -> creates /translate, called like:  /translate utils.js Python
```

## How a saved command looks

Each command is just a Markdown file. The filename (without `.md`) is the command
name. Optional YAML frontmatter sets the description and argument hint:

```markdown
---
description: Review my recent code for security bugs
argument-hint: <filename>
---

Review $ARGUMENTS for security vulnerabilities and explain each issue clearly.
```

## Tips

- Type `/` in Claude Code to see all available commands.
- Subfolders create namespaces: `commands/git/commit.md` → `/git:commit`.
- After creating a new command, reopen the `/` menu for it to appear.
- `$ARGUMENTS` = everything passed; `$1`, `$2`, … = individual positional arguments.

## License

MIT — see [LICENSE](LICENSE).
