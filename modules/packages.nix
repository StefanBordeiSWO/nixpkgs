{ config, pkgs, libs, ... }:
let
in {
  home.packages = with pkgs; [
    # utilities
    (python3.withPackages(p: with p; [ pip python-lsp-server debugpy ruff-lsp requests numpy ]))
    htop
    glib # for gsettings
    gsimplecal
    keyd
    lazygit
    neovide
    neovim-qt
    nix-info
    nixfmt-rfc-style
    xarchiver
    xdg-utils
    zenmonitor
    unzip
    iconv
    file
    gnumake
    pyenv
    gcc
    wget

    # Azure
    azure-cli
    ansible

    # k8s
    kubectl
    kind
    kompose

    # Rust
    rustc
    cargo

    # lsp
    #clang
    #clang-tools
    nodejs
    nodePackages.npm
    pyright
    rust-analyzer
    gopls
    lua-language-server
    terraform-lsp
    nixd

    # linters
    ruff

    # telescope deps
    ripgrep
  ];
}
