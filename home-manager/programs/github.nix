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
    github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
    github.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5dIg6JTJ72pcEpEjcYgXkE2YEFXV1JHnsKgbLWNlhScqb2UmyRkQyytRLtL+38TGxkxCflmO+5Z8CSSNY7GidjMIZ7Q4zMjA2n1nGrlTDkzwDCsw+wqFPGQA179cnfGWOWRVruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn57K5mj0MNdBXA4/WnwH6XoPWJzK5Nyu2zB3nAZp+S5hpQs+p1vN1/wsjk=
    github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
    dev.s-ul.net ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILcwrkikeL2BaAt9NbrXNYhSM9Vk06TixMJ8fX4Kqe25
    dev.s-ul.net ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC63GF4oSjSsQDqoogRK90LESuMx/UJA2hBJg+TjtnBnExWqdcWX9+a7T9qSMwZ4LTVVuUtdmGTzf4hT9nVWWCJrOHhjYc1YCZVh1tMhiUqBriMKbyIkXgbdfratuetUecnsvGFX9u8I6YkQVbrIj/+skNVxE7Qj8nvvAQ9Eb8OwNiu4KOD9Q4CI8ALD0Q+7GlZLRtBSxi+78QKy6Tca7bvGNfHdXIEYnbRkJ5L1A7leTzgP37d2JlZ6QLLGsg1lllHTkU6hGRoYHKOKtfrFXPqr0TNdDgeGa7xO0O8YtdXRD+JqF9eVLuOx4NE2FY5ksUZZe6R03kUg1OhCOlfOFnx
    dev.s-ul.net ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBAYZAHS2GngrGxjskgEQIz+SyC2Q2DdJ8J+ZtTwZErz8Ng/u0kYWQqYH7JVf2ZDgNR7fBdU5GBvxg137K9MlPnw=
    git.tendokyu.moe ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDVpuTdn2fCrwrdUAc8THYjUAersJSexlwcjHIkIVf7zoHV6kVBDeSLsZpDYtYMFl8RIua43lo8JH6goF5+eYEgyP7+faKzsGVNh6fb5Z5AGwAHWkALqwz1sfLkYrA+FKcRU/FoSsKaNgUIMdT1O+MTeHK6K1cjAXgW0F0uaLPipNA+NBX0BYXQICfWs00HwCnQXViYyAL3q8uFImZ1Fz092kbpqkF6+QpIQOGffiVHrrVPfH1iK93VlZvWjDm0H/SYKPVD40YsfOx0XQ7oOTZfmvrfqI9RdM1GVHqaBaPL01I07+erfWs0GNSC/wRURLHq5Juosj6FdCaAj8cr34egyRr1p/8UFq68FgfJY3E2SiH0G1G42FBemZXX1PptFaujtRKEM7cgZYjp0ERMUvclMRaf4XBJo+qaXSdsBgJ39Tyozlb6H/qJaWduMQHm5rxPGYlLIJk/5GI6dH8BnYpqmtVJQQY6p3CIr/tUd7HchcWNjzEpo00HlIOxDR4G6HevtEb09OZEb93KVWIOg7KGLVqvdBQsdVM0MZzN11yrC87kW1ObQsgVLc00ca8CrRG6fPCRgucQqJbtWAhbirwdJSDuIE4ZMhDw309YOFPZDoYBV7IfukueJkKCf72VpGFrdxRDnPrNJsyPkvpHFgfpXJ34eWwOKRaRMhrTjSp+2w==

    59.110.239.227 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPtqICDau0S0ytx6RaGd+FYdLoNuvAfYwnOCm1L6eU6V
    59.110.239.227 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBPyR+72FJ0luNqUIs7EBV2wlCjOHkwOEbe5FuGP3Y3mur49YvCUYDFzzdSbqSRYQfSEPY8z02ojsJnbJ0EY6EyI=

    211.137.105.139 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILAGThb0UHRQkTnjTu6C0BBo1yQ1+hx00R5RcUBP1jnk
    192.168.5.1 ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAB6gHsv2elRunMrxhgAdbTQ2AlU/VWhnUUAFiXrymlc64PM4X6X/2LD1xbvUOKHiWRUVDq0NCn8ta/zQuAhA2XtIgCEji5uK1kjwnr0+mItSJC1XQwetERS0lZ5tpPaGRvJt/14IONaUQkK8hvlrI8M7eAzZsOa5FCU0fCGQdMnb16B+Q==
    192.168.100.1 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILAGThb0UHRQkTnjTu6C0BBo1yQ1+hx00R5RcUBP1jnk

    172.105.209.227 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDe5cPbPPogAJe22Ru7I5Q4hjwYy7eZaKXhlrTArXuHv7av8k26uNpxvKDfkXzn9Vumk57D6jVHJgStx2VxDN1QyiL7zzNyj+KZQJ3LhkXwOJ/uxGGXr1kxfokx5lXEfwbZMxACm8Q027jkhKF5QnOkuaIBM6eqhFRltbjhzhPRUCPl242b2bcKY6lJlCm+u+r2JqzA7ATBP/vTHuDx8fXR/R4oUaSI1eLxsGQFp9aBME1piTHeDmQA0VCns0+GdKHrW12gh3RvcKKwIQQk53pthPKCfVrCoMdBn+MEQgqSfyZucqaYdFaJ7lQ3UYvkh6AVhqSX31Bs8jl4L4mv+m/x+3pp+D0/0x/vwBkQFATLLfVGyantaCtMqYEp3rie4Lz6bPapVRo1/kpA2SZZ/XLIOa/iLOGNqzR3Ecc4t1+K8V0TkQ1piozGhq9p3BCFxIxHniuw6+qHZl7NrSXyK3MKkOlbgJXJCZ0J70mAniUNU04uhXjGEb13Gu2v6OC488MdkbEmDfgiKTKCb2Y5oG6E7SsKdcZWoQ/H5i02P4HMlGYtJHrCVTwR4WosgE3ycyteAmSMZjbY2dxielKV6bvY8caGRNyaMRxxfARmKoZ8X6KNoV86JRoly/88bx+YdDgNgkwANFunPMmzb+YSiPi5J+SS/3JiBCGPlc2ciYJo6w==
    172.105.209.227 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFtNQbUdceH12b4yb/oZ9+okDxHQ8aCgpDCVmN9a9avU

    eu.nixbuild.net ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM

    192.168.6.78 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGnjCAGXq6AJkQXMTqTXe99iP1ICtvCgVtmvVU2qmWcD
    192.168.6.78 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBMjZx23Sh8zgO3gN3CtHh0AWF/LXJ6/d3QPFBOm8FEQNcfZvQ7kiecsqjnSbwaCHKQ4s7V6KBFDHjpra6bBCpmg=
    192.168.0.12 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCiCKMBUVu9BRwBeOgJsIa0oTexPtWMPGtobcmb38Zoa65kZie/zhSbrwlRFQcih1fL25Ie/78u0mwLAPgsHYeJ8lOlae2O5VpCG0wYuYI4Mr2vS03oplOmMyqKiG/mcPRi5pUg3ADc7P0u6v+ZUGNWw3JL9yhJD7iJ0TGVGyiWTbiUYlZacMwFyrofSaGxS7qyKBBI8s518kz0grnfMmOCrnq6loybC+jWk1xwZK0aricNlzD5sCbdbaw2lcJsAHO6qixHmpEpAETE1LLGB73F7lHDXIKqaMQ7pymupR+DOdfH8hh331GxLolLxcPx91knTd9lxySwUswj3jLEBvmEhnUBWBebzNkYXj4xTVjp+FWrc9P7DzVUsl718h21lcxK9nVTTg/Plhosi/c8KK5dwlkezNAWZ2E8Pb/pkEIUFCRfiSwjLjLVAE/Ug4/QDgzOHyRPMtRxXu3EuUZCJ6QpZdTr7HSqtbnruGvXCt7Q/0kTArozDAJlNb2GxyWVwo0=
    192.168.0.12 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBG4cWVoh2QXPsXTMgmTr1CRdcWG0ZgFr/to5nq7+zgCllzmJ/TxQKRuvxx1KxFFPPedUnR5gef+O45d2Bwfel+c=
    192.168.0.12 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOZo8cUXYrIoex2kT3tb2QRpqcwuX7o/nZi1YacQkp+o
  '';

  programs.ssh.matchBlocks = {
    "192.168.6.78".proxyCommand = "nc -x localhost:1080 %h %p";
    # https://cms-sw.github.io/tutorial-proxy.html
    "github.com".proxyCommand = "nc -x localhost:1089 %h %p";
    # https://dev.s-ul.net/domeori/aqua/-/tree/master
    "dev.s-ul.net".proxyCommand = "nc -x localhost:1089 %h %p";
    # https://gitea.tendokyu.moe/Hay1tsme/artemis/src/branch/master
    "git.tendokyu.moe".proxyCommand = "nc -x localhost:1089 %h %p";
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
}
