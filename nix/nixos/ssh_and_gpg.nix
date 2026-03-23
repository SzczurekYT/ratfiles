{ config, pkgs, ... }:

{
  programs.ssh.enable = true;
  programs.ssh.enableDefaultConfig = false;
  programs.ssh.matchBlocks = {
    kot = {
      hostname =  "192.168.88.136";
    };
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
