{ pkgs, lib, ... }:
{
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
  users.users."vanilla".extraGroups = [ "wireshark" ];

  # networking.firewall.enable = false;
  networking.firewall.allowPing = false;

  # https://gitlab.freedesktop.org/NetworkManager/NetworkManager/-/issues/713#note_890189
  # https://unix.stackexchange.com/questions/67898/using-the-not-equal-operator-for-string-comparison
  networking.networkmanager.dispatcherScripts = lib.singleton {
    source = pkgs.writeText "50-delete-lease" ''
      ifname="$1"
      event="$2"

      [ "$ifname" != enp3s0f1 ] && [ "$ifname" != wlp0s20f3 ] && exit 0
      [ "$event" != down ] && exit 0

      rm /var/lib/NetworkManager/*-"$CONNECTION_UUID"-"$ifname".lease
    '';

    type = "basic";
  };
}
