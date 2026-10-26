# herdr

Config for [herdr](https://herdr.dev), the terminal workspace manager for coding agents.

- Prefix key: `Ctrl-a`
- Theme: `catppuccin` (herdr's built-in Mocha; matches kitty and Neovim)

## Setup

Link only `config.toml`. herdr keeps logs, sockets and session state in the same
folder, and those don't belong in the repo.

```sh
mkdir -p ~/.config/herdr
ln -sf ~/conf-linux/herdr/config.toml ~/.config/herdr/config.toml
herdr config check            # validate
herdr server reload-config    # apply to a running server
```

`herdr config check` lists the valid theme names if one is wrong.
