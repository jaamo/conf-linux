return {  
  'nvim-telescope/telescope.nvim',  
  tag = '0.1.8', -- Uses the stable release  
  dependencies = {    
    'nvim-lua/plenary.nvim',  
    -- Highly recommended: installation of ripgrep via your system is needed for text searching  
  },  
  config = function()  
    local builtin = require('telescope.builtin')  
      
    -- KEYMAPS FOR SEARCHING  
    -- 1. Search files by name (Space + ff)  
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })  
      
    -- 2. Search text INSIDE files (Space + fg)  
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })  
      
    -- 3. Search open buffers/tabs (Space + fb)  
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })  
  end  
}
