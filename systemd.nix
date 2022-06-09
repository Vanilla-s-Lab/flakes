{ ... }:
{
  services.timesyncd.enable = true;
  services.timesyncd.servers = [
    "0.cn.pool.ntp.org"
    "1.cn.pool.ntp.org"
    "2.cn.pool.ntp.org"
    "3.cn.pool.ntp.org"
  ];
}
