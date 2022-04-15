{ lib, pkgs, ... }:
{
  # https://nixos.wiki/wiki/Git
  programs.git.enable = true;
  programs.git.userName = "Vanilla";
  programs.git.userEmail = "osu_Vanilla@126.com";

  # https://git-lfs.github.com/
  programs.git.lfs.enable = true;

  # Use YubiKey GPG sign the commit by default.
  programs.git.signing.key = "3750028ED04FA42E";
  programs.git.signing.signByDefault = true;

  # ~/.gnupg databasem but immutable.
  programs.gpg.enable = true;
  programs.gpg.mutableKeys = false;
  programs.gpg.mutableTrust = false;

  # https://keys.openpgp.org/search?q=3750028ED04FA42E
  programs.gpg.publicKeys = [{
    text = lib.readFile (pkgs.fetchurl rec {
      name = "2649340CC909F821D25167143750028ED04FA42E";
      url = "https://keys.openpgp.org/vks/v1/by-fingerprint/${name}";
      hash = "sha256-+Fvo5r2VwM2nrSmdyqkmY7isWgnDJgyRt2teFQ+veqg=";
    });

    trust = "ultimate";
  }];

  # GPG agent, also enable sub SSH key.
  services.gpg-agent.enable = true;
  services.gpg-agent.enableSshSupport = true;

  # Pinentry curses is a TUI password ipnut box.
  services.gpg-agent.pinentryFlavor = "gnome3";
  home.sessionVariables = { SSH_AUTH_SOCK = "/run/user/1000/gnupg/S.gpg-agent.ssh"; };

  # Trust GitHub server in known_hosts.
  programs.ssh.enable = true;
  # https://github.blog/2021-09-01-improving-git-protocol-security-github/
  home.file.".ssh/known_hosts".text = ''
    github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
    github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
    github.com ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
  '';

  # https://nixos.wiki/wiki/Git#git-gc
  programs.git.extraConfig."pack" = {
    windowMemory = "2g";
    packSizeLimit = "1g";
  };

  # https://cms-sw.github.io/tutorial-proxy.html
  programs.ssh.matchBlocks."github.com" = {
    host = "github.com";
    user = "git";
    proxyCommand = "nc -x localhost:1089 %h %p";
  };

  programs.git.extraConfig = {
    init.defaultBranch = "master";
  };
}
