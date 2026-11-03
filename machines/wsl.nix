{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "caleb";

  # If you want Docker/Podman instead of Docker Desktop on Windows:
  # virtualisation.docker.enable = true;

  system.stateVersion = "26.05";  # match your nixpkgs channel, set once, don't bump casually
}
