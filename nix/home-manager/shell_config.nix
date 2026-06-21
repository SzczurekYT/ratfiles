{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat-extras.batdiff
  ];

  programs.nushell = {
    enable = true;
    # settings = {
    #   show_banner = false;
    #   buffer_editor = "hx";
    #   extraConfig = builtins.readFile ./files/config.nu;
    # };
    configFile.source = ./files/config.nu;
    shellAliases = {
      vi = "hx";
      vim = "hx";
      nvim = "hx";
      nano = "hx";
      cat = "bat";
    };
  };

  programs.starship = {
    enable = true;
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  # Fish is used as completer for nu
  programs.fish.enable = true;

  programs.bat = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
    };
  };
}
