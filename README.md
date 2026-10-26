# conf-linux

My Linux configs in one place. Each folder is symlinked into place on the machine,
so editing a file here edits the live config.

| Folder                       | What                         | Linked to                      |
| ---------------------------- | ---------------------------- | ------------------------------ |
| [`nvim/`](nvim/)             | Neovim (lazy.nvim)           | `~/.config/nvim`               |
| [`kitty/`](kitty/)           | kitty terminal               | `~/.config/kitty`              |
| [`herdr/`](herdr/)           | herdr terminal multiplexer   | `~/.config/herdr/config.toml`  |
| [`claudecode/`](claudecode/) | Claude Code settings, skills | files inside `~/.claude/`      |

Everything uses the **Catppuccin Mocha** theme.

## Setup

```sh
git clone git@github.com:jaamo/conf-linux.git ~/conf-linux
```

Then follow the README in each folder. Move any existing config out of the way
before linking, e.g. `mv ~/.config/nvim ~/.config/nvim.bak`.

## History

`nvim/` and `claudecode/` were imported with `git subtree` from
[jaamo/conf-nvim](https://github.com/jaamo/conf-nvim) and
[jaamo/conf-claudecode](https://github.com/jaamo/conf-claudecode), keeping their history.
