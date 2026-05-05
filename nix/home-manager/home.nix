{
  pkgs,
  config,
  lib,
  ...
}:
let
  username = "szczurek";
  home = "/home/${username}";
  isNixos = builtins.elem "nixos" config.currentSystem.features;
in
{
  imports = [
    ./flatpak.nix
    ./ssh_and_gpg.nix
    ./shell_config.nix
    ./programming.nix
    ./waybar.nix
  ];

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "${home}/Pulpit";
      download = "${home}/Pobrane";
      documents = "${home}/Dokumenty";
      pictures = "${home}/Obrazy";
      videos = "${home}/Wideo";
      music = "${home}/Muzyka";
      templates = "${home}/Szablony";
    };
  };

  home.packages = with pkgs; [
    wl-clipboard
  ];

  home = {
    username = config.currentSystem.username;
    homeDirectory = config.currentSystem.homeDirectory;
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };

  programs.brave = lib.mkIf isNixos {
    enable = true;
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
    ];
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = config.currentSystem.stateVersion.homeManager;

  programs.home-manager.enable = true;
}
