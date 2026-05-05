{ ... }:
{
  imports = [ ../. ];

  currentSystem = {
    username = "szczurek";
    hostname = "rat-laptok";

    features = [ "nixos" "hyprland" ];

    stateVersion = {
      system = "25.11";
      homeManager = "25.11";
    };
  };
}
