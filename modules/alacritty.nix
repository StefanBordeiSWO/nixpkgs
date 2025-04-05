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
  };
  xdg.configFile."alacritty.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${nixConfigDir}/configs/alacritty/alacritty.toml";
}
