{ ... }:
{
  services.openssh.enable = true;
  services.openssh.openFirewall = true;

  environment.etc."ssh/ssh_host_ed25519_key".source =
    "/persistent/etc/ssh/ssh_host_ed25519_key";
  environment.etc."ssh/ssh_host_ed25519_key.pub".source =
    "/persistent/etc/ssh/ssh_host_ed25519_key.pub";
  environment.etc."ssh/ssh_host_rsa_key".source =
    "/persistent/etc/ssh/ssh_host_rsa_key";
  environment.etc."ssh/ssh_host_rsa_key.pub".source =
    "/persistent/etc/ssh/ssh_host_rsa_key.pub";
}
