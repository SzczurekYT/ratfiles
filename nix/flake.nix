{
  description = "Rat's Nix/NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-flatpak,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      home-configuration = ./home-manager/home.nix;
      currentSystemModule = name: (./systems + "/${name}");
      nixosModule = name: (./systems + "/${name}/system.nix");
      nixosHardwareModule = name: (./systems + "/${name}/hardware-configuration.nix");
      homeModule = name: (./systems + "/${name}/home.nix");
      systemList = builtins.attrNames (builtins.readDir ./systems);
      hmModules = (
        name:
        [
          home-configuration
          (currentSystemModule name)
          nix-flatpak.homeManagerModules.nix-flatpak
        ]
        ++ nixpkgs.lib.optional (builtins.pathExists (homeModule name)) (homeModule name)
      );
    in
    {
      nixosConfigurations = pkgs.lib.genAttrs systemList (
        name:
        nixpkgs.lib.nixosSystem {
          modules =
            [
              ./nixos/configuration.nix
              (currentSystemModule name)
              (
                { config, ... }:
                home-manager.nixosModules.home-manager {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;

                  home-manager.users.${config.currentSystem.username} =
                    { ... }:
                    {
                      imports = hmModules name;
                    };
                  home-manager.extraSpecialArgs = { inherit nix-flatpak; };
                }
              )
            ]
            ++ nixpkgs.lib.optional (builtins.pathExists (nixosModule name)) (nixosModule name)
            ++ nixpkgs.lib.optional (builtins.pathExists (nixosHardwareModule name)) (nixosModule name);
        }
      );
      homeConfigurations = pkgs.lib.genAttrs systemList (
        name:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = hmModules name;
        }
      );
    };
}
