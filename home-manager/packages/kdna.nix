{ pkgsUnstable, inputs, ... }:
let dsm = "Telegram/SourceFiles/data/data_sponsored_messages.cpp"; in
let kd = (import inputs.ilya-fedin { pkgs = pkgsUnstable; }).kotatogram-desktop; in
rec {
  self = (kd.overrideAttrs (old: {
    patchPhase = "sed -i 's/history->isChannel()/0/g' ${dsm}";
  }));

  autostart = pkgsUnstable.makeDesktopItem rec {
    name = "kotatogramdesktop";
    exec = "${self}/bin/kotatogram-desktop -autostart";
    desktopName = name;
  };
}
