{ ... }:
{
  imports = [ ../. ];

  currentSystem = {
    username = "szczurek";
    hostname = "szczurek-portable";

    features = [ "hyprland" ];

    stateVersion = {
      homeManager = "25.05";
    };
  };
}
