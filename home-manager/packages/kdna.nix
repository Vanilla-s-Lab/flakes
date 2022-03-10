{ pkgs, inputs, ... }:
let dsm = "Telegram/SourceFiles/data/data_sponsored_messages.cpp"; in
let kd = (import inputs.ilya-fedin { inherit pkgs; }).kotatogram-desktop; in
rec {
  # self = (pkgs.nur.repos.ilya-fedin.kotatogram-desktop.overrideAttrs (old: {
  self = (kd.overrideAttrs (old: {
    patchPhase = "sed -i 's/history->isChannel()/0/g' ${dsm}";
  }));

  autostart = pkgs.makeDesktopItem rec {
    name = "kotatogramdesktop";
    exec = "${self}/bin/kotatogram-desktop -autostart";
    desktopName = name;
  };
}
