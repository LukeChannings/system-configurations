{ lib, config, ... }:
{
  options.shell.ssh.enable = lib.mkEnableOption "ssh";

  config = lib.mkIf config.shell.ssh.enable {

    # https://github.com/nix-community/home-manager/blob/master/modules/programs/ssh.nix
    home-manager.users.${config.user} = {
      programs.ssh = {
        enable = true;
        forwardAgent = true;
        hashKnownHosts = true;
        addKeysToAgent = "yes";
        matchBlocks = {
          "catalyst.channings.me" = {
            user = "nemo";
            proxyCommand = "cloudflared --credentials-file ~/.cloudflared/cde1169a-5b87-4f2e-acc5-af61158aea84.json access ssh --hostname %h";
            identityFile = "~/.ssh/catalyst.pub";
            identitiesOnly = true;
          };
        };
      };
      home.file.".ssh/catalyst.pub" = {
        text = ''
          ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOZUgIRZA/86cjnpLUJxm9chv1xgU0N4rJQM7z8RpIQ9
        '';
      };
    };
  };
}
