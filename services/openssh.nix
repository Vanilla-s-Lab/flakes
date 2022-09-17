{ pkgs, ... }:
{
  services.openssh.enable = true;
  services.openssh.openFirewall = false;

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
  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = false;
  services.openssh.kbdInteractiveAuthentication = false;

  users.users."vanilla".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPVpgJtK1tTpURq6XH3xibH+6VdU8/2igxpQs4aAkaoy harukacamber@gmail.com"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIDE95EP7cDv8HSut6KcvFOBzNB6eA0byCkYkkn4YZ8tDAAAABHNzaDo= vanilla@NixOS-Laptop"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDrr1hJLnVmUFa9CNFAGZTvYZbO9E4zw2LeQUOQaUa7UuQx/Y629OHwkH8mG34Usj32wqb8slqDJvJeOdRlPFSNs56bE0CAef0+ecI3YiVOW83YbLY4Tm4zi2FLew8Qh9SaU2aJDLhUUCit8mcndJ0x8SesPyjUPoLkas5ebCNhwxt4FMwUYxahbGRqqrkhKGuODNNNg02GmqtCrWVU9oqGrL9Qgbw0SEGKjBvixFMcAcx7ihj1cswJDlh7L87RGLCFgwptetjGTUTfZTKR8kSPnet3lcK9EtV0fQ1B/M6h3mOE8EWRm2VIVusIlZ2Pr6MEunlFkqvWNAb/LKTNdGLu3yvI+gP51TVDhG2chNgFQuETXOiIQdFcpOMiRCs0O5iJJV3G4dshKM9ZqE/Ju1N9siY2W3suUj6P2KcvikGqs1KRSp8seXoSilo0o5pwVIXSNYWOUaf17vbKvYqrcgtRwjyK3pab6fVa+paz3YLF19Rq1l3duEXcTSxroBGQ5+25wwgDUe2NuUzokg64q+eje/DSBqmHpDP4pipRZ58zv0NGhErnnPGXwSdLjtS8IO/3FToa5VWSxxWc2CAnBMYPo1gr2a3B1mnO8opXgrsV+nUaYGLA4+Ubv+KUBtyaBrjw2XI/C4qvv3pYU/5cElhHebL8uEYxRd/JOKFRKMQ2xw== cardno:16 155 718"
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBHbe4m1Jc0x/kDNH4m4fHHpqihcGoQ9VX4kcQR/JwNLSVrBtcEYUmsOkMXbmy88LXfsevrSgUEVZs31zCyQM9NM= cardno:16 155 718"
  ];

  programs.ssh.knownHostsFiles = pkgs.lib.singleton (pkgs.writeText "localhost.keys" ''
    localhost ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIzKaLzzMh2MvYRcDSvkyB7YXGNIP3IlBUda9ODxd2PX
    localhost ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDH2j9R8CdF/hCzRFGrCY3hXLQ1L/7BWCByAdnLgqLVeaYA5934p45y2rLRg+dQH/tNhZR7esfJsg7n/7v35NCWB//nZBf7jZBIvEH5qBH2pzOsHbNkD4NLGu8xLDPUiDZrafuXUHRrxRMG7kHPT31Qi9X7gzyw4w97WafMRTSxTfupP+Xw/19hlzBXi0Hj3YSUskToIJmQ3wwFFw8iLK8YwZachlwZuqq2vIynN3JBr3URWs+SZvfh3eCxpSTeGItCz1j9ZOH2t9XZ24MGqkZFY/N2OfhvTktnEni2YEiZp7/C4HO9ZAGC8UneWhuQfDjALcvVlhpzhhZqGv3I7KxINyndi4ZHNVGNgU2qghuYRjQdbdS5OA9c5VnRXqr08UBlqal6uqBfh2l/9QHPaCzi/gFrb8No8JSsvojJxiUa6F4EXbHV624o69Q/b1onXWrLhQaMRATygPL3er4SBv5RAiYXO7vnCFcOMo9ZSEsx9OfXJK+ysEH73IlNURWzMFTzLt8dy/xfIdLJw25C7f2Q59tKgGVU+CPFqlMi/ev5k/EJ36MKoOTwsHgYRdGqnIUGDgTcW4MSDeHpAzrPDuaZL7hwFLgh6ZRAMNIO5TOpqDO7ne6zqGUxvPs1qNFfSqTrc7fW/bS0TbfXJpgXOE5l7ABd+/Ez996I+h4CRSxf3w==
  '');
}
