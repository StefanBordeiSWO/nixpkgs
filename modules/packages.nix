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
    nixfmt
    xarchiver
    xdg-utils
    zenmonitor
    obsidian
    nitrogen
    gnumake

    # Rust
    rustc
    cargo

    # testing
    vagrant
    virtualbox

    # lsp
    clang
    clang-tools
    nodejs
    nodePackages.npm
    nodePackages.pyright
    rust-analyzer
    gopls

    # linters
    ruff

    # telescope deps
    ripgrep

    # password management
    lxqt.lxqt-sudo
    lxqt.lxqt-policykit

    # nix-dev
    nixpkgs-review
  ];
}
