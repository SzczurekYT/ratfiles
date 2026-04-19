#!/usr/bin/env bash
if [ 'true' == '$(nix eval -f ./systems/check.nix --argstr name "$(hostname)" result)' ]; then
  echo Updating NixOS configuration
  sudo nixos-rebuild switch --flake ".#$(hostname)"
else
  echo Updating home-manager configuration
  home-manager switch --flake ".#$(hostname)"
fi
