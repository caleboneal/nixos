{ config, pkgs, ... }:

{
  home.username = "caleb";
  home.homeDirectory = "/home/caleb";
  home.stateVersion = "26.05";  # match your nixpkgs release, don't change after first build


  # packages available in your shell
  home.packages = with pkgs; [
    cursor-cli
    github-cli
    zls
  ];

  programs.helix = {
    enable = true;
  };
  xdg.configFile."helix/config.toml".source = ./config/helix.toml;

  programs.rex.enable = true;
  services.rex.enable = true;

  # Needed for rex's SSH TERM fallback in ~/.ssh/config
  programs.ssh.enable = true;

  programs.git = {
    enable = true;
    settings.user = {
      name = "Caleb O'Neal";
      email = "caleboneal07@gmail.com";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellOptions = ["dotglob"];
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.starship = {
    enable = true;
  };
  xdg.configFile."starship.toml".source = ./config/starship.toml;

  programs.home-manager.enable = true;
}
