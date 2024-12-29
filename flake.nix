{
  description = "Nix for my mac";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs dependencies.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # outputs = { self, nix-darwin, nixpkgs, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, ... }:
  outputs = inputs@{
    self,
    darwin,
    nixpkgs,
    home-manager,
    ...
  }: let
    username = "cornelius";
    useremail = "mail@cornelius.wtf";
    system = "aarch64-darwin";
    hostname = "mbp2";

    specialArgs =
      inputs
      // {
        inherit username useremail hostname;
      };
  in {
    darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        ./modules/apps.nix
        ./modules/host-users.nix
        ./modules/nix-core.nix
        ./modules/system.nix

        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users.${username} = import ./home;
        }
      ];
    };
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
  };
    #       # GUI Applications
    #       pkgs.alacritty

    #       # Languages
    #       pkgs.go

    #       # CLI Tools
    #       pkgs.bat
    #       pkgs.fzf
    #       pkgs.zoxide
    #       pkgs.yazi

    #       # TUI Tools
    #       pkgs.neovim

    #       # Utils
    #       pkgs.starship

    #       #LSP
    #       pkgs.nixd
    #   ];

}
