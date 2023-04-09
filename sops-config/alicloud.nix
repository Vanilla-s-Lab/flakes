{ config, ... }:
{
  sops.secrets."alicloud/ALICLOUD_ACCESS_KEY".sopsFile = ../secrets/alicloud.yaml;
  sops.secrets."alicloud/ALICLOUD_SECRET_KEY".sopsFile = ../secrets/alicloud.yaml;

  sops.secrets."alicloud/ALICLOUD_ACCESS_KEY".owner = "vanilla";
  sops.secrets."alicloud/ALICLOUD_SECRET_KEY".owner = "vanilla";
}
