{ lib, ... }: {

  services.flatpak.update.auto.enable = false;
  services.flatpak.uninstallUnmanaged = false;

  services.flatpak.packages = [
    "com.discordapp.Discord"
  ];

}
