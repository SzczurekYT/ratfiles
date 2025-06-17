{ lib, pkgs, ... }: let
  username = "szczurek";
in
{
  home = {
    packages = with pkgs; [
      waybar
    ];

    file = {
      
    };

    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
