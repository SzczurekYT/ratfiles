{ config, pkgs, nix-flatpak, ... }:

{
  imports = [
    nix-flatpak.homeManagerModules.nix-flatpak
    ./flatpak.nix
  ];
  home.packages = [ pkgs.zsh ];
  programs.zsh.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "SzczurekYT";
      user.email = "szczurek@szczurek.yt";
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
    };
  };

  programs.brave = {
    enable = true;
    extensions = [
      { id = "nngceckbapebfimnlniiiahkandclblb"; }
    ];
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "25.11";
}
