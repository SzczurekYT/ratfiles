{
  pkgs,
  config,
  ...
}:
let
  username = "szczurek";
  home = "/home/${username}";
in
{
  imports = [
    ./flatpak.nix
    ./ssh_and_gpg.nix
    ./shell_config.nix
    ./programming.nix
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
      templates = "${home}/Experiments";
    };
  };

  home.packages = with pkgs; [
    wl-clipboard
    nixfmt
  ];

  home = {
    username = config.currentSystem.username;
    homeDirectory = config.currentSystem.homeDirectory;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "SzczurekYT";
      user.email = "szczurek@szczurek.yt";
      user.signingkey = "1FB45ECD3CBE10B1";
      commit.gpgsign = true;
      tag.gpgSign = true;
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
    };
  };

  programs.brave = {
    enable = true;
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
    ];
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = config.currentSystem.stateVersion.homeManager;
}
