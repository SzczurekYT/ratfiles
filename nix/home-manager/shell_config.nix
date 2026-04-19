{ ... }:

{
  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
      edit_mode = "vi";
    };
    shellAliases = {
      vi = "hx";
      vim = "hx";
      nvim = "hx";
      nano = "hx";
    };
  };

  programs.starship = {
    enable = true;
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
    };
  };
}
