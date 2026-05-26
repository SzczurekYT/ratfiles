pkgs:
let
  vscodeExts = with pkgs.vscode-extensions; [
    # General
    zhuangtongfa.material-theme
    pkief.material-icon-theme
    fill-labs.dependi
    alefragnani.bookmarks
    usernamehw.errorlens
    wakatime.vscode-wakatime
    jgclark.vscode-todo-highlight

    # Git
    eamodio.gitlens
    mhutchie.git-graph
    github.vscode-pull-request-github

    # Toml
    tamasfe.even-better-toml

    # CSV
    mechatroner.rainbow-csv

    # Python
    ms-python.debugpy
    ms-python.python
    ms-python.vscode-pylance
    charliermarsh.ruff

    # JS/TS
    denoland.vscode-deno

    # Rust
    rust-lang.rust-analyzer
    a5huynh.vscode-ron
    vadimcn.vscode-lldb

    # Flutter
    dart-code.dart-code
    dart-code.flutter

    # C/Cpp
    ms-vscode.cpptools
    ms-vscode.cpptools-extension-pack

    # Godot
    geequlim.godot-tools

    # Containers
    ms-azuretools.vscode-containers
    ms-vscode-remote.remote-containers

    # Nix
    jnoortheen.nix-ide
    arrterian.nix-env-selector

    # FPGA
    mshr-h.veriloghdl
  ];

  marketplaceVscodeExts = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    # General
    {
      name = "logfilehighlighter";
      publisher = "emilast";
      version = "3.5.1";
      sha256 = "sha256-R1/U+i2y2zk1wZRYVlk4prE6vt/bYKZEsHPfG7+kVX0=";
    }
    {
      name = "vscode-pets";
      publisher = "tonybaloney";
      version = "1.35.0";
      sha256 = "sha256-TWWoJ0dBwEHnbi16d0/sBodqg9l92TIzxZYvXTjxNpY=";
    }

    # Flutter
    {
      name = "awesome-flutter-snippets";
      publisher = "Nash";
      version = "4.0.1";
      sha256 = "sha256-lXdos/xB18h3Z0YfkgEk55G2JvRMYudUUIltugQjylU=";
    }
    {
      name = "ccs-flutter-color";
      publisher = "circlecodesolution";
      version = "2.2.0";
      sha256 = "sha256-MBk4EoEbj4zG7e9pPomLSGVFCffYmu564bHdaIxwQCo=";
    }
    {
      name = "flutter-riverpod-snippets";
      publisher = "robert-brunhage";
      version = "2.0.0";
      sha256 = "sha256-BlqWE9q/Rh4+LFmUWFop0GD66grm74sJqDYqjUOECNI=";
    }
    {
      name = "riverpod-widget-refactor";
      publisher = "QuangTrung";
      version = "1.0.4";
      sha256 = "sha256-/kxwsuIJcb2b5WHySqWZa/LXMfuSfg4KJbGy0smZZII=";
    }

    # Minecraft
    {
      name = "vscode-nbt";
      publisher = "misodee";
      version = "0.9.5";
      sha256 = "sha256-U7Any0zrcelFpKJ2S2pkV4aSSEk41FGqmX9+wmd7YZo=";
    }
    {
      name = "datapack-language-server";
      publisher = "SPGoding";
      version = "4.8.0";
      sha256 = "sha256-U7YyHg21/UaYsOCJg+wPEW91b4ca9zbt5xFV7tVgz6c=";
    }

    # Other
    {
      name = "wgsl";
      publisher = "PolyMeilex";
      version = "0.1.17";
      sha256 = "sha256-vGqvVrr3wNG6HOJxOnJEohdrzlBYspysTLQvWuP0QIw=";
    }
    {
      name = "yuck";
      publisher = "eww-yuck";
      version = "0.0.3";
      sha256 = "sha256-DITgLedaO0Ifrttu+ZXkiaVA7Ua5RXc4jXQHPYLqrcM=";
    }
  ];
in
vscodeExts ++ marketplaceVscodeExts
