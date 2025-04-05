{
  description = "Home Manager Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      flake-utils,
      nur,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnsupportedSystem = true;
          allowUnfree = true;
          allowBroken = true;
        };
      };
    in
    {
      homeConfigurations.stefan = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./modules/alacritty.nix
          ./modules/neovim.nix
          ./modules/tmux.nix
          ./modules/packages.nix
          ./home.nix
        ];
      };

      stefan = self.homeConfigurations.stefan.activationPackage;
      defaultPackage.${system} = self.stefan;
    };
}
