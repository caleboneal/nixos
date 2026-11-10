{
  description = "NixOS WSL config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    rex.url = "https://pkgs.superlogical.com/rex/nix/preview.tar.gz";
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, rex, ... }: {
    nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixos-wsl.nixosModules.default
        ./machines/wsl.nix
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [ rex.homeManagerModules.default ];
          home-manager.users.caleb = import ./home.nix;
        }
      ];
    };

    nixosConfigurations.pi = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./machines/pi.nix
        ./configuration.nix
      

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.sharedModules = [ rex.homeManagerModules.default ];
          home-manager.users.caleb = import ./home.nix;
        }
      ];
    };
  };

  # nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
  #   system = "x86_64-linux";
  #   modules = [

  #   ];
  # };
}
