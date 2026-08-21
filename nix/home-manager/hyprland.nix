(import ../helpers.nix).featureOnlyModule "hyprland" (
  { pkgsUnstable, ... }:
  {
    home.packages = [
      pkgsUnstable.flameshot
    ];

  }
)
