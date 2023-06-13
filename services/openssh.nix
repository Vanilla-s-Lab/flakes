{ pkgs, lib, ... }:
{
  services.openssh.enable = true;
  services.openssh.openFirewall = false;

  services.openssh.listenAddresses =
    lib.singleton { addr = "127.0.0.1"; port = 22; };

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

  # Only allow pubkeys login.

  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.KbdInteractiveAuthentication = false;

  programs.ssh.knownHostsFiles = pkgs.lib.singleton (pkgs.writeText "localhost.keys" ''
    localhost ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIzKaLzzMh2MvYRcDSvkyB7YXGNIP3IlBUda9ODxd2PX
    localhost ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDH2j9R8CdF/hCzRFGrCY3hXLQ1L/7BWCByAdnLgqLVeaYA5934p45y2rLRg+dQH/tNhZR7esfJsg7n/7v35NCWB//nZBf7jZBIvEH5qBH2pzOsHbNkD4NLGu8xLDPUiDZrafuXUHRrxRMG7kHPT31Qi9X7gzyw4w97WafMRTSxTfupP+Xw/19hlzBXi0Hj3YSUskToIJmQ3wwFFw8iLK8YwZachlwZuqq2vIynN3JBr3URWs+SZvfh3eCxpSTeGItCz1j9ZOH2t9XZ24MGqkZFY/N2OfhvTktnEni2YEiZp7/C4HO9ZAGC8UneWhuQfDjALcvVlhpzhhZqGv3I7KxINyndi4ZHNVGNgU2qghuYRjQdbdS5OA9c5VnRXqr08UBlqal6uqBfh2l/9QHPaCzi/gFrb8No8JSsvojJxiUa6F4EXbHV624o69Q/b1onXWrLhQaMRATygPL3er4SBv5RAiYXO7vnCFcOMo9ZSEsx9OfXJK+ysEH73IlNURWzMFTzLt8dy/xfIdLJw25C7f2Q59tKgGVU+CPFqlMi/ev5k/EJ36MKoOTwsHgYRdGqnIUGDgTcW4MSDeHpAzrPDuaZL7hwFLgh6ZRAMNIO5TOpqDO7ne6zqGUxvPs1qNFfSqTrc7fW/bS0TbfXJpgXOE5l7ABd+/Ez996I+h4CRSxf3w==
  '');
}
