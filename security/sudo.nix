{ ... }:
{
  security.sudo.enable = true;

  # https://superuser.com/questions/500119
  security.sudo.extraConfig = "Defaults lecture = never";
}
