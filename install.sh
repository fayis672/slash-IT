#!/usr/bin/env bash
# Install the prompt->command slash commands globally for Claude Code.
set -euo pipefail

DEST="$HOME/.claude/commands"
SRC="$(cd "$(dirname "$0")/commands" && pwd)"

mkdir -p "$DEST"
cp "$SRC"/*.md "$DEST"/

echo "Installed commands to $DEST:"
ls -1 "$SRC" | sed 's/\.md$//' | sed 's#^#  /#'
echo "Reopen the / menu in Claude Code to see them."
