{ lib, config, ... }:
{
  options.currentSystem = {
    username = lib.mkOption { type = lib.types.str; };
    hostname = lib.mkOption { type = lib.types.str; };
    homeDirectory = lib.mkOption { type = lib.types.str; };
    features = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };
    stateVersion = {
      system = lib.mkOption { type = lib.types.str; };
      homeManager = lib.mkOption { type = lib.types.str; };
    };
  };

  config.currentSystem = {
    homeDirectory = "/home/${config.currentSystem.username}";
  };
}
