{ pkgs, ... }:
{
  users.users.root.shell = pkgs.fish;
  users.users.root.openssh.authorizedKeys.keyFiles =
    [ ../data/ecdsa-sha2-nistp256.pub ../data/ecdsa-sha2-nistp256.pub ];
}
