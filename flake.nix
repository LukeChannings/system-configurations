{
  description = "System configurations";

  inputs = {

    # Used for system packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    flake-utils.url = "github:numtide/flake-utils";

    # Used for MacOS system config
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Used for user packages and dotfiles
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Used for secret management
    _1password-shell-plugins = {
      url = "github:1Password/shell-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    brew-nix = {
      url = "github:BatteredBunny/brew-nix";
      inputs.brew-api.follows = "brew-api";
    };
    brew-api = {
      url = "github:BatteredBunny/brew-api";
      flake = false;
    };
  };

  outputs =
    { nixpkgs, ... }@inputs:

    let

      # Global configuration for my systems
      globals = {
        user = "luke";
        fullName = "Luke Channings";
        gitEmail = "461449+LukeChannings@users.noreply.github.com";
        gitSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPqR3Ps3fG4IEgoKiJnBdGW6IGoTcUrp/m5Ol4MUGEXP";
      };

      overlays = import ./packages/overlays.nix { inherit inputs globals; };
    in
    rec {
      # Contains my full Mac system builds, including home-manager
      # darwin-rebuild switch --flake .#Scimitar
      darwinConfigurations = {
        Scimitar = import ./systems/scimitar.nix { inherit inputs globals overlays; };
      };

      # For quickly applying home-manager settings with:
      # home-manager switch --flake .#tempest
      homeConfigurations = {
        Scimitar = darwinConfigurations.Scimitar.config.home-manager.users.${globals.user}.home;
      };

      nixosConfigurations = {
        utm = import ./systems/nix-utm.nix { inherit inputs globals overlays; };
      };
    };
}
