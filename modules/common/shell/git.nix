{lib, config, ...}:
{
  options.shell.git.enable = lib.mkEnableOption "git";

  config = lib.mkIf config.shell.git.enable {
    home-manager.users.${config.user} = {
      programs.git = {
        enable = true;
        userName = config.fullName;
        userEmail = config.gitEmail;
        signing = {
          key = config.gitSigningKey;
          signByDefault = config.gitSigningKey != null;
        };

        extraConfig = {
          rebase.autostash = true;
          push.autosetupremote = true;
        };

        lfs.enable = true;
        difftastic.enable = true;
      };
    };
  };
}
