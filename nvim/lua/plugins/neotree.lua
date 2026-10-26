return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Requires a Nerd Font
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: minimal setup doesn't need it
  },
  config = function()
    -- Unless you want to change defaults, this setup call can be empty
    require("neo-tree").setup({
      window = {
        width = 40,
      },
      filesystem = {
        filtered_items = {
          visible = true, -- Shows hidden files (like .env or .gitignore) by default
        },
        follow_current_file = {
          enabled = true, -- Focuses the active file in the tree
        },
      },
    })
  end,
}
