{ name }:
let
  pkgs = import <nixpkgs> { };
  result = pkgs.lib.evalModules {
    modules = [ (./. + "/${name}") ];
  };
in
{ result = builtins.elem "nixos" result.config.currentSystem.features; }
