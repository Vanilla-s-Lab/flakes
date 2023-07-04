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
    github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
    github.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5dIg6JTJ72pcEpEjcYgXkE2YEFXV1JHnsKgbLWNlhScqb2UmyRkQyytRLtL+38TGxkxCflmO+5Z8CSSNY7GidjMIZ7Q4zMjA2n1nGrlTDkzwDCsw+wqFPGQA179cnfGWOWRVruj16z6XyvxvjJwbz0wQZ75XK5tKSb7FNyeIEs4TT4jk+S4dhPeAUC5y+bDYirYgM4GC7uEnztnZyaVWQ7B381AK4Qdrwt51ZqExKbQpTUNn+EjqoTwvqNj4kqx5QUCI0ThS/YkOxJCXmPUWZbhjpCg56i+2aB6CmK2JGhn57K5mj0MNdBXA4/WnwH6XoPWJzK5Nyu2zB3nAZp+S5hpQs+p1vN1/wsjk=
    github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=
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

    10.0.99.104 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ5vK508glRw9z8zs4m1VuAq2PBcdDRNhcxjm5wikx3y
    10.0.99.104 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBNk1J3dVQDoJKQ2/CIHZExuK3bXJilddl7SGRAFYUuY4pcTXgNHfs4h0Ea/m/LBeS+FcseimYdkM84D4MtwdiSc=
    10.0.99.101 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDCUFDUZHk91HyL2bctTCBp2eu4e0kGsiHsHMQrni5r0EO8wqdHnBDhrryYqbjBaBqbVzbrItD1dIbpbYIEQ9acW6hV14DK6LuP2ERcGeIK6nbD4L6DViwD3zCKb5qaM7moHPZhlob6wq95itoSXAKMbSIebg+WFNIQ3WMTqgPTWDieRwwv8M153tHulHRCPwk9FU+Rh0rQ75/BdajyhPgJNm9vN4pVCZZKLsYv7rYZiay6LIgr7MRo1u/qMUAINm5MhR2Mt9NdHdibuB2beLRCR/8nxDszvkVwM58i977p6mlicqofu6hK06+hUKhONdX5XMGRtlmlDGiNQOgvZ2l0Eg7FmU6CoDB2y7ZTcWQ1/4ia3yfUFbDdqoSniOjWJo+KqhYd17z1EwG9shxSgvTABNb4/MSoo9u1XFNavaAVE7j+boPaIed0nniVwYsA2kHVuTWPi4hMYMqBLMIB/Eh/OatTEuabARGw/iZj2+dtr9238VRCl1C9dI705CW6UEk=
    10.0.99.101 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBD6zNucbtkWwHG+ti6imZ7LxCE0qE14XZgRL4kgvSiDglmQHhV0CO2AeeZks1oY1LqRFxkqWUQ+6YyA2g9nl95I=
    10.0.99.101 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+/QqfxW9mzDP19JyJ3F6I6N/IHnNEGsab7hUhAm56T
    10.0.99.222 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDlUGtctEL17d+pf6KWhU5uP0GOEFQzACZ+PfjFCqdFxUrhmRaXFsmqc0hIlNjBomYn1/P2+DJZCSyphbLhbcBIJnCbp22JJzDNBN/xTnGYly8pNZOE2Jb/CsaaYbULlQ3BMvKXhpZT+ovQbDpTbmX3l9JKYVFAWK9QO4s1/HX34O7g5ggNMJlWxgAGju23TCHZuS8SEKT3bXpP/qpZsDYB3ze2n4NhG/IpnePzOMAtqYBiK4XykqP1sifh08bKelXc5OrxVJRbx3Zl79rhxeiWZWugyz3BZQptT3KJedLUWNls0ab1aZbqSuR5ir8tEf2HxbP/kHx1ltSzTbAbZlDbebe3wGxVuVM8SobO2OOKmtXIdCwz0BSBJ6Q/oMoS8V27WIW9XmZSaA7FGmAfRgf6jHZE3w61kNfk2U+PhclfoBoGR+d+wYLv/QwLv7DYQTm4sAuXdhPl4A74kl6l3vSPcFvhrh/scRy5+nVDySXh9Znm9iFQddw5/4uDe489a60=
    10.0.99.222 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBI+SbwPPxHQlacirRWKuLnRkJlHnWlrVLG2EQJ1JH5WPkb881dF2rRw+9q9Fn7Td4fl+CbfMuBFuXEVeT7D4qcA=
    10.0.99.222 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMLcpAl8z5Pks0D/9zUsCQeYVH85/j4nGfmoKAjoKwwn
    10.0.99.150 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII5Drz7qUWuOkzBqRg2YcOtIQXm0ricNgjpfHXaH7pWi
    10.0.99.150 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC30NuXYLMM2cljda1QHzOsQXEfgGAOuApI/1y7PuqCreAPcKggocwR7kthe+DxG2jFxxi2x1mjW76dTUbJehWGqKTaf+8sjcTXRC+6RUMx9TST5ryJhkr9uwryFrDNDDOXwwEQ2Y+IFe7l3VEBnCvzijXr9IXGVUvCmVHcXV1w+bD4R2JiBHMKsXYTfNYwAL6wxjbnhBfOeo/++YZ0/vmg9pl7P+fU4QFzKORihsoZSImTBNaTV+HVp+8GJFgu/gi/Ldn4F4q6FkgeL0JXIF96ff1/IVQ5OD4lRylej+MKsQxp2yxxsbi/GbqRazcV9QAZ3ZO2J+ltY5mdyCMFR2MZTHFDGp9Mmy0BsAzfuq5zA4kpC4CqFcTrck0kdPBfsrS5bHyR7+6mz8XAPw+9/sAiwKjMazCcbc90SsqKWDG/hfD2jj/RdU2RPVN+EYajLpgpQNIdEtfyQTJfXMKU9yWilnQ0kQJH4hgTY6Xtth52OdWAu++vZOM9mVy5aDeOZrE=
    10.0.99.150 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBPFVOFA7G3cPXN3Y1K3VVLBButIeJPGA2VzvXYdcP2CVYtiq83wJ6ONIP9M95qFBT+eis1vf1zMS+/IzL+p+B8Q=
    10.0.99.30 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG7h71Z9+AG1QRxa9WXqCygEpbgf96jc2Pe1u7UiZbLu
    10.0.99.30 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC2/JPtJHU8yZGHlEr5Q5qfIvbgPI681WMmDIWKdLqkl+L61zbdjbx4z5zQ90feqldamuHMdmckVbEmr4FnBFeb25C/hU0s7T11MTQU6D3FknnQyeWPd656v3Oz/foWuTm/MnffAp/g/BaToDthZOBlFndmbU75iwX4ldTrsXcHLqTQ5lWdRHJuNv6qL7RPWAcSInwkTE8+v6HNIZU5ma91t5RWtJBx0DcVMoUUqDD4+CfnddZilgW1B3Cvj+tYnsV1msqUcJGcaY0CQ0w7rnCbS2R7rTq8h68va4YG5yRdKK6oHqEL4KiQz/cVs096clpVVT/UQAx5t/ZeJDZkI6uZFQ8uWkT9jdPbQcSWNHyOEpXXUllwl4LWWy3j7Gjy85ku1nBWxYjlvSQl3vG7XsgCON6kRKMgfpfIFwpp4JIuBLQ1JSq07vO9TuN/IOZOXTz/byVudGr+GDXQ2z+fY1ti355mk/jHVB5W4RNEfHPM5UC83kL/6Gp9UmURUs2QZaU=
    10.0.99.30 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFqA2cr7lCKgELtPjk+h5vXeVSv5zzOQYhle8T9l5iefxP+objpw3kq8StmlwchnkRI1Kes8jekQEKHwfOV3MHA=
  '';

  programs.ssh.matchBlocks."10.0.99.1" = {
    host = "10.0.99.1";
    extraOptions = {
      "HostKeyAlgorithms" = "ssh-rsa";
    };
  };

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
