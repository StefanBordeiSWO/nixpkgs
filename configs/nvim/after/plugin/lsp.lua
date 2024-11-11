-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local nvim_lsp = require('lspconfig')

local servers = { 'pyright', 'rust_analyzer', 'gopls', 'lua_ls', 'terraformls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
  }
end

--require'nvim-treesitter.install'.compilers = { 'clang++' }
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {"lua", "vimdoc"},
  },
  indent = {
    disable = { "python" },
  },
  parser_install_dir = "~/.config/nvim/treesitter/parsers",
}
vim.opt.runtimepath:append("~/.config/nvim/treesitter/parsers")

require'lualine'.setup()
require('gitsigns').setup()
require('toggleterm').setup()
require('dapui').setup()
require('dap-python').setup('python')
table.insert(require'dap'.configurations.python, {
    name = 'Attach remote (with path mapping)',
    type = 'debugpy',
    request = 'attach',
    connect = function()
        local host = vim.fn.input('Host [0.0.0.0]: ')
        host = host ~= '' and host or '0.0.0.0'
        local port = tonumber(vim.fn.input('Port [5678]: ')) or 5678
        return { host = host, port = port }
    end,
    pathMappings = function()
        local cwd = vim.fn.getcwd()
        local local_path = vim.fn.input('Local path mapping [' .. cwd .. ']: ')
        local_path = local_path ~= '' and local_path or cwd
        local remote_path = vim.fn.input('Remote path mapping [.]: ')
        remote_path = remote_path ~= '' and remote_path or '.'
        return { { localRoot = local_path, remoteRoot = remote_path }, }
    end
})

-- Use <Tab> and <S-Tab> to navigate through popup menu
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})

-- Set completeopt to have a better completion experience
vim.o.completeopt="menuone,noinsert,noselect"

-- Avoid showing message extra message when using completion
vim.o.shortmess = vim.o.shortmess .. "c"

-- Chain completion list
vim.g.completion_chain_complete_list = {
    default = {
      default = {
          { complete_items = { 'lsp', 'snippet' }},
          { mode = '<c-p>'},
          { mode = '<c-n>'}},
      comment = {},
      string = { { complete_items = { 'path' }} }}}

-- Latexmk configuration
vim.g.vimtex_compiler_latexmk = {
     options = {
       '-pdf',
       '-shell-escape',
       '-verbose',
       '-file-line-error',
       '-synctex=1',
       '-interaction=nonstopmode',
     }}


-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
       completion = cmp.config.window.bordered(),
       documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-Space>'] = cmp.mapping.complete(),
      -- disable completion with tab
      -- this helps with copilot setup
      ['<Tab>'] = nil,
      ['<S-Tab>'] = nil,
    }),

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
})


-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

-- Py
require('lspconfig')['pyright'].setup {
    capabilities = capabilities
}

-- Lua
require('lspconfig')['lua_ls'].setup {
    capabilities = capabilities
}

-- Terraform
require('lspconfig')['terraformls'].setup {
    capabilities = capabilities
}
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Go
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

require('lspconfig')['gopls'].setup {
    capabilities = capabilities,
    cmd = {'gopls'},
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = require('lspconfig/util').root_pattern("go.work", "go.mod", ".git"),
    single_file_support = true,
    on_attach = on_attach,
}

-- formatting
local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = require('lspconfig/util').root_pattern("go.work", "go.mod", ".git"),
    sources = {
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.goimports,
    },
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})

-- Rust
local rt = require("rust-tools")
rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end,
})
