{ buildGoModule, fetchgit, ... }:
buildGoModule rec {
  pname = "docker-lock";
  version = "v0.8.10";

  src = fetchgit {
    url = "https://github.com/safe-waters/${pname}";
    rev = "${version}";
    hash = "sha256-5NSTerRaa8l+Bds02WNyXFOR8WcdvBGkd2h7rDIoS9k=";
  };

  vendorSha256 = "sha256-2fE8Nzm7QheIihE0z0/N5zUJtC+G2B9IAKG63AWvyHc=";
}
