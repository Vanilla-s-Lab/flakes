{ pkgs, lib, ... }:
{
  home.packages = [ pkgs.gnome.gnome-system-monitor ];
  dconf.settings."org/gnome/gnome-system-monitor" = {
    current-tab = "resources";
    window-state = lib.hm.gvariant.mkTuple [ 700 526 50 50 ];
  };
}
