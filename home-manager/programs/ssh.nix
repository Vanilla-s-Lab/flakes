{ ... }:
{
  programs.ssh.enable = true;
  home.file.".ssh/known_hosts".text = ''
    github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
  '';

  programs.fish.interactiveShellInit = ''
    set UID (id -u vanilla)
    export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
  '';
}
