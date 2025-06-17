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

  programs.waybar = {
    enable = true;
    settings = [{
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
    }];
  };
}
