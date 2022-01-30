{ ... }:
{
  services.gpg-agent.enable = true;
  services.gpg-agent.enableSshSupport = true;
  services.gpg-agent.pinentryFlavor = "curses";
}
