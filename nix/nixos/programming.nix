{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      extensions = with pkgs.vscode-extensions; [
        # General
        zhuangtongfa.material-theme
        vscodevim.vim
        fill-labs.dependi

        # Git
        eamodio.gitlens
        mhutchie.git-graph
        github.vscode-pull-request-github

        # Toml
        tamasfe.even-better-toml

        # Python
        ms-python.debugpy
        ms-python.python
        ms-python.vscode-pylance

        # Rust
        rust-lang.rust-analyzer

        # Flutter
        dart-code.dart-code
        dart-code.flutter

        # C/Cpp
        ms-vscode.cpptools-extension-pack

        # Godot
        geequlim.godot-tools

        # Minecraft
        # Not packaged for nix :(
        # misodee.vscode-nbt

        # FPGA
        mshr-h.veriloghdl
      ];

      userSettings = {
        "workbench.colorTheme" = "One Dark Pro Darker";
        "editor.fontSize" = 18;
        "git.enableSmartCommit" = true;
        "python.analysis.completeFunctionParens" = true;
        "[dart]" = {
          "editor.formatOnSave" = true;
          "editor.formatOnType" = true;
          "editor.rulers" = [
            80
          ];
          "editor.selectionHighlight" = false;
          "editor.suggestSelection" = "first";
          "editor.tabCompletion" = "onlySnippets";
          "editor.wordBasedSuggestions" = "off";
        };
        "explorer.confirmDelete" = false;
        "editor.formatOnSave" = true;
        "rust-analyzer.check.command" = "clippy";
        "git.confirmSync" = false;
        "files.autoSave" = "afterDelay";
        "explorer.confirmDragAndDrop" = false;
        "diffEditor.ignoreTrimWhitespace" = false;
      };
    };
  };
}
