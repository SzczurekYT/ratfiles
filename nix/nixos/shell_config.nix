{ ... }:

{
  programs.nushell = {
    enable = true;
    settings = {
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
