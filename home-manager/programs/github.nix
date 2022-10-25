{ lib, pkgs, inputs, config, nixosConfig, ... }:
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
    20.24.195.187 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINuOaPPJ8LWVountUt1QVerIfgYtMxWJ/wos6UEU0uVz
    20.24.195.187 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC85/Pzd3JzgX71stWBl6SGwdFt+O3Fgy6Zrpl3SpXid0rVb9fxsowITZWxLn0X48nhWo3+fPgn9NOj64uuGx2q47boiXBN301wQAoBdRJJrVllu//WZZ9eat7WUuc09NCWRTavm0XKXj+GPm5gfRSJxObOYc7uj1qJRnFZGPTwG3Ry/6bUxW6eI5f26ojSabRn+KiOh56J0kDk9yarPgXzNj/0mQQI3Sw6DwG3DNxwcT4Urp4uQQ2bm/9T+wnI3LgDFB9SocMMOrf6rzE7q/G9pZWjghGpvFdv2vVIl5Xj1kpAAIdwqfLANJFRlTsadLpo/lfAfnUp+9sTDWHWSdOKpAOqr64ZM/7t5sMHFm7fdABez/3mID1+bIJWbWmTZGTKKMezICtcgvYAuS6ExY8gkwgNFjI9ixcIqiF/QQSrfklDzUQPS6kZzdx8hNQa+gW67BzbciqWSgA5On+WHTd9Qe+0Jn7gd73LtAT/WvT2etL8AbMGlVcaOX0w6Vi/HKwJ5pyMOvAjQsDuzKfy327f8eI6OtH2A++tbaNySwS8ST1PuaTEGNopOQFdjenRmtBp7Xvap8Qadu4fNIRF6ikdcEIiI1ah5uNlgPXL3ELUHaI/HAuckz136OuiAU9YBaHvj+WPTbFyyIyO3rP1Q5kUh5PSibJQd/n1sRjmOdvOPQ==
    59.110.239.227 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPtqICDau0S0ytx6RaGd+FYdLoNuvAfYwnOCm1L6eU6V
    59.110.239.227 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBPyR+72FJ0luNqUIs7EBV2wlCjOHkwOEbe5FuGP3Y3mur49YvCUYDFzzdSbqSRYQfSEPY8z02ojsJnbJ0EY6EyI=
    211.137.105.139 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILAGThb0UHRQkTnjTu6C0BBo1yQ1+hx00R5RcUBP1jnk
    192.168.5.1 ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAB6gHsv2elRunMrxhgAdbTQ2AlU/VWhnUUAFiXrymlc64PM4X6X/2LD1xbvUOKHiWRUVDq0NCn8ta/zQuAhA2XtIgCEji5uK1kjwnr0+mItSJC1XQwetERS0lZ5tpPaGRvJt/14IONaUQkK8hvlrI8M7eAzZsOa5FCU0fCGQdMnb16B+Q==

    [221.131.165.89]:50022 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAu9X9+vyonTmcl8opkodSnrpd5J5LmqK7iX5GcVSO3i
    [221.131.165.89]:50022 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1G4Ne7clQbDvEm/yxMMI87EZNpEOkf4nyivh3T0UPdZiZnK7Rr5HUgZ+RoaUWvOAGwzTQdjpeePULchKJ3okvNcX53RuapP9x21hkfLBSkrNShJNIi7n+TRSCaMfKRWgJ8zceR7NNRLXFY6pnQ2O9YnUR7LL5zfnaqf3IksSI+SzjP6Gc5WIM0mac4dkX1eNjtvj7nbeH5/2hQgGE7d0jGzslbPrsaRKU5fZPidOWAIcdqyjw/8t8UqR3jgt4MdBtlshBcxBRgvLXuWmpfFt89rsVS/atUnFbZ340yO2pnt/a2hKrjbv0ucMnOONA4PTJ6Xn9X9IVi1FsMn6F6bgz1k5buehQ9gVr4jy1uc5q1185sBP/GpVnAuDSsEbXSiRpwqjR6dHJYM7TOVi+Z1TQ7NaQqWPyesjLKK/ABbYC1R/XVa6niavjGJrUQNnmS+5ycNLZnOwtiAmUldF0MHy/K3u+Y0TI6cD6yjc2/9xqEcVvBgwRZl1ax0xXUDjfYdAkKfNsvokn0GXtBaNxIPe8YLYCnLbC/WjVgW9kL26b9+aeRp7jhWu5395XPfYIfggbTnmju9K+Xdj2mh/iRhjmvG45tRsouuTR3n+h4PCi380KEMstneGgQSnEq8clUeuRoxmsSMrnxTVD03Ek/+TrU3obbU/W4tX4aoKrcOMfFQ==
    139.162.105.188 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAu9X9+vyonTmcl8opkodSnrpd5J5LmqK7iX5GcVSO3i
    139.162.105.188 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC1G4Ne7clQbDvEm/yxMMI87EZNpEOkf4nyivh3T0UPdZiZnK7Rr5HUgZ+RoaUWvOAGwzTQdjpeePULchKJ3okvNcX53RuapP9x21hkfLBSkrNShJNIi7n+TRSCaMfKRWgJ8zceR7NNRLXFY6pnQ2O9YnUR7LL5zfnaqf3IksSI+SzjP6Gc5WIM0mac4dkX1eNjtvj7nbeH5/2hQgGE7d0jGzslbPrsaRKU5fZPidOWAIcdqyjw/8t8UqR3jgt4MdBtlshBcxBRgvLXuWmpfFt89rsVS/atUnFbZ340yO2pnt/a2hKrjbv0ucMnOONA4PTJ6Xn9X9IVi1FsMn6F6bgz1k5buehQ9gVr4jy1uc5q1185sBP/GpVnAuDSsEbXSiRpwqjR6dHJYM7TOVi+Z1TQ7NaQqWPyesjLKK/ABbYC1R/XVa6niavjGJrUQNnmS+5ycNLZnOwtiAmUldF0MHy/K3u+Y0TI6cD6yjc2/9xqEcVvBgwRZl1ax0xXUDjfYdAkKfNsvokn0GXtBaNxIPe8YLYCnLbC/WjVgW9kL26b9+aeRp7jhWu5395XPfYIfggbTnmju9K+Xdj2mh/iRhjmvG45tRsouuTR3n+h4PCi380KEMstneGgQSnEq8clUeuRoxmsSMrnxTVD03Ek/+TrU3obbU/W4tX4aoKrcOMfFQ==
  '';

  # https://cms-sw.github.io/tutorial-proxy.html
  programs.ssh.matchBlocks."github.com" = {
    host = "github.com";
    user = "git";
    proxyCommand = "nc -x localhost:1089 %h %p";
  };

  programs.ssh.matchBlocks."139.162.105.188" = {
    host = "139.162.105.188"; # Via Clash.
    proxyCommand = "nc -x localhost:7890 %h %p";
  };

  programs.git.extraConfig = {
    init.defaultBranch = "master";
  };

  home.packages = [
    pkgs.difftastic
    pkgs.gh # GitHub CLI
  ];

  # https://difftastic.wilfred.me.uk/git.html
  programs.git.extraConfig."diff" = { tool = "difftastic"; };
  programs.git.extraConfig."difftool" = { prompt = false; };
  programs.git.extraConfig."difftool \"difftastic\"" = { cmd = "difft $LOCAL $REMOTE"; };

  programs.git.extraConfig."pager" = { difftool = true; };
  programs.git.extraConfig."alias" = { dft = "difftool"; };

  home.file.".config/nix/nix.conf".source =
    config.lib.file.mkOutOfStoreSymlink
      nixosConfig.sops.templates."nix.conf".path;
}
