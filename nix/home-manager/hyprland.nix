(import ../helpers.nix).featureOnlyModule "hyprland" (
  { pkgs, pkgsUnstable, ... }:
  let
    anyrunPkg = pkgsUnstable.anyrun.overrideAttrs (old: {
      src = pkgs.fetchFromGitHub {
        owner = "SzczurekYT";
        repo = "anyrun";
        rev = "791a10df2a78e0e8440f844ee2d285c6d7610ed2";
        hash = "sha256-Feibm3mUYnfhjOpng4dTSv+yCvBoEGaubMPk9VxE1nA=";
      };
    });
  in
  {
    home.packages = [
      pkgsUnstable.flameshot
    ];

    programs.anyrun = {
      enable = true;
      package = anyrunPkg;
      config = {
        x = { fraction = 0.5; };
        y = { fraction = 0.3; };
        width = { fraction = 0.3; };
        hideIcons = false;
        ignoreExclusiveZones = false;
        layer = "overlay";
        hidePluginInfo = false;
        closeOnClick = true;
        showResultsImmediately = true;
        maxEntries = null;

        plugins = [
          "${pkgs.anyrun}/lib/libapplications.so"
          "${pkgs.anyrun}/lib/librink.so"
          "${pkgs.anyrun}/lib/libsymbols.so"
        ];
      };

      extraConfigFiles."symbols.ron".text = /* ron */ ''
        Config(
          // The prefix that the search needs to begin with to yield symbol results
          prefix: "!",
          // Custom user defined symbols to be included along the unicode symbols
          symbols: {
            "shrug": "¯\\_(ツ)_/¯",
          },
          max_entries: 3,
        )
      '';

      extraConfigFiles."applications.ron".text = /* ron */ ''
        Config(
          desktop_actions: true,

          max_entries: 5,

          hide_description: false,

          preprocess_exec_script: None,

          terminal: Some(Terminal(
            command: "wezterm",
            args: "-e \"{}\"",
          )),
        )
      '';
    };
  }
)
