{ config, pkgs, nix-flatpak, ... }:

{
  imports = [
    nix-flatpak.homeManagerModules.nix-flatpak
    ./flatpak.nix
  ];
  home.packages = [ pkgs.zsh ];
  programs.zsh.enable = true;

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "25.11";
}
