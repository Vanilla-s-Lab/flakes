{ ... }:
{
  # https://redis.io/docs/manual/admin/
  boot.kernel.sysctl = { "vm.overcommit_memory" = 1; };
  boot.kernelParams = [ "transparent_hugepage=never" ];
}
