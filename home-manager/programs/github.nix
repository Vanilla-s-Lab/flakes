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
    20.24.195.187 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINuOaPPJ8LWVountUt1QVerIfgYtMxWJ/wos6UEU0uVz
    20.24.195.187 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC85/Pzd3JzgX71stWBl6SGwdFt+O3Fgy6Zrpl3SpXid0rVb9fxsowITZWxLn0X48nhWo3+fPgn9NOj64uuGx2q47boiXBN301wQAoBdRJJrVllu//WZZ9eat7WUuc09NCWRTavm0XKXj+GPm5gfRSJxObOYc7uj1qJRnFZGPTwG3Ry/6bUxW6eI5f26ojSabRn+KiOh56J0kDk9yarPgXzNj/0mQQI3Sw6DwG3DNxwcT4Urp4uQQ2bm/9T+wnI3LgDFB9SocMMOrf6rzE7q/G9pZWjghGpvFdv2vVIl5Xj1kpAAIdwqfLANJFRlTsadLpo/lfAfnUp+9sTDWHWSdOKpAOqr64ZM/7t5sMHFm7fdABez/3mID1+bIJWbWmTZGTKKMezICtcgvYAuS6ExY8gkwgNFjI9ixcIqiF/QQSrfklDzUQPS6kZzdx8hNQa+gW67BzbciqWSgA5On+WHTd9Qe+0Jn7gd73LtAT/WvT2etL8AbMGlVcaOX0w6Vi/HKwJ5pyMOvAjQsDuzKfy327f8eI6OtH2A++tbaNySwS8ST1PuaTEGNopOQFdjenRmtBp7Xvap8Qadu4fNIRF6ikdcEIiI1ah5uNlgPXL3ELUHaI/HAuckz136OuiAU9YBaHvj+WPTbFyyIyO3rP1Q5kUh5PSibJQd/n1sRjmOdvOPQ==
    59.110.239.227 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPtqICDau0S0ytx6RaGd+FYdLoNuvAfYwnOCm1L6eU6V
    59.110.239.227 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBPyR+72FJ0luNqUIs7EBV2wlCjOHkwOEbe5FuGP3Y3mur49YvCUYDFzzdSbqSRYQfSEPY8z02ojsJnbJ0EY6EyI=
    127.0.0.1 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDH2j9R8CdF/hCzRFGrCY3hXLQ1L/7BWCByAdnLgqLVeaYA5934p45y2rLRg+dQH/tNhZR7esfJsg7n/7v35NCWB//nZBf7jZBIvEH5qBH2pzOsHbNkD4NLGu8xLDPUiDZrafuXUHRrxRMG7kHPT31Qi9X7gzyw4w97WafMRTSxTfupP+Xw/19hlzBXi0Hj3YSUskToIJmQ3wwFFw8iLK8YwZachlwZuqq2vIynN3JBr3URWs+SZvfh3eCxpSTeGItCz1j9ZOH2t9XZ24MGqkZFY/N2OfhvTktnEni2YEiZp7/C4HO9ZAGC8UneWhuQfDjALcvVlhpzhhZqGv3I7KxINyndi4ZHNVGNgU2qghuYRjQdbdS5OA9c5VnRXqr08UBlqal6uqBfh2l/9QHPaCzi/gFrb8No8JSsvojJxiUa6F4EXbHV624o69Q/b1onXWrLhQaMRATygPL3er4SBv5RAiYXO7vnCFcOMo9ZSEsx9OfXJK+ysEH73IlNURWzMFTzLt8dy/xfIdLJw25C7f2Q59tKgGVU+CPFqlMi/ev5k/EJ36MKoOTwsHgYRdGqnIUGDgTcW4MSDeHpAzrPDuaZL7hwFLgh6ZRAMNIO5TOpqDO7ne6zqGUxvPs1qNFfSqTrc7fW/bS0TbfXJpgXOE5l7ABd+/Ez996I+h4CRSxf3w==
    127.0.0.1 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIzKaLzzMh2MvYRcDSvkyB7YXGNIP3IlBUda9ODxd2PX
    211.137.105.139 ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILAGThb0UHRQkTnjTu6C0BBo1yQ1+hx00R5RcUBP1jnk
  '';

  # https://cms-sw.github.io/tutorial-proxy.html
  programs.ssh.matchBlocks."github.com" = {
    host = "github.com";
    user = "git";
    proxyCommand = "nc -x localhost:1089 %h %p";
  };

  programs.git.extraConfig = {
    init.defaultBranch = "master";
  };

  home.packages = [ pkgs.difftastic ];

  # https://difftastic.wilfred.me.uk/git.html
  programs.git.extraConfig."diff" = { tool = "difftastic"; };
  programs.git.extraConfig."difftool" = { prompt = false; };
  programs.git.extraConfig."difftool \"difftastic\"" = { cmd = "difft $LOCAL $REMOTE"; };

  programs.git.extraConfig."pager" = { difftool = true; };
  programs.git.extraConfig."alias" = { dft = "difftool"; };
}
