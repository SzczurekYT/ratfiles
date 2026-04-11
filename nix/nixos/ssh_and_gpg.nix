{ config, pkgs, ... }:

{
  programs.ssh.enable = true;
  programs.ssh.enableDefaultConfig = false;
  programs.ssh.matchBlocks = {
    kot = {
      hostname = "192.168.88.136";
    };
  };

  home.packages = with pkgs; [
    pinentry-qt
  ];

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
