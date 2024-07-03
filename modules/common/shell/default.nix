{ lib, config, pkgs, ... }: {
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

  config = let
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
        mkcd = "mkdir -p $argv[1] && cd ";
        tree = "tree --noreport";
        rg = "ripgrep";
        edit = "$EDITOR .";
        nixedit = "cd ~/.nix-config; $editor .";
        rebuild = "darwin-rebuild switch --flake ~/.nix-config";
      };
    };
  in {
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
  ];
}
