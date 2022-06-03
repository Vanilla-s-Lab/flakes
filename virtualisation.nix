{ pkgs, inputs, lib, ... }:
{
  # https://nixos.wiki/wiki/Virt-manager
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.swtpm.enable = true;

  users.users."vanilla".extraGroups = [ "libvirtd" ]
    ++ [ "docker" ]; # https://nixos.wiki/wiki/Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings =
    { fixed-cidr-v6 = "fd00::/80"; ipv6 = true; };

  systemd.tmpfiles.rules = [
    "L /var/lib/docker - - - - /persistent/var/lib/docker"
  ];

  # The default KVM virtual storage location.
  environment.persistence."/persistent" = {
    directories = [ "/var/lib/libvirt" ];
  };

  # Support running binary of armv7l architecture.
  boot.binfmt.emulatedSystems = [ "armv7l-linux" "aarch64-linux" ];

  # https://nixos.wiki/wiki/Podman
  virtualisation.podman.enable = true;

  # https://nixos.wiki/wiki/VirtualBox
  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = [ "vanilla" ];
  # virtualisation.virtualbox.host.enableExtensionPack = true;

  # virtualisation.oci-containers.containers."mssql" = {
  #   # https://hub.docker.com/_/microsoft-mssql-server
  #   environment = {
  #     ACCEPT_EULA = "Y";
  #     SA_PASSWORD = "yourStrong(!)Password";
  #   };

  #   ports = (lib.singleton "1433:1433");
  #   image = "mcr.microsoft.com/mssql/server:latest";

  #   # Always remember do `sudo chmod 777 /persistent/var/opt/mssql`.
  #   # https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-configure
  #   volumes = (lib.singleton "/persistent/var/opt/mssql:/var/opt/mssql");
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 1433 ];
  # networking.firewall.allowedUDPPorts = [ 1433 ];
}
