{ pkgs, ... }:
{
  programs.git.settings = {
    user.signingkey = "39E6D194BE47284F!";
    credential.credentialStore = "secretservice";
  };

  programs.vscode.profiles.default = {
    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "aw-watcher-vscode";
        publisher = "activitywatch";
        version = "0.5.0";
        sha256 = "sha256-OrdIhgNXpEbLXYVJAx/jpt2c6Qa5jf8FNxqrbu5FfFs=";
      }
    ];

    userSettings = {
      # We use zsh
      "terminal.external.linuxExec" = "/bin/zsh";

      # We use podman
      "containers.containerCommand" = "podman";
      "containers.composeCommand" = "poman compose";
      "containers.environment" = {
        DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
      };
      "dev.containers.dockerPath" = "podman";
      "dev.containers.dockerComposePath" = "podman-compose";
    };
  };
}
