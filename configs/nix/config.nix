{
  allowUnsupportedSystem = true;
  allowUnfree = true;
  allowBroken = true;

  nixpkgs.localSystem = {
    gcc.arch = "znver3";
    gcc.tune = "znver3";
    system = "x86_64-linux";
  };
}
