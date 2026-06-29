**I kept rewriting the same prompts in Claude Code. So I built a plugin to stop doing that.**

If you use Claude Code, you know the feeling: you craft a really good prompt — "review my code for security bugs and explain each issue" — it works great, and then it's gone. Next week you're typing it again from scratch.

So I built **slash-IT**, an open-source Claude Code plugin that turns any message you just typed into a reusable `/slash-command` — without leaving the chat.

Type a prompt → run one skill → it's saved as `/your-command` for next time.

It comes with 5 skills:
🔹 **create-cmd** — save your last message verbatim as a command
🔹 **create-cmd-optimise** — improve the prompt (clarity, structure), then save it
🔹 **create-cmd-instruct** — reshape the prompt with extra instructions, then save it
🔹 **create-cmd-args** — turn it into a parameterized command with `$ARGUMENTS`
🔹 **list-cmds** — see everything you've saved

You choose where each command lives — system-wide (available everywhere) or scoped to a single project. Every saved command is just a plain Markdown file, so it's portable, version-controllable, and easy to share with your team.

Install it in two lines:
```
/plugin marketplace add fayis672/slash-IT
/plugin install slash-it@slash-it
```

It's MIT-licensed and on GitHub. If you live in Claude Code like I do, this'll save you a surprising amount of friction.

👉 github.com/fayis672/slash-IT

Would love your feedback — and a ⭐ if it's useful.

#ClaudeCode #AI #DeveloperTools #OpenSource #Productivity #AIcoding #Anthropic
