{ pkgs, ... }:
{
  nix = {
    nixPath = [ "nixpkgs=${pkgs.path}" ];

    registry.nixpkgs.to = {
      type = "path";
      path = builtins.toString pkgs.path;
    };

    settings.experimental-features = ["nix-command" "flakes"];
    settings.warn-dirty = false;

    settings.trusted-users = [ "root" "luke" ];
    settings.trusted-public-keys = [ "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" ];
    settings.extra-substituters = [
      "https://devenv.cachix.org"
    ];
  };
}
