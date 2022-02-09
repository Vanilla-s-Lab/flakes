{ pkgs, ... }:
let dsm = "Telegram/SourceFiles/data/data_sponsored_messages.cpp"; in
rec {
  self = (pkgs.nur.repos.ilya-fedin.kotatogram-desktop.overrideAttrs (old: {
    patchPhase = "sed -i 's/history->isChannel()/0/g' ${dsm}";
  }));

  autostart = pkgs.makeDesktopItem rec {
    name = "kotatogramdesktop";
    exec = "${self}/bin/kotatogram-desktop -autostart";
    desktopName = name;
  };
}
