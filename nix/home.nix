{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
    ];

    username = "szczurek";
    homeDirectory = "/home/szczurek";

    stateVersion = "24.11";
  };
}
