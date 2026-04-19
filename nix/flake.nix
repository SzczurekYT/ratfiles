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
      pkgs = import nixpkgs { inherit system; };
      home-configuration = ./home-manager/home.nix;
    in
    {
      nixosConfigurations.rat-laptok = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.szczurek = import home-configuration;
            home-manager.extraSpecialArgs = { inherit nix-flatpak; };
          }
        ];
      };
      homeConfigurations = {
        szczurek = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ home-configuration ];
        };
      };
    };
}
