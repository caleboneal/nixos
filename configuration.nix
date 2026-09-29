{ config, lib, pkgs, ... }:

{
  imports = [
    # NixOS-WSL module is already imported in flake.nix,
    # so nothing needed here for that
  ];

  wsl.enable = true;
  wsl.defaultUser = "caleb";

  # Enable flakes + new nix command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Automatic garbage collection so the store doesn't grow forever
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Allow unfree packages (needed for things like vscode, some drivers, etc.)
  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;

  # Basic system packages available to all users (keep this minimal;
  # prefer home.packages in home-manager for personal tools)
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    vim
  ];

  # If you want Docker/Podman instead of Docker Desktop on Windows:
  # virtualisation.docker.enable = true;

  services.openssh.enable = true;

  system.stateVersion = "26.05";  # match your nixpkgs channel, set once, don't bump casually
}
