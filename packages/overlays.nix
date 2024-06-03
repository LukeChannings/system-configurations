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
    });
})
