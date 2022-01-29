{ ... }:
{
  imports = [ ./programs/chromium.nix ]
    ++ [ ./dconf.nix ./file-links.nix ]
    ++ [ ./programs/alacritty.nix ]
    ++ [ ./fonts.nix ];

  home.stateVersion = "21.11";
}
