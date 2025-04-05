{
  config,
  pkgs,
  libs,
  ...
}:
let
in
{
  home.packages = with pkgs; [
    # utilities
    (python3.withPackages (
      p: with p; [
        pip
        python-lsp-server
        debugpy
        ruff-lsp
        setuptools
        wheel
      ]
    ))
    lazygit
    neovide
    neovim-qt
    nix-info
    nixfmt-rfc-style
    gnumake
    pyenv
    gcc
    wget

    # Azure
    azure-cli
    ansible

    # AWS
    awscli2
    awsume

    # k8s
    kubectl

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
    kotlin-language-server
    ktlint

    # linters
    ruff
    yamllint

    # telescope deps
    ripgrep
  ];
}
