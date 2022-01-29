{ ... }:
{
  imports = [ ./programs/chromium.nix ]
    ++ [ ./dconf.nix ./nix-cache.nix ];

  home.stateVersion = "21.11";
}
