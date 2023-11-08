require("stefan.set")
require("stefan.remap")
--require("stefan.packer")


local augroup = vim.api.nvim_create_augroup
local stefanGroup = augroup('stefan', {})
local autocmd = vim.api.nvim_create_autocmd
autocmd({"BufWritePre"}, {
    group = stefanGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- nvim-tree setup
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
--require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
