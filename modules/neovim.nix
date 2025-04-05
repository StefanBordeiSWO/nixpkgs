{
  config,
  pkgs,
  libs,
  ...
}:
let
  nixConfigDir = "${config.home.homeDirectory}/.config/home-manager";
in
{
  programs.neovim = {
    enable = true;
    withPython3 = true;
    withNodeJs = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      { plugin = awesome-vim-colorschemes; }
      { plugin = completion-nvim; }
      { plugin = gitsigns-nvim; }
      { plugin = toggleterm-nvim; }
      { plugin = fzf-vim; }
      { plugin = lazygit-nvim; }
      { plugin = lualine-nvim; }
      { plugin = base16-nvim; }
      { plugin = nvim-lspconfig; }
      { plugin = nvim-tree-lua; }
      { plugin = nvim-treesitter; }
      { plugin = nvim-cmp; }
      { plugin = cmp-nvim-lsp; }
      { plugin = cmp-nvim-lua; }
      { plugin = cmp-cmdline; }
      { plugin = cmp-buffer; }
      { plugin = cmp-path; }
      { plugin = cmp_luasnip; }
      { plugin = vim-nix; }
      { plugin = rust-tools-nvim; }
      { plugin = luasnip; }
      { plugin = telescope-nvim; }
      { plugin = plenary-nvim; }
      { plugin = harpoon; }
      { plugin = vim-tmux-navigator; }
      {
        plugin = (
          nvim-treesitter.withPlugins (
            ps: with ps; [
              lua
              python
              rust
              go
              kotlin
            ]
          )
        );
      }
      # Debug
      { plugin = nvim-dap; }
      { plugin = nvim-dap-ui; }
      { plugin = nvim-dap-virtual-text; }
      { plugin = nvim-dap-python; }
      { plugin = nvim-dap-go; }
      { plugin = vim-fugitive; }
      # Formatting
      { plugin = null-ls-nvim; }
      { plugin = conform-nvim; }
      { plugin = copilot-vim; }
    ];
  }; # neovim
  xdg.configFile."nvim/lua".source =
    config.lib.file.mkOutOfStoreSymlink "${nixConfigDir}/configs/nvim/lua";
  xdg.configFile."nvim/after".source =
    config.lib.file.mkOutOfStoreSymlink "${nixConfigDir}/configs/nvim/after";
  #xdg.configFile."nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink "${nixConfigDir}/configs/nvim/init.lua";
  programs.neovim.extraConfig = "lua require('stefan')";
}
