# I don't want to mess with flatpaks on my non nixos systems for now
(import ../helpers.nix).featureOnlyModule "nixos" (
  {  ... }:
  {
    services.flatpak.update.auto.enable = false;
    services.flatpak.uninstallUnmanaged = false;

    services.flatpak.packages = [
      "com.discordapp.Discord"
      "com.super_productivity.SuperProductivity"
      "org.telegram.desktop"
      "in.cinny.Cinny"
      {
        bundle = "file://${./files/hytale-launcher-latest.flatpak}";
        appId = "com.hypixel.HytaleLauncher";
        sha256 = "113427b65bfbcdfb96072b05e5e35e00e341ac269aea5e918ef38f87a91b4842";
      }
      "com.lunarclient.LunarClient"
    ];
  }
)
