{ ... }:
{
  services.gpg-agent.enable = true;
  services.gpg-agent.enableSshSupport = true;

  services.gpg-agent.pinentryFlavor = "curses";
  programs.fish.interactiveShellInit = ''
    gpg-connect-agent updatestartuptty /bye > /dev/null
    gpg --card-status 2&> /dev/null
  '';
}
