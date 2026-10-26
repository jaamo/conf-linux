-- 1. Automatically bootstrap lazy.nvim if missing
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_err_writeln("Error cloning lazy.nvim:\n" .. out)
    return
  end
end
vim.opt.rtp:prepend(lazypath)

-- 2. Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 3. Initialize lazy.nvim using your local plugins folder
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  -- Turning off the automatic update checker keeps things fully manual
  checker = { enabled = false }, 
})

-- 4. Your Neo-tree Keymaps
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { silent = true })
vim.keymap.set('n', '<leader>e', ':Neotree reveal<CR>', { silent = true })

vim.opt.clipboard = "unnamedplus"
vim.opt.number = true

vim.keymap.set('v', '<', '<gv', { desc = 'Outdent line and keep selection' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent line and keep selection' })

-- Set indentation settings to 2 spaces
vim.opt.tabstop = 2      -- The visual width of a literal tab character
vim.opt.shiftwidth = 2   -- The width of an indent size (when using > or <)
vim.opt.softtabstop = 2  -- The number of spaces inserted when hitting the Tab key
vim.opt.expandtab = true -- Convert literal tabs into actual spaces
