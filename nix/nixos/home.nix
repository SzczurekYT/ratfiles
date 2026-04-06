{ config, pkgs, nix-flatpak, ... }:

{
  imports = [
    nix-flatpak.homeManagerModules.nix-flatpak
    ./flatpak.nix
    ./ssh_and_gpg.nix
    ./shell_config.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
  ];

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
  home.stateVersion = "25.11";
}
