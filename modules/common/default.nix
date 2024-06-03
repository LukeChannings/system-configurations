{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./nix
    ./shell
    ./apps
    ./fonts
  ];

  options = {
    user = lib.mkOption {
      type = lib.types.str;
      description = "The user name for the primary user";
    };

    fullName = lib.mkOption {
      type = lib.types.str;
      description = "A human readable name for the user";
    };

    homePath = lib.mkOption {
      type = lib.types.path;
      description = "Path of user's home directory.";
      default = builtins.toPath (
        if pkgs.stdenv.isDarwin then "/Users/${config.user}" else "/home/${config.user}"
      );
    };

    gitEmail = lib.mkOption {
      type = lib.types.str;
    };

    gitSigningKey = lib.mkOption {
      type = lib.types.str;
    };
  };

  config =
    let
      stateVersion = "24.05";
    in
    {
      # Use the system-level nixpkgs instead of Home Manager's
      home-manager.useGlobalPkgs = true;

      # Install packages to /etc/profiles instead of ~/.nix-profile, useful when
      # using multiple profiles for one user
      home-manager.useUserPackages = true;

      home-manager.backupFileExtension = "backup";

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      # Pin a state version to prevent warnings
      home-manager.users.root.home.stateVersion = stateVersion;

      home-manager.users.${config.user} = {
        home.stateVersion = stateVersion;
        programs.home-manager.enable = true;
      };
    };
}
