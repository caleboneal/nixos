{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "caleb";

  system.stateVersion = "26.05";  # match your nixpkgs channel, set once, don't bump casually
}
