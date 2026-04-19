{ pkgs, ... }:
let
  username = "szczurek";
in
{
  imports = [
    ./waybar.nix
  ];

  home = {
    packages = with pkgs; [
      waybar
      nerd-fonts.meslo-lg
      cava

      nixfmt-rfc-style
      nixd
    ];

    file = {

    };

    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
