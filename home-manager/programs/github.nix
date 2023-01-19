{ lib, pkgs, inputs, system, config, nixosConfig, ... }:
{
  # https://nixos.wiki/wiki/Git
  programs.git.enable = true;
  programs.git.package = pkgs.gitFull;

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
  }] ++ [{
    source = ../../secrets/nixos-rot.asc;
    trust = "ultimate";
  }] ++ [{
    source = ../../secrets/nixos-linode.asc;
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

    59.110.239.227 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPtqICDau0S0ytx6RaGd+FYdLoNuvAfYwnOCm1L6eU6V
    59.110.239.227 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBPyR+72FJ0luNqUIs7EBV2wlCjOHkwOEbe5FuGP3Y3mur49YvCUYDFzzdSbqSRYQfSEPY8z02ojsJnbJ0EY6EyI=
    211.137.105.139 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILAGThb0UHRQkTnjTu6C0BBo1yQ1+hx00R5RcUBP1jnk
    192.168.5.1 ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAB6gHsv2elRunMrxhgAdbTQ2AlU/VWhnUUAFiXrymlc64PM4X6X/2LD1xbvUOKHiWRUVDq0NCn8ta/zQuAhA2XtIgCEji5uK1kjwnr0+mItSJC1XQwetERS0lZ5tpPaGRvJt/14IONaUQkK8hvlrI8M7eAzZsOa5FCU0fCGQdMnb16B+Q==

    172.105.209.227 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDe5cPbPPogAJe22Ru7I5Q4hjwYy7eZaKXhlrTArXuHv7av8k26uNpxvKDfkXzn9Vumk57D6jVHJgStx2VxDN1QyiL7zzNyj+KZQJ3LhkXwOJ/uxGGXr1kxfokx5lXEfwbZMxACm8Q027jkhKF5QnOkuaIBM6eqhFRltbjhzhPRUCPl242b2bcKY6lJlCm+u+r2JqzA7ATBP/vTHuDx8fXR/R4oUaSI1eLxsGQFp9aBME1piTHeDmQA0VCns0+GdKHrW12gh3RvcKKwIQQk53pthPKCfVrCoMdBn+MEQgqSfyZucqaYdFaJ7lQ3UYvkh6AVhqSX31Bs8jl4L4mv+m/x+3pp+D0/0x/vwBkQFATLLfVGyantaCtMqYEp3rie4Lz6bPapVRo1/kpA2SZZ/XLIOa/iLOGNqzR3Ecc4t1+K8V0TkQ1piozGhq9p3BCFxIxHniuw6+qHZl7NrSXyK3MKkOlbgJXJCZ0J70mAniUNU04uhXjGEb13Gu2v6OC488MdkbEmDfgiKTKCb2Y5oG6E7SsKdcZWoQ/H5i02P4HMlGYtJHrCVTwR4WosgE3ycyteAmSMZjbY2dxielKV6bvY8caGRNyaMRxxfARmKoZ8X6KNoV86JRoly/88bx+YdDgNgkwANFunPMmzb+YSiPi5J+SS/3JiBCGPlc2ciYJo6w==
    172.105.209.227 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFtNQbUdceH12b4yb/oZ9+okDxHQ8aCgpDCVmN9a9avU

    172.16.3.4 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILYZDo9eXAfilg+ghMFfb5mYN19GFrHb4ONbZWbAJb+Q
    172.16.3.4 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCuE1yo24oo8GtUFimMgvIdL5Y5PSVTVtuXKKvlAsLBVBlF5Hv0fn0cK0h+jH6F3AnNZbl/M93OU42wAiakh5ZYuc+Igd5cmKx9LxoLfuYjPn+wlqKjzo4+wVfmeHwJ0DEMbX6mVQ1ExyOpV0EQq8gXZtvfx2pK7gTUNGGPu/e58DWJsJcV6ZTiRJJ9pP2ot7tdTRmi5P29jQKPhdQjZnD+6enDce0jQkTV9FdXZ+WFdcvczpoO44Az9kAL9G0vEik+9FYL3inc62ASlNEYZ1SP4C+9AZ67RqlAaGUeyGddYh4sGnS49bL0I78eF9uclS+AmUYo9tVb4X1/faVGXmc6ucwmGGLGQLhvf/pqvB6sbQ6AzBK2SM2poKSVj3N6afMGrB9hGv72kKqul3lMAZsiJ7Sj8J8kXQsYJ2gIipST9sNgFq4/RYYsPp2rNJIjB3deoM3GEoa86JlXgZqwIqQ8pLLM6N6S+JS9SsIDXe6Ecljh/yNQ+4OqkQ4JS2vKmN7Er7+WlXhehMl6G81s0vTggUNBXpEW8JmK/dAGpWt2wK/B/s3kE4Id9//eddGlrCVl3zEisy8xutURmoY76AWMQuAZefz6jPZJqB9z4hiQ//ClGmW542pXzi/5aRtd+3TSjJDO4gC0tgrWDTy3P+bFExvj9+2rGAW1mC5FSECAZw==
  '' + "eu.nixbuild.net ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM" + ''
    192.168.6.78 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGnjCAGXq6AJkQXMTqTXe99iP1ICtvCgVtmvVU2qmWcD
    192.168.6.78 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBMjZx23Sh8zgO3gN3CtHh0AWF/LXJ6/d3QPFBOm8FEQNcfZvQ7kiecsqjnSbwaCHKQ4s7V6KBFDHjpra6bBCpmg=
  '';

  programs.ssh.matchBlocks."192.168.6.78" = {
    host = "192.168.6.78";
    proxyCommand = "nc -x localhost:1080 %h %p";
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

  home.packages = [
    pkgs.difftastic
    pkgs.gh # GitHub CLI
    pkgs.nix-index

    # https://docs.nixbuild.net/configuration/
    pkgs.rlwrap
  ];

  # https://docs.nixbuild.net/getting-started/
  programs.ssh.matchBlocks."nixbuild" = {
    host = "eu.nixbuild.net";
    extraOptions."PubkeyAcceptedKeyTypes" = "ssh-ed25519";
    identityFile = "/home/vanilla/.ssh/id_ed25519";
  };

  # https://difftastic.wilfred.me.uk/git.html
  programs.git.extraConfig."diff" = { tool = "difftastic"; };
  programs.git.extraConfig."difftool" = { prompt = false; };
  programs.git.extraConfig."difftool \"difftastic\"" = { cmd = "difft $LOCAL $REMOTE"; };

  programs.git.extraConfig."pager" = { difftool = true; };
  programs.git.extraConfig."alias" = { dft = "difftool"; };

  home.file.".config/nix/nix.conf".source =
    config.lib.file.mkOutOfStoreSymlink
      nixosConfig.sops.templates."nix.conf".path;

  # https://github.com/Mic92/nix-index-database
  home.file.".cache/nix-index/index-x86_64-linux".source =
    inputs.nix-index-database.legacyPackages."${system}".database;
  home.file.".cache/nix-index/files".source =
    config.home.file.".cache/nix-index/index-x86_64-linux".source;

  home.file.".config/gh/hosts.yml".source =
    config.lib.file.mkOutOfStoreSymlink
      nixosConfig.sops.templates."gh_hosts".path;

  home.file.".docker/config.json".source =
    config.lib.file.mkOutOfStoreSymlink
      nixosConfig.sops.templates."docker".path;
}
