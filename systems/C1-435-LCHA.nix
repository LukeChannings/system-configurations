{
  inputs,
  globals,
  overlays,
  ...
}:
let
  systemConfig = globals // rec {

    system.stateVersion = 1;

    user = "lchannings";
    userId = 502;
    gitEmail = "461449+LukeChannings@users.noreply.github.com";
    gitSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPqR3Ps3fG4IEgoKiJnBdGW6IGoTcUrp/m5Ol4MUGEXP";
    configurationPath = "~/Developer/Configuration";

    shell.defaultShell = "fish";
    shell.defaultEditor = "helix";

    shell.git.enable = true;
    shell.starship.enable = true;
    shell.zsh.enable = true;
    shell.nushell.enable = true;
    shell.fzf.enable = true;
    shell.editorconfig.enable = true;
    shell.atuin.enable = true;
    shell.direnv.enable = true;
    shell.bat.enable = true;
    shell.ssh.enable = true;
    shell.htop.enable = true;
    shell."1password" = {
      enable = true;
      sshIntegration = true;
      gitSigningIntegration = true;
    };

    apps.wezterm.enable = true;
    apps.helix.enable = true;
    apps.vscode.enable = true;
    apps.chromium.enable = true;

    fonts.enable = true;

    # nix-darwin
    networking.hostName = "C1-435-LCHA";
    networking.computerName = networking.hostName;
    networking.localHostName = networking.hostName;
  };
in
inputs.darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  modules = [
    inputs.home-manager.darwinModules.home-manager
    {
      nixpkgs.overlays = [
        inputs.brew-nix.overlay."aarch64-darwin"
        (import ../packages/overlays.nix { })
      ];
    }
    (
      { pkgs, config, ... }:
      {
        config.apps.extra = with pkgs; [
          jetbrains.idea-ultimate
          zoom-us
          slack
        ];

        config.home-manager.users.${config.user} =
          let
            sshPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBzCghZWsHKFoGaT+2Xzcqi3eIgxe6l6yu65+tSH+gJx";
          in
          {
            home.file.".ssh/cais-github.pub".text = sshPublicKey;

            programs.ssh.matchBlocks = {
              "cais.github.com" = {
                hostname = "github.com";
                user = "git";
                identityFile = "~/.ssh/cais-github.pub";
                identitiesOnly = true;
              };
            };

            programs.git = {
              includes = [
                {
                  condition = "gitdir:~/Developer/Sources/CAIS";
                  contentSuffix = "cais";
                  contents = {
                    user = {
                      email = "99651647+lchannings-cais@users.noreply.github.com";
                      signingKey = sshPublicKey;
                    };
                  };
                }
              ];
              ignores = [
                # Devenv
                ".devenv*"
                # "devenv.*"
                # ".envrc"

                # direnv
                ".direnv"

                # pre-commit
                # ".pre-commit-config.yaml"
              ];
            };
          };
      }
    )
    systemConfig
    ../modules/common
    ../modules/darwin
    inputs._1password-shell-plugins.nixosModules.default
  ];
}
