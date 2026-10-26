# kitty

[kitty](https://sw.kovidgoyal.net/kitty/) terminal config, based on
[It's FOSS kitty customization](https://itsfoss.com/kitty-customization/).

- `kitty.conf`: font, scrollback, window, tab bar and cursor trail settings
- `current-theme.conf`: Catppuccin Mocha colours, included from `kitty.conf`

## Requirements

- kitty 0.37+ (for `cursor_trail`)
- JetBrainsMono Nerd Font

## Setup

```sh
ln -s ~/conf-linux/kitty ~/.config/kitty
```

Reload a running kitty with `Ctrl+Shift+F5`.

## Changing the theme

```sh
kitty +kitten themes
```

This rewrites `current-theme.conf` and the `BEGIN_KITTY_THEME` block in `kitty.conf`.
Since the folder is linked, the change lands in this repo: commit it. Neovim and herdr
also use Catppuccin Mocha, so change them too to keep things matching.
