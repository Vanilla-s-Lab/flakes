{ fetchurl, left, right, ... }: {
  sources = {
    p-jetbrains-jdk-bin = rec {
      pname = "p-jetbrains-jdk-bin";
      version = "${left}-linux-x64-${right}";
      src = fetchurl {
        url = "https://cache-redirector.jetbrains.com/intellij-jbr/jbr_jcef-${version}.tar.gz";
        sha256 = "sha256-9w9AiX6MiCVjt+wVrPzB6mjRplY4tcF3yQeCj9hjVy0=";
      };
    };
  };
}
