{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "caleb";

  # Helix takes longer to open when it has to parse windows paths
  wsl.wslConf.interop.appendWindowsPath = false;

  system.stateVersion = "26.05";  # match your nixpkgs channel, set once, don't bump casually
}
