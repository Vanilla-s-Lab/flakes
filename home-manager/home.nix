{ ... }:
{
  imports = [ ./programs/chromium.nix ]
    ++ [ ./dconf.nix ];

  home.stateVersion = "21.11";
}
