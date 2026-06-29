# slash-IT

A **Claude Code plugin**. Turn any message you just typed into a reusable slash command —
without leaving the chat. Write a prompt, then run one of these skills to save it as
`/your-command` for next time.

## Skills

Because plugin skills are namespaced, you invoke them as `/slash-it:<name>`:

| Skill | What it does |
|---|---|
| `/slash-it:create-cmd <name>` | Saves your **previous message verbatim** as a new command. |
| `/slash-it:create-cmd-optimise <name>` | **Improves** your previous prompt (clarity, structure, grammar), then saves it. |
| `/slash-it:create-cmd-instruct <name> \| <instructions>` | **Reshapes** your previous prompt using extra instructions, then saves it. |
| `/slash-it:create-cmd-args <name>` | Turns your previous prompt into a **parameterized** command (`$ARGUMENTS`, `$1`, `$2`). |
| `/slash-it:list-cmds` | Lists all your custom commands (global + project) with descriptions. |

> A **name is required** for every `create-cmd*` skill.

The commands these skills *create* are plain, un-namespaced slash commands (e.g. `/security-check`)
saved to your `~/.claude/commands/` or project `.claude/commands/` directory.

## Install

### From a marketplace (recommended for sharing)

```text
/plugin marketplace add fayis672/slash-IT
/plugin install slash-it@slash-it
```

Then enable it from `/plugin` if it isn't already. Run `/reload-plugins` after updates.

### From a git clone

Clone the repo, then load the plugin directly from the cloned directory:

```bash
git clone https://github.com/fayis672/slash-IT.git
claude --plugin-dir ./slash-IT
```

Pull the latest changes with `git pull`, then run `/reload-plugins` to pick them up.

### Local development / testing

Load the plugin directly from this directory without installing:

```bash
claude --plugin-dir /path/to/slash-IT
```

Iterate on the skills, then run `/reload-plugins` to pick up changes.

## Choosing where saved commands go (scope)

Each `create-cmd*` skill can save the command it creates either system-wide or to the current
project:

- `--global` / `-g` → `~/.claude/commands/` (available everywhere)
- `--project` / `-p` → `<current folder>/.claude/commands/` (this repo only)
- **no flag** → it asks you which one before saving

If you choose project scope but aren't in a project, it falls back to global.

## Usage examples

```text
# Save the previous prompt exactly as-is, system-wide
You: Review my code for security bugs and explain each issue.
You: /slash-it:create-cmd security-check --global

# Optimise the previous prompt, ask where to save
You: write some tests for my code
You: /slash-it:create-cmd-optimise write-tests

# Reshape the previous prompt with instructions (note the | pipe), project-only
You: summarise this file
You: /slash-it:create-cmd-instruct summarise -p | output 5 bullet points and a TL;DR line

# Parameterize the variable parts into arguments
You: Translate utils.js to Python
You: /slash-it:create-cmd-args translate --global
#   -> creates /translate, called like:  /translate utils.js Python
```

## How a saved command looks

Each command this plugin creates is just a Markdown file. The filename (without `.md`) is the
command name. Optional YAML frontmatter sets the description and argument hint:

```markdown
---
description: Review my recent code for security bugs
argument-hint: <filename>
---

Review $ARGUMENTS for security vulnerabilities and explain each issue clearly.
```

## Plugin structure

```text
slash-IT/
├── .claude-plugin/
│   ├── plugin.json        # plugin manifest (name, version, metadata)
│   └── marketplace.json   # marketplace catalog so it can be installed
└── skills/
    ├── create-cmd/SKILL.md
    ├── create-cmd-args/SKILL.md
    ├── create-cmd-instruct/SKILL.md
    ├── create-cmd-optimise/SKILL.md
    └── list-cmds/SKILL.md
```

## Tips

- Type `/` in Claude Code to see all available skills and commands.
- `$ARGUMENTS` = everything passed; `$1`, `$2`, … = individual positional arguments.
- After installing or editing the plugin, run `/reload-plugins` for changes to appear.

## License

MIT — see [LICENSE](LICENSE).
