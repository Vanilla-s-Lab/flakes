{ fetchurl, ... }: {
  sources = {
    p-jetbrains-jdk-bin = {
      pname = "p-jetbrains-jdk-bin";
      version = "17_0_2-linux-x64-b315.1";
      src = fetchurl {
        url = "https://cache-redirector.jetbrains.com/intellij-jbr/jbr_jcef-17_0_2-linux-x64-b315.1.tar.gz";
        sha256 = "sha256-ImnQgErO3f7lNVHSSCKaPAD3RMsK2jmdA6VWX2WI2qA=";
      };
    };
  };
}
