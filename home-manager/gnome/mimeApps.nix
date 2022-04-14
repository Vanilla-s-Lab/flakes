{ ... }:
{
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
    "application/pdf" = [ "org.gnome.Evince.desktop" ];
  };
}
