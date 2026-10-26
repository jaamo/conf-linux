# Claude Code

User-level config for [Claude Code](https://claude.com/claude-code) (`~/.claude/`).

- `settings.json`: model, auto permission mode, plugins and marketplaces, fullscreen TUI
- `commands/`: slash commands (`/get-resolved`)
- `skills/`: my own skills: `herdr`, `tmux`, `use-railway`

`~/.claude/` also holds credentials, history, sessions and caches, so the files are
linked one by one rather than linking the whole folder. `.gitignore` only allows
config files back in.

`skills/synced/` is not tracked. Claude Code downloads claude.ai skills there and
manages it on its own; it stays a normal folder in `~/.claude/skills/`.

## Setup

```sh
mkdir -p ~/.claude/skills
ln -sf ~/conf-linux/claudecode/settings.json ~/.claude/settings.json
ln -sfn ~/conf-linux/claudecode/commands ~/.claude/commands
for s in ~/conf-linux/claudecode/skills/*/; do
  ln -sfn "${s%/}" ~/.claude/skills/
done
```

Move an existing `~/.claude/commands` folder out of the way first, or `ln` puts the link
inside it. When you add a skill, link its folder the same way.

The gitkraken marketplace in `settings.json` points at a local path
(`~/.claude/plugins/marketplaces/gitkraken`), so it only works where that is installed.
