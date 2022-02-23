{ pkgs, nixosConfig, ... }:
let hysteria_bin = pkgs.stdenv.mkDerivation rec {
  pname = "hysteria";
  version = "0.9.7";

  src = pkgs.fetchurl {
    url = "https://github.com/HyNetwork/hysteria" +
      "/releases/download/v${version}/${pname}-linux-amd64";
    hash = "sha256-5TIurHhXsTxl77e5+cZLH9OAVwgTdFL9PmI+Xl9ODlw=";
  };

  unpackPhase = "echo";
  installPhase = ''
    mkdir -p $out/bin && cp ${src} $out/bin/hysteria
    chmod +x $out/bin/hysteria
  '';
}; in
{
  home.packages = [
    hysteria_bin
  ];

  systemd.user.services."hysteria" = {
    Service.ExecStart = "${hysteria_bin}/bin/hysteria -c "
      + nixosConfig.sops.templates.hysteria.path + " --no-check";

    # Uncomment this line to enable.
    # Install.WantedBy = [ "default.target" ];

    Unit.Wants = "wait-nm-online.service";
    Unit.After = "wait-nm-online.service";
  };

  # https://unix.stackexchange.com/questions/216919
  systemd.user.services."wait-nm-online" = {
    Service.Type = "oneshot";
    Service.ExecStart = "${pkgs.networkmanager}/bin/nm-online";
    Service.RemainAfterExit = "yes";
    Install.WantedBy = [ "default.target" ];
  };
}
