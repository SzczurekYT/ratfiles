{
  description = "Rat's Nix/NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-amd-npu.url = "github:robcohen/nix-amd-npu";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-flatpak,
      nix-amd-npu,
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
      nixosConfigurations = nixpkgs.lib.genAttrs systemList (
        name:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit nix-amd-npu; };
          modules = [
            (nixosHardwareModule name)
            (currentSystemModule name)
            ./nixos/configuration.nix
            ./nixos/amd-npu.nix
            nix-amd-npu.nixosModules.default
            (
              { config, ... }:
              {
                imports = [ home-manager.nixosModules.home-manager ];

                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;

                home-manager.users.${config.currentSystem.username} =
                  { ... }:
                  {
                    imports = hmModules name;
                  };
              }
            )
          ]
          ++ nixpkgs.lib.optional (builtins.pathExists (nixosModule name)) (nixosModule name);
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
