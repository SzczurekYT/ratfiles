{ pkgs, ... }:
let
  username = "szczurek";
in
{
  home = {
    packages = with pkgs; [
      waybar
      nerd-fonts.meslo-lg

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

  programs.waybar = {
    enable = true;
    style = builtins.readFile ./files/waybar-style.css;
    settings = [
      {
        layer = "top";
        modules-left = [ ];
        modules-center = [ "clock" ];
        modules-right = [ "wireplumber" ];
        clock = {
          timezone = "Europe/Warsaw";
          locale = "pl_PL.utf8";
          format-alt = "{:%Y-%m-%d}";
          tooltip-format = "{:%Y-%m-%d | %H:%M}";
        };

        wireplumber = {
          max-volume = 200;
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          format = "{icon} {volume}%";
          format-muted = "  󰖁  ";
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
        };
      }
    ];
  };
}
