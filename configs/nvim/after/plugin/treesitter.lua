--local parser_install_dir = vim.fn.stdpath("cache") .. "~/.config/nvim/treesitter"
--vim.opt.runtimepath:append(parser_install_dir)
require'nvim-treesitter.install'.compilers = { 'clang++' }
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  --ensure_installed = { "help", "nix", "python", "c", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    disable = {"rust"},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  parser_install_dir = "~/.config/nvim/treesitter",
}
vim.opt.runtimepath:append("~/.config/nvim/treesitter/")
