{ config, pkgs, ... }: {
  imports = [
    ./compatibility.nix
  ];

  config = {
    system.activationScripts.postUserActivation.text = ''
      sudo rm -rf /Applications/1Password.app
      sudo cp -R ${pkgs._1password-gui}/Applications/1Password.app /Applications/
      sudo xattr -d com.apple.quarantine /Applications/1Password.app || true
    '';
  };
}
