{ lib, pkgs, ... }:
let
  username = "szczurek";
in
{
  home = {
    packages = with pkgs; [
      waybar

      nixfmt-rfc-style
    ];

    file = {

    };

    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;

  programs.waybar = {
    enable = true;
    style = builtins.readFile ./files/waybar-style.css;
    settings = [
      {
        layer = "top";
        modules-left = [ ];
        modules-center = [ "clock" ];
        modules-right = [ ];
        clock = {
          timezone = "Europe/Warsaw";
          locale = "pl_PL.utf8";
          format-alt = "{:%Y-%m-%d}";
          tooltip-format = "{:%Y-%m-%d | %H:%M}";
        };
      }
    ];
  };
}
