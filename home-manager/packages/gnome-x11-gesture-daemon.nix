{ rustPlatform, fetchgit, pkg-config, libudev, libinput, ... }:
rustPlatform.buildRustPackage rec {
  pname = "gnome-x11-gesture-daemon";
  version = "0.2.1";

  src = fetchgit {
    url = "https://github.com/harshadgavali/${pname}";
    rev = "v${version}";
    hash = "sha256-vTmW1jEUO/W8CafdYb8/TwvXW7KH2VAuxXTMiW/Xlsw=";
  };

  # cargoSha256 = "";
  cargoHash = "sha256-JE639JZB/fOe3qz50cxoZPBVt9FPouQNRSkJJPOE7vs=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ libudev libinput ];
}
