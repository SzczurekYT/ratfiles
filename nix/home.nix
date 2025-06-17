{ lib, pkgs, ... }: let
  username = "szczurek";
in
{
  home = {
    packages = with pkgs; [
      hello
    ];

    file = {
      "hello.txt".text = "How are you ${username}";
    };

    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "24.11";
  };
}
