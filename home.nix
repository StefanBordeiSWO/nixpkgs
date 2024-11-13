{ config, pkgs, nur, ... }: {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "stefanB";
  home.homeDirectory = "/home/stefanB";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  programs = {
    home-manager.enable = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    powerline-go = {
      enable = true;
      pathAliases = { 
        "\\~/src/zae" = "zae"; 
      };
     # newline = true;
      extraUpdatePS1 = ''
        if [[ -n "$IN_NIX_SHELL" ]]; then
          export PS1="$PS1('📦'$name): "
        fi
      '';
    };
    tmux = {
      enable = true;
      baseIndex = 1;
      secureSocket = false; # WSL2 compat
      extraConfig = ''
        set -g default-terminal "xterm-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        #set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        #set-environment -g COLORTERM "truecolor"

        # Mouse works as expected
        set -g mouse on

        # easy-to-remember split pane commands
        bind ` split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"
      '';
    };
    bash = {
      enable = true;
      sessionVariables = {
        EDITOR = "nvim";
        TERM = "xterm-256color";
      };
      bashrcExtra = ''
        if [[ -n "$IN_NIX_SHELL" ]]; then
          export PS1="$PS1(nix-shell): "
        fi
      '';
    };
    git = {
      enable = true;
      package = pkgs.gitFull;
      userEmail = "stefan.bordei@softwareone.com";
      userName = "stefan.bordei";
      extraConfig = {
        core.editor = "vim";
      };
    };

    #  other programs
    bat.enable = true;
    eza.enable = true;
    fzf.enable = true;
    gh.enable = true;
    gitui.enable = true;
    lazygit.enable = true;
    #neovim.enable = true;
    go.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TCLLIBPATH = "$HOME/.local/share/tk-themes";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

  services = {
    gnome-keyring.enable = true;
    #picom.enable= true;
  };

  xdg.enable = true;
}
