{ lib, fetchFromGitHub, rustPlatform, darwin, clang, libclang }:

rustPlatform.buildRustPackage rec {
  pname = "nu_plugin_plist";
  version = "0.94.0";

  buildInputs = [ darwin.IOKit clang ];
  nativeBuildInputs = [ darwin.IOKit libclang ];

  src = fetchFromGitHub {
    owner = "ayax79";
    repo = pname;
    rev = "1b6ce58bedfe4dcfc9d2853f604b62b919acf73f";
    hash = "sha256-iPXVYpAbCMtAzxhNKrID1XMc/65PfkC4m4AxzeiZ8dI=";
  };

  cargoHash = "sha256-mpCQsXzv9Amly5ct1xQ2ObmW84zghPGZLDyuFpUs6Jc=";

  meta = {
    description = "Plugin for handling plist files in nu";
    homepage = "https://github.com/ayax79/nu_plugin_plist";
    license = lib.licenses.mit;
    maintainers = [];
  };
}
