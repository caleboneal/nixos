{ config, pkgs, ... }:

{
  home.username = "caleb";
  home.homeDirectory = "/home/caleb";
  home.stateVersion = "26.05";  # match your nixpkgs release, don't change after first build

  # packages available in your shell
  home.packages = with pkgs; [
    github-cli
  ];

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
    bashrcExtra = ''
      eval "$(starship init bash)"
    '';
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.starship = {
    enable = true;
    configPath = "config/starship.toml";
  };

  programs.home-manager.enable = true;
}
