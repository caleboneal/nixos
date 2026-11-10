{ config, lib, pkgs, ... }:

{
  # Enable flakes + new nix command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Automatic garbage collection so the store doesn't grow forever
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  time.timeZone = "America/New_York";

  # Allow unfree packages (needed for things like vscode, some drivers, etc.)
  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;
  services.tailscale.enable = true;

  # Basic system packages available to all users (keep this minimal;
  # prefer home.packages in home-manager for personal tools)
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    vim
  ];

  services.openssh.enable = true;

  # Keep user services (e.g. the rex server) running while logged out
  users.users.caleb.linger = true;
}
