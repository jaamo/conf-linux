return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    dependencies = {
      "lewis6991/gitsigns.nvim", -- Tie git tracking to the scrollbar
    },
    config = function()
      local scrollbar = require("scrollbar")
      
      scrollbar.setup({
        show = true,
        handle = {
          text = " ",
          color = "#555555", -- The actual scrollbar handle color
          hide_if_all_visible = true,
        },
        marks = {
          -- Enable Git indicators on the scrollbar track
          GitAdd = { text = "┃", priority = 7, color = "#A3BE8C" },
          GitChange = { text = "┃", priority = 7, color = "#EBCB8B" },
          GitDelete = { text = "┃", priority = 7, color = "#BF616A" },
        },
        handlers = {
          gitsigns = true, -- Turn on the Git integration
        },
      })
    end,
  },
}
