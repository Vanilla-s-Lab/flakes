{ ... }:
{
  services.openssh.enable = true;
  services.openssh.openFirewall = true;

  services.openssh.hostKeys = [
    {
      bits = 4096;
      path = "/persistent/etc/ssh/ssh_host_rsa_key";
      type = "rsa";
    }
    {
      path = "/persistent/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }
  ];

  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = false;
  services.openssh.kbdInteractiveAuthentication = false;
}
