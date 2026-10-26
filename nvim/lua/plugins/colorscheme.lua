return {
  "sainnhe/everforest",
  lazy = false,    -- Make sure the theme loads immediately on startup
  priority = 1000, -- Load this before any other plugins
  config = function()
    -- OPTIONAL CONFIGURATION OPTIONS (Put these before loading the colorscheme)
    -- Available contrasts: 'hard', 'medium', 'soft'
    vim.g.everforest_background = "medium" 
    
    -- Enable italic text support for comments/keywords
    vim.g.everforest_enable_italic = 1
    
    -- Optimizes loading performance
    vim.g.everforest_better_performance = 1

    -- Load the colorscheme
    vim.cmd([[colorscheme everforest]])
  end,
}
