{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    apps.chromium.enable = lib.mkEnableOption "Chromium";
  };

  config = lib.mkIf config.apps.chromium.enable {
    home-manager.users.${config.user} = {
      programs.chromium = {
        enable = true;
        package = if pkgs.stdenv.isDarwin then pkgs.chromium-macos else pkgs.chromium;
        extensions = [
          { "id" = "fmkadmapgofadopljbjfkapdkoienihi"; } # React Developer Tools
          { "id" = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1Password
        ];
      };

      home.file."Library/Application Support/Chromium/NativeMessagingHosts/com.1password.1password.json".text = ''
        {
          "name": "com.1password.1password",
          "description": "1Password BrowserSupport",
          "path": "/Applications/1Password.app/Contents/Library/LoginItems/1Password Browser Helper.app/Contents/MacOS/1Password-BrowserSupport",
          "type": "stdio",
          "allowed_origins": [
            "chrome-extension://aeblfdkhhhdcdjpifhhbdiojplfjncoa/"
          ]
        }
      '';
    };
  };
}
