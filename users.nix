{ pkgs, inputs, lib, ... }: with inputs;
let hashedPassword = "$6$NixOS/RoT$eo8dkH7eCxYFh/YkSOzDp7lIG1iQZm5MY2L5IPRh/1YIWMmypVPlagNhUyshl9Kt.nklEB1ZMoSylU5.MrOLa/"; in
{
  # https://elis.nu/blog/2020/05/nixos-tmpfs-as-root/
  users.mutableUsers = false;

  programs.adb.enable = true;

  services.udev.enable = true;
  services.udev.packages = [ pkgs.android-udev-rules ];

  users.users."vanilla" = {
    isNormalUser = true;
    inherit hashedPassword;

    # Enable ‘sudo’ for the user.
    extraGroups = [ "wheel" "adbusers" ];

    uid = 1000;

    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDrr1hJLnVmUFa9CNFAGZTvYZbO9E4zw2LeQUOQaUa7UuQx/Y629OHwkH8mG34Usj32wqb8slqDJvJeOdRlPFSNs56bE0CAef0+ecI3YiVOW83YbLY4Tm4zi2FLew8Qh9SaU2aJDLhUUCit8mcndJ0x8SesPyjUPoLkas5ebCNhwxt4FMwUYxahbGRqqrkhKGuODNNNg02GmqtCrWVU9oqGrL9Qgbw0SEGKjBvixFMcAcx7ihj1cswJDlh7L87RGLCFgwptetjGTUTfZTKR8kSPnet3lcK9EtV0fQ1B/M6h3mOE8EWRm2VIVusIlZ2Pr6MEunlFkqvWNAb/LKTNdGLu3yvI+gP51TVDhG2chNgFQuETXOiIQdFcpOMiRCs0O5iJJV3G4dshKM9ZqE/Ju1N9siY2W3suUj6P2KcvikGqs1KRSp8seXoSilo0o5pwVIXSNYWOUaf17vbKvYqrcgtRwjyK3pab6fVa+paz3YLF19Rq1l3duEXcTSxroBGQ5+25wwgDUe2NuUzokg64q+eje/DSBqmHpDP4pipRZ58zv0NGhErnnPGXwSdLjtS8IO/3FToa5VWSxxWc2CAnBMYPo1gr2a3B1mnO8opXgrsV+nUaYGLA4+Ubv+KUBtyaBrjw2XI/C4qvv3pYU/5cElhHebL8uEYxRd/JOKFRKMQ2xw== cardno:16_155_718"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBHbe4m1Jc0x/kDNH4m4fHHpqihcGoQ9VX4kcQR/JwNLSVrBtcEYUmsOkMXbmy88LXfsevrSgUEVZs31zCyQM9NM= cardno:16_155_718"
    ];
  };
}
