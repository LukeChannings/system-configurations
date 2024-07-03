{
  inputs,
  globals,
  overlays,
  ...
}:
let
  systemConfig = globals // rec {

    system.stateVersion = 1;

    user = "luke";
    userId = 501;
    configurationPath = "~/.nix-config";
    gitEmail = "461449+LukeChannings@users.noreply.github.com";
    gitSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPqR3Ps3fG4IEgoKiJnBdGW6IGoTcUrp/m5Ol4MUGEXP";

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
    apps.vim.enable = true;
    apps.helix.enable = true;
    apps.vscode.enable = true;

    fonts.enable = true;

    # nix-darwin
    networking.hostName = "Scimitar";
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
    ({ pkgs, ... }: {
      config.apps.extra = with pkgs.brewCasks; [
        telegram
        plexamp
        mqttx
        anki
        blender
        audio-hijack
      ];
    })
    systemConfig
    ../modules/common
    ../modules/darwin
    inputs._1password-shell-plugins.nixosModules.default
  ];
}
