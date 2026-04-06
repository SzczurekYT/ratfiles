{ ... }:

{
  programs.nushell = {
    enable = true;
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
