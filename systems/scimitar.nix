{
  inputs,
  globals,
  overlays,
  ...
}:
let
  systemConfig = globals // rec {

    system.stateVersion = 1;

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
    systemConfig
    ../modules/common
    ../modules/darwin
    inputs._1password-shell-plugins.nixosModules.default
  ];
}
