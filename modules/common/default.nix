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

  options = with lib; {
    user = mkOption {
      type = types.str;
      description = "The user name for the primary user";
    };

    userId = mkOption {
      type = types.int;
      description = "The id for the primary user";
      default = 501;
    };

    fullName = mkOption {
      type = types.str;
      description = "A human readable name for the user";
    };

    homePath = mkOption {
      type = types.path;
      description = "Path of user's home directory.";
      default = builtins.toPath (
        if pkgs.stdenv.isDarwin then "/Users/${config.user}" else "/home/${config.user}"
      );
    };

    configurationPath = mkOption {
      type = types.str;
      description = "Path to clone of this configuration repo";
    };

    gitEmail = mkOption {
      type = with types; nullOr str;
      default = null;
    };

    gitSigningKey = mkOption {
      type = with types; nullOr str;
      default = null;
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

      home-manager.users.${config.user} = (
        { config, lib, ... }:
        {
          home.stateVersion = stateVersion;

          programs.home-manager.enable = true;

          home.activation = {
            setupDeveloperFolder = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
              run mkdir -p ${config.home.homeDirectory}/Developer
              run ${lib.getExe pkgs.git} clone https://github.com/LukeChannings/system-configurations.git ${config.home.homeDirectory}/Developer/Configuration
              run cd ${config.home.homeDirectory}/Developer/Configuration && git remote remove origin && git remote add origin git@github.com:LukeChannings/system-configurations.git
            '';
          };
        }
      );
    };
}
