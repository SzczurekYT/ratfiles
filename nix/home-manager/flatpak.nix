# I don't want to mess with flatpaks on my non nixos systems for now
(import ../helpers.nix).featureOnlyModule "nixos" (
  { lib, ... }:
  {
    services.flatpak.remotes = lib.mkOptionDefault [
      {
        name = "plasma-keyboard-nightly";
        location = "https://cdn.kde.org/flatpak/plasma-keyboard-nightly/plasma-keyboard-nightly.flatpakrepo";
      }
    ];

    services.flatpak.update.auto.enable = false;
    services.flatpak.uninstallUnmanaged = false;

    services.flatpak.packages = [
      "com.discordapp.Discord"
      "com.super_productivity.SuperProductivity"
      "org.telegram.desktop"
      {
        appId = "org.kde.plasma.keyboard";
        origin = "plasma-keyboard-nightly";
      }
      {
        bundle = "file://${./files/hytale-launcher-latest.flatpak}";
        appId = "com.hypixel.HytaleLauncher";
        sha256 = "113427b65bfbcdfb96072b05e5e35e00e341ac269aea5e918ef38f87a91b4842";
      }
    ];
  }
)
