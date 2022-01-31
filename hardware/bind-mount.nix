{ ... }:
{
  # https://github.com/fish-shell/fish-shell/issues/8627
  fileSystems."/home/vanilla/.local/share/fish" = {
    device = "/persistent/dot/local/share/fish";
    options = [ "bind" ];
  };
}
