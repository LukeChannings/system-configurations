{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.shell."1password" = {
    enable = lib.mkEnableOption "1Password CLI";
    sshIntegration = lib.mkEnableOption "Enable SSH keys";
    gitSigningIntegration = lib.mkEnableOption "Enable git signing with ssh keys";
  };

  config = lib.mkIf config.shell."1password".enable {
    programs._1password-shell-plugins = {
      # enable 1Password shell plugins for bash, zsh, and fish shell
      enable = true;

      # the specified packages as well as 1Password CLI will be
      # automatically installed and configured to use shell plugins
      plugins = with pkgs; [
        gh
        argocd
        awscli2
      ];
    };

    home-manager.users.${config.user} = {
      programs.ssh.extraConfig = lib.mkIf (
        pkgs.stdenv.isDarwin && config.shell."1password".sshIntegration
      ) "IdentityAgent \"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";

      programs.git = lib.mkIf config.shell."1password".sshIntegration {
        iniContent = {
          gpg.format = "ssh";
          "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        };
      };
    };
  };
}
