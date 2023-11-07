vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", "<Esc>:NvimTreeToggle<CR>")

-- Tmux navigation
vim.keymap.set("n", "<C-j>", "<Esc>:TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<Esc>:TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-h>", "<Esc>:TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-l>", "<Esc>:TmuxNavigateRight<CR>")
