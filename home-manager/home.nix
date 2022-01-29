{ ... }:
{
  imports = [ ./programs/chromium.nix ]
    ++ [ ./dconf.nix ./nix-cache.nix ]
    ++ [ ./programs/alacritty.nix ];

  home.stateVersion = "21.11";
}
