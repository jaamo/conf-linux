return {
  "nvim-lualine/lualine.nvim",
  dependencies = { 
    "nvim-tree/nvim-web-devicons" -- Uses the same Nerd Font you installed earlier!
  },
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto", -- Automatically matches your current Neovim color scheme
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" }, -- Cool powerline triangles
        disabled_filetypes = {
          statusline = { "neo-tree" }, -- Hides the statusline inside your file tree
        },
      },
      sections = {
        lualine_a = { "mode" },        -- Displays NORMAL, INSERT, VISUAL, etc.
        lualine_b = { "branch", "diff", "diagnostics" }, -- Git branch, changes, and code errors
        lualine_c = { "filename" },    -- The name of the file you are editing
        lualine_x = { "encoding", "fileformat", "filetype" }, -- File details (e.g., UTF-8, Lua)
        lualine_y = { "progress" },    -- How far down the file you are (%)
        lualine_z = { "location" },    -- Line and column numbers
      },
    })
  end,
}
