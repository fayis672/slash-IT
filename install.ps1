# Install the prompt->command slash commands globally for Claude Code.
$ErrorActionPreference = "Stop"

$dest = Join-Path $HOME ".claude\commands"
$src  = Join-Path $PSScriptRoot "commands"

New-Item -ItemType Directory -Force $dest | Out-Null
Copy-Item (Join-Path $src "*.md") $dest -Force

Write-Host "Installed commands to $dest:"
Get-ChildItem $src -Filter *.md | ForEach-Object { "  /" + $_.BaseName }
Write-Host "Reopen the / menu in Claude Code to see them."
