{ config, pkgs, libs, ... }:
let
  nixConfigDir = "${config.home.homeDirectory}/.config/nixpkgs";
in
{
    programs.tmux = {
      enable = true;
      clock24 = true;

      plugins = with pkgs.tmuxPlugins; [
        { plugin = vim-tmux-navigator; }
        { plugin = sensible; }
        { plugin = dracula; }
        {
			plugin = dracula;
            extraConfig = ''
                set -g @dracula-show-fahrenheit false
				set -g @dracula-show-battery false
				set -g @dracula-show-powerline true
                set -g @dracula-refresh-rate 10
                set -g @dracula-show-left-icon session
                set -g @dracula-left-icon-padding 2
			'';
		}
      ];

      extraConfig = ''
        set -g default-terminal "xterm-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
        set-environment -g COLORTERM "truecolor"

        # Mouse works as expected
        set -g mouse on
        set -g base-index 1
        set -g pane-base-index 1
      '';

    }; # tmux
}
