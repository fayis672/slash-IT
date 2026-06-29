# Stop Rewriting the Same Prompts: Meet slash-IT for Claude Code

### A tiny open-source plugin that turns any message you just typed into a reusable slash command.

---

#### The problem nobody talks about

If you spend real time in [Claude Code](https://claude.com/claude-code), you've built up a personal library of prompts in your head. The one that reviews code for security issues. The one that writes tests the way *you* like them. The one that summarizes a file into exactly five bullet points and a TL;DR.

The trouble is, that library lives nowhere. Every prompt is typed fresh, slightly differently each time, and the good ones are forgotten the moment the session ends. You're re-deriving your own best work over and over.

Slash commands are Claude Code's answer to this — but creating them means stopping what you're doing, opening a file, writing YAML frontmatter, and getting the format right. By the time you've done that, the flow is broken.

I wanted something faster: capture the prompt I *just* wrote, the moment I realize it's worth keeping, without leaving the chat.

So I built **slash-IT**.

---

#### What it does

slash-IT is a Claude Code plugin. You write a prompt, and then run one short skill to save that prompt as a `/slash-command` you can reuse forever.

That's the whole idea. The message you just typed becomes a permanent, named command.

It ships with five skills:

| Skill | What it does |
|---|---|
| `create-cmd <name>` | Saves your previous message **verbatim** as a new command. |
| `create-cmd-optimise <name>` | **Improves** your prompt — clarity, structure, grammar — then saves it. |
| `create-cmd-instruct <name> \| <instructions>` | **Reshapes** your prompt using extra instructions, then saves it. |
| `create-cmd-args <name>` | Turns your prompt into a **parameterized** command with `$ARGUMENTS`, `$1`, `$2`. |
| `list-cmds` | Lists every custom command you've saved, with descriptions. |

Because plugin skills are namespaced, you invoke them as `/slash-it:create-cmd`, and so on.

---

#### How it feels in practice

Say you just ran a great security review:

```
You: Review my code for security bugs and explain each issue.
You: /slash-it:create-cmd security-check --global
```

Done. From now on, `/security-check` runs that prompt anywhere.

Want Claude to clean up a rough prompt before saving it?

```
You: write some tests for my code
You: /slash-it:create-cmd-optimise write-tests
```

Need to capture the *shape* of a task but make the specifics swappable?

```
You: Translate utils.js to Python
You: /slash-it:create-cmd-args translate --global
#   → creates /translate, called like:  /translate utils.js Python
```

The variable parts become arguments. One captured prompt, infinitely reusable.

---

#### Where your commands live

Every `create-cmd*` skill lets you choose scope:

- `--global` / `-g` → `~/.claude/commands/` — available in every project.
- `--project` / `-p` → `.claude/commands/` — scoped to the current repo.
- **No flag** → it asks you before saving.

Project scope is the underrated one: commit your `.claude/commands/` folder and your whole team inherits the same vocabulary of commands. Onboarding a new dev becomes "type `/` and look around."

---

#### It's just Markdown

There's no magic format to learn. Every command slash-IT creates is a plain Markdown file. The filename is the command name; optional YAML frontmatter sets the description and argument hint:

```markdown
---
description: Review my recent code for security bugs
argument-hint: <filename>
---

Review $ARGUMENTS for security vulnerabilities and explain each issue clearly.
```

That means your commands are portable, diff-able, reviewable in a PR, and yours to edit by hand whenever you want. No lock-in.

---

#### Installing it

From the marketplace (recommended):

```text
/plugin marketplace add fayis672/slash-IT
/plugin install slash-it@slash-it
```

Or from a clone, if you'd rather hack on it:

```bash
git clone https://github.com/fayis672/slash-IT.git
claude --plugin-dir ./slash-IT
```

After installing or editing, run `/reload-plugins` to pick up changes.

---

#### Why I think this matters

The best AI workflows aren't about one clever prompt — they're about *compounding* the good ones. Every time you save a prompt instead of retyping it, you're turning a one-off into infrastructure. slash-IT just removes the friction between "that worked well" and "now it's saved."

It's MIT-licensed and open source. If it saves you even a few re-typed prompts a week, that adds up fast.

👉 **[github.com/fayis672/slash-IT](https://github.com/fayis672/slash-IT)**

If you try it, I'd genuinely love your feedback — issues, ideas, and stars all welcome.
