{ pkgs, lib, inputs, ... }:
{
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "Hack" ]; })
    pkgs.nur.repos.vanilla.Win10_LTSC_2021_fonts
    pkgs.nur.repos.vanilla.apple-fonts.SF-Compact
  ] ++ [ pkgs.noto-fonts-cjk pkgs.twemoji-color-font ];

  # https://github.com/nix-community/home-manager/issues/1118
  fonts.fontconfig.enable = lib.mkForce true;

  home.file.".fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <alias>
        <family>sans-serif</family>
        <prefer>
          <family>Noto Sans CJK SC</family>
          <family>Noto Sans CJK TC</family>
          <family>Noto Sans CJK JP</family>
        </prefer>
      </alias>
      <alias>
        <family>monospace</family>
        <prefer>
          <family>Noto Sans Mono CJK SC</family>
          <family>Noto Sans Mono CJK TC</family>
          <family>Noto Sans Mono CJK JP</family>
        </prefer>
      </alias>
    </fontconfig>
  '';
}
