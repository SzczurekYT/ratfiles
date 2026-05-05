{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep
    nixfmt
    nixfmt-tree
    nixd
  ];
  
  programs.git = {
    enable = true;
    settings = {
      user.name = "SzczurekYT";
      user.email = "szczurek@szczurek.yt";
      commit.gpgsign = true;
      tag.gpgSign = true;
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
      advice.skippedCherryPicks = false;
      alias = {
        shlog = "!git log --oneline | head -n 15";
        whoami = "!echo \\\"$(git config user.name) <$(git config user.email)>\\\"";
      };
    };
  };

  programs.vscode = {
    enable = true;
    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      extensions = (import ./vscode_extensions.nix) pkgs;

      userSettings = {
        # Editor
        "diffEditor.ignoreTrimWhitespace" = false;
        "debug.allowBreakpointsEverywhere" = true;
        "editor.fontSize" = 18;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = true;
        "editor.bracketPairColorization.enabled" = true;
        "editor.guides.bracketPairsHorizontal" = true;
        "editor.guides.bracketPairs" = true;
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "explorer.confirmPasteNative" = false;
        "explorer.fileNesting.enabled" = true;
        "explorer.fileNesting.expand" = false;
        "explorer.fileNesting.patterns" = {
          "pubspec.yaml" = ".flutter-plugins, .packages, .dart_tool, .flutter-plugins-dependencies, .metadata, .packages, pubspec.lock, build.yaml, analysis_options.yaml, all_lint_rules.yaml";
          ".gitignore" = ".gitattributes, .gitmodules, .gitmessage, .mailmap, .git-blame*";
          "readme.*" = "authors, backers.md, changelog*, citation*, code_of_conduct.md, codeowners, contributing.md, contributors, copying, credits, governance.md, history.md, license*, maintainers, readme*, security.md, sponsors.md";
          "*.dart" = "$(capture).g.dart, $(capture).freezed.dart";
          "*.gd" = "$(capture).gd.uid";
        };
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 2000;
        "security.workspace.trust.untrustedFiles" = "open";
        "terminal.integrated.allowChords" = false;
        "terminal.integrated.cursorStyle" = "line";
        "terminal.integrated.fontSize" = 16;
        "telemetry.telemetryLevel" = "off";
        "workbench.colorTheme" = "One Dark Pro Darker";

        # Disable AI slop
        "workbench.secondarySideBar.defaultVisibility" = "hidden";
        "chat.disableAIFeatures" = true;
        "chat.sendElementsToChat.enabled" = false;
        "github.copilot.enable" = {
          "*" = false;
          plaintext = false;
          markdown = false;
          scminput = false;
        };
        "gitlens.ai.enabled" = false;

        # Languages
        ## Webdev
        "[html]" = {
          "editor.defaultFormatter" = "vscode.html-language-features";
        };
        "[css]" = {
          "editor.defaultFormatter" = "vscode.css-language-features";
        };
        "[javascript]" = {
          "editor.defaultFormatter" = "denoland.vscode-deno";
        };
        "[typescript]" = {
          "editor.defaultFormatter" = "denoland.vscode-deno";
        };
        ## Python
        "python.analysis.typeCheckingMode" = "off";
        ## Dart
        "[dart]" = {
          "editor.formatOnSave" = true;
          "editor.formatOnType" = true;
          "editor.rulers" = [
            80
          ];
          "editor.selectionHighlight" = false;
          "editor.suggest.snippetsPreventQuickSuggestions" = false;
          "editor.suggestSelection" = "first";
          "editor.tabCompletion" = "onlySnippets";
          "editor.wordBasedSuggestions" = "off";
        };
        "dart.devToolsBrowser" = "default";
        "dart_data_class_generator.quick_fixes" = true;
        "dart.previewFlutterUiGuides" = true;
        "dart.previewFlutterUiGuidesCustomTracking" = true;
        ## Rust
        "rust-analyzer.check.command" = "clippy";
        "rust-analyzer.imports.granularity.enforce" = true;
        # C/C++/cmake
        "cmake.configureOnOpen" = false;
        "cmake.showOptionsMovedNotification" = false;
        "C_Cpp.autocompleteAddParentheses" = true;
        "C_Cpp.clang_format_fallbackStyle" = "{ BasedOnStyle: Google, IndentWidth: 4, TabWidth: 4}";
        ## Godot/GDScript
        "godotTools.lsp.serverPort" = 6005;
        "godot_tools.gdscript_lsp_server_port" = 6005;
        ## Nix
        "nix.enableLanguageServer" = true;
        "nix.formatterPath" = "nixfmt";
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          nixd = {
            formatting = {
              command = [
                "nixfmt"
              ];
            };
          };
        };
        ## Docker compose?
        "[compose]" = {
          "editor.quickSuggestions" = {
            other = "on";
            comments = "off";
            strings = "off";
          };
        };
        ## Markdown
        "[markdown]" = {
          "editor.formatOnSave" = false;
        };
        ## Json
        "[json]" = {
          "editor.defaultFormatter" = "vscode.json-language-features";
        };
        "[jsonc]" = {
          "editor.defaultFormatter" = "denoland.vscode-deno";
        };

        # Tools and extensions
        ## Git
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        "git.openRepositoryInParentFolders" = "never";
        "git.autofetch" = true;
        "git.pruneOnFetch" = true;
        "git.ignoreRebaseWarning" = true;

        ## Github
        "githubPullRequests.createOnPublishBranch" = "never";
        "githubPullRequests.pullBranch" = "never";
        "githubPullRequests.fileListLayout" = "tree";

        ## Pets
        "vscode-pets.petSize" = "medium";
      };
    };
  };
}
