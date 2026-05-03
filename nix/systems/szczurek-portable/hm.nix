{ ... }:
let
  username = "szczurek";
in
{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "25.05";
  };
}
