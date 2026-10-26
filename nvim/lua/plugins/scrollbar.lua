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
          color = "#45475A", -- The actual scrollbar handle color (Mocha surface1)
          hide_if_all_visible = true,
        },
        marks = {
          -- Enable Git indicators on the scrollbar track
          GitAdd = { text = "┃", priority = 7, color = "#A6E3A1" },
          GitChange = { text = "┃", priority = 7, color = "#F9E2AF" },
          GitDelete = { text = "┃", priority = 7, color = "#F38BA8" },
        },
        handlers = {
          gitsigns = true, -- Turn on the Git integration
        },
      })
    end,
  },
}
