{ pkgs, ... }:
let hashedPassword = "$6$NixOS/RoT$eo8dkH7eCxYFh/YkSOzDp7lIG1iQZm5MY2L5IPRh/1YIWMmypVPlagNhUyshl9Kt.nklEB1ZMoSylU5.MrOLa/"; in
{
  users.mutableUsers = false;
  users.defaultUserShell = pkgs.fish;

  users.users."vanilla" = {
    isNormalUser = true;
    inherit hashedPassword;
    extraGroups = [ "wheel" ];
  };
}
