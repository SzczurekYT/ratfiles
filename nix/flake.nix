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
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      home-configuration = ./home-manager/home.nix;
      systemModule = name: (./systems + "/${name}");
      systemList = builtins.attrNames (builtins.readDir ./systems);
      hmModules = (name: [
            home-configuration
            (systemModule name)
            nix-flatpak.homeManagerModules.nix-flatpak
          ]);
    in
    {
      nixosConfigurations = pkgs.lib.genAttrs systemList (name: nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/configuration.nix
          (systemModule name)
          ( { config, ... }: home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.${config.currentSystem.username} = { ... }: {
              imports = hmModules name;
            };
            home-manager.extraSpecialArgs = { inherit nix-flatpak; };
          })
        ];
      });
      homeConfigurations = pkgs.lib.genAttrs systemList (
        name:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = hmModules name;
        }
      );
    };
}
