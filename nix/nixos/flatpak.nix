{ lib, ... }: {

  services.flatpak.remotes = lib.mkOptionDefault [{
    name = "plasma-keyboard-nightly"; location = "https://cdn.kde.org/flatpak/plasma-keyboard-nightly/plasma-keyboard-nightly.flatpakrepo";
  }];

  services.flatpak.update.auto.enable = false;
  services.flatpak.uninstallUnmanaged = false;

  services.flatpak.packages = [
    "com.discordapp.Discord"
    "org.kde.plasma.keyboard"
  ]; 
}
