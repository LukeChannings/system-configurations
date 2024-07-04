{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.shell = {
    defaultShell = lib.mkOption {
      type = lib.types.str;
      description = "The user's default shell";
      default = "fish";
    };

    defaultEditor = lib.mkOption {
      type = lib.types.str;
      description = "The user's default editor";
      default = "vim";
    };
  };

  config =
    let
      homeConfig = {
        packages = with pkgs; [
          # nice admin tools
          lsd
          tree
          ripgrep

          # indispensible dev tools
          nodePackages_latest.http-server
          dig
          jq
          curl
          devenv

          # misc
          chafa # imgcat / sizzle CLI that works well with Wezterm

          cloudflared
        ];

        shellAliases = {
          ls = "lsd";
          mkcd = "mkdir -p $1 && cd ";
          gitco = "git checkout $1";
          tree = "tree --noreport";
          rg = "ripgrep";
          edit = "$VISUAL .";
          nixedit = "$VISUAL ${config.configurationPath}";
          rebuild = "${
            if pkgs.stdenv.isDarwin then "darwin" else "nixos"
          }-rebuild --flake ${config.configurationPath} $argv";
        };
      };
    in
    {
      users.users.${config.user}.shell = pkgs.${config.shell.defaultShell};

      home-manager.users.${config.user} = {
        home = homeConfig;
        xdg.enable = true;
      };
    };

  imports = [
    ./fish
    ./nushell
    ./git.nix
    ./bat.nix
    ./starship.nix
    ./zsh.nix
    ./1password.nix
    ./fzf.nix
    ./editorconfig.nix
    ./atuin.nix
    ./direnv.nix
    ./ssh.nix
    ./htop.nix
    ./kubectl.nix
    ./zoxide.nix
  ];
}
