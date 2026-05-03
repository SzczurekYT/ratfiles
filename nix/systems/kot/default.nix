{ ... }:
{
  imports = [ ../. ];

  currentSystem = {
    username = "szczurek";
    hostname = "kot";

    features = [ "hyprland" ];

    stateVersion = {
      homeManager = "25.05";
    };
  };
}
