vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", "<Esc>:NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>pb", "<Esc>:Telescope buffers<CR>")
vim.keymap.set("n", "<leader>j", "<Esc>:bnext<CR>")
vim.keymap.set("n", "<leader>k", "<Esc>:bprevious<CR>")

-- Debugger

vim.keymap.set("n", "<leader>dt", "<Esc>:lua require'dapui'.toggle()<CR>")
vim.keymap.set("n", "<leader>db", "<Esc>:lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>dc", "<Esc>:lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<leader>1", "<Esc>:lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<leader>2", "<Esc>:lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<leader>6", "<Esc>:lua require'dap'.repl.open()<CR>")

-- Tmux navigation
vim.keymap.set("n", "<C-j>", "<Esc>:TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-k>", "<Esc>:TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-h>", "<Esc>:TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-l>", "<Esc>:TmuxNavigateRight<CR>")
