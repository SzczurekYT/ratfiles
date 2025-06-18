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
    style = ''
      ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}

      window#waybar {
          background-color: rgba(30, 30, 46, 0.75); /* Catppuccin Mocha 75% alpha */
          /* border-bottom: 2px solid rgba(89, 89, 89, 0.667); Hyprland default border color */
          border-bottom: 2px solid rgb(153, 224, 255); /* My color */
      }

      #clock {
        color: rgb(153, 224, 255);
        background-color: transparent;
        font-size: 16px;
        font-weight: bold;
      }
    '';
    settings = [
      {
        height = 30;
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
