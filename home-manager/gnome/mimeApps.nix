{ ... }:
{
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
    "application/pdf" = [ "org.gnome.Evince.desktop" ];
    "text/plain" = [ "org.gnome.gedit.desktop" ];

    "image/jpeg" = [ "org.gnome.eog.desktop" ];
    "image/png" = [ "org.gnome.eog.desktop" ];
    "image/webp" = [ "org.gnome.eog.desktop" ];

    "image/x-panasonic-rw" = [ "org.wireshark.Wireshark.desktop" ];
  };
}
