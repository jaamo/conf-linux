return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,    -- Make sure the theme loads immediately on startup
  priority = 1000, -- Load this before any other plugins
  config = function()
    require("catppuccin").setup({
      -- Mocha matches kitty/current-theme.conf
      flavour = "mocha",

      -- Set to true to let kitty's background_opacity show through
      transparent_background = false,

      styles = {
        comments = { "italic" },
        keywords = { "italic" },
      },

      -- Theme the plugins in lua/plugins/
      integrations = {
        gitsigns = true,
        neotree = true,
        telescope = { enabled = true },
        scrollbar = true,
      },
    })

    -- Load the colorscheme
    vim.cmd([[colorscheme catppuccin]])
  end,
}
