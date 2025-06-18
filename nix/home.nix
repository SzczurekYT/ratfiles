{ pkgs, ... }:
let
  username = "szczurek";
in
{
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

  programs.waybar = {
    enable = true;
    style = builtins.readFile ./files/waybar-style.css;
    settings = [
      {
        layer = "top";
        modules-left = [
          "cpu"
          "memory"
          "cava"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "wireplumber"
          "custom/power"
        ];

        cpu = {
          interval = 1;
          format = "CPU  {}%";
        };

        memory = {
          interval = 1;
          format = "RAM  {used:0.1f}G/{total:0.1f}G";
        };

        cava = {
          framerate = 60;
          method = "pipewire";
          bars = 20;
          bar_delimiter = 0;
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
        };

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

        "custom/power" = {
          format = " ⏻ ";
          tooltip = false;
          menu = "on-click";
          menu-file = "${./files/power_menu.xml}";
          menu-actions = {
            logout = "hyprctl dispatch exit";
            suspend = "systemctl sleep";
            reboot = "reboot";
            shutdown = "shutdown 0";
          };
        };
      }
    ];
  };
}
