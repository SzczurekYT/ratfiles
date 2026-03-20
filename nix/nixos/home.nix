{ config, pkgs, ... }:

{
  home.packages = [ pkgs.zsh ];
  programs.zsh.enable = true;

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "25.11";
}
