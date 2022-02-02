{ config, ... }:
{
  services.xserver.displayManager.sessionCommands =
    config.services.xserver.displayManager.setupCommands;
}
