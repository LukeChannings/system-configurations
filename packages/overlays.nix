{ ... }:
(self: super: {
  nushellPlugins = super.nushellPlugins.overrideScope (
    final: current: { plist = (self.callPackage ./development/nu/plugins/plist { }); }
  );

  nix = super.nixVersions.nix_2_22;

  brewCasks =
    let
      overrideHash = (
        name: hash:
        super.brewCasks.${name}.overrideAttrs (oldAttrs: {
          src = super.fetchurl {
            url = builtins.head oldAttrs.src.urls;
            inherit hash;
          };
        })
      );
    in
    super.brewCasks
    // (builtins.mapAttrs overrideHash {
      apparency = "sha256-XKxWxqfxy9AQneILLrN9XqLt4/k2N8yumZ5mrSvczFk=";
      suspicious-package = "sha256-VKKbiO/0CIdY5OW19fAmJFHQfyZDNIY9MvGsFt9VD9s=";
      bonjour-browser = "sha256-+crlyoU0zPu+oilrTyLIOO61H7U9bkyDWe8EpWJfnOQ=";
      audio-hijack = "sha256-1ebSzwzvdcfkVlCjizIbEaGaSypyi0nDLEHpZRRVymA=";
    })
    // {
      chromium =
        let
          version = "1323267";
          hash = "sha256-wTTH1+5MgO14jMSkR0BACy8KaDCvUnROdU4KNOtbinM=";
        in
        super.brewCasks.chromium.overrideAttrs (oldAttrs: {
          name = "chromium";

          src = super.fetchurl {
            url = "https://commondatastorage.googleapis.com/chromium-browser-snapshots/Mac_Arm/${version}/chrome-mac.zip";
            inherit hash;
          };

          installPhase =
            oldAttrs.installPhase
            + ''
              mv $out/Applications/chrome-mac/Chromium.app $out/Applications/Chromium.app
              rmdir $out/Applications/chrome-mac
            '';
        });
    };
})
