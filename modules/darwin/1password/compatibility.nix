{ lib, pkgs, config, ...}:
{
  # The 1password shell plugins flake has a NixOS module that depends on
  # the shellAliases property which is not available in nix-darwin.
  # I re-declare these options for nix-darwin and re-implement the config mapping for bash and zsh.
  # fish does have a shellAliases property and does not need to be patched.
  #
  # See: https://github.com/NixOS/nixpkgs/blob/nixos-23.11/nixos/modules/programs/bash/bash.nix#L118
  options = {
    programs.bash.shellAliases = lib.mkOption {
      default = {};
      description = lib.mdDoc ''
        Set of aliases for bash shell, which overrides {option}`environment.shellAliases`.
        See {option}`environment.shellAliases` for an option format description.
      '';
      type = with lib.types; attrsOf (nullOr (either str path));
    };

    programs.zsh.shellAliases = lib.mkOption {
      default = {};
      description = lib.mdDoc ''
        Set of aliases for bash shell, which overrides {option}`environment.shellAliases`.
        See {option}`environment.shellAliases` for an option format description.
      '';
      type = with lib.types; attrsOf (nullOr (either str path));
    };
  };

  config = lib.mkIf pkgs.stdenv.isDarwin {
    programs.bash.interactiveShellInit = with lib; concatStringsSep "\n" (
      mapAttrsFlatten (k: v: "alias -- ${k}=${escapeShellArg v}")
        (filterAttrs (k: v: v != null) config.programs.bash.shellAliases)
    );

    programs.zsh.interactiveShellInit = with lib; concatStringsSep "\n" (
      mapAttrsFlatten (k: v: "alias -- ${k}=${escapeShellArg v}")
        (filterAttrs (k: v: v != null) config.programs.bash.shellAliases)
    );
  };
}
