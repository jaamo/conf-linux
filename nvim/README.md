# Neovim

Neovim config using [lazy.nvim](https://github.com/folke/lazy.nvim). Each plugin has its
own file in `lua/plugins/`.

## Requirements

- Neovim 0.10+
- git (lazy.nvim installs itself on first start)
- A Nerd Font, e.g. JetBrainsMono Nerd Font, for the icons in neo-tree and lualine
- [ripgrep](https://github.com/BurntSushi/ripgrep), for Telescope live grep

## Setup

```sh
ln -s ~/conf-linux/nvim ~/.config/nvim
nvim   # plugins install on first launch
```

Plugin versions are pinned in `lazy-lock.json`. `:Lazy restore` installs exactly those
versions; `:Lazy update` updates them and rewrites the lockfile. Commit the lockfile
after updating.

## Plugins

| File             | Plugin                                                 |
| ---------------- | ------------------------------------------------------ |
| `colorscheme.lua`| catppuccin/nvim, Mocha flavour (matches kitty)        |
| `lualine.lua`    | lualine statusline, theme follows the colorscheme      |
| `neotree.lua`    | neo-tree file explorer                                 |
| `telescope.lua`  | Telescope fuzzy finder                                 |
| `gitsigns.lua`   | gitsigns git markers                                   |
| `scrollbar.lua`  | nvim-scrollbar with git marks                          |
| `scroll.lua`     | neoscroll smooth scrolling                             |

To let kitty's background transparency show through, set
`transparent_background = true` in `colorscheme.lua`.

## Keys

Leader is `Space`.

| Key          | Action                          |
| ------------ | ------------------------------- |
| `Ctrl-n`     | Toggle neo-tree                 |
| `Space e`    | Reveal current file in neo-tree |
| `Space ff`   | Find files                      |
| `Space fg`   | Live grep                       |
| `Space fb`   | Find buffers                    |
| `<` / `>`    | Indent in visual mode, keeping the selection |
