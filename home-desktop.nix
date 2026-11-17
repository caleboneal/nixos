{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nautilus
    pavucontrol
    wl-clipboard
    xwayland-satellite
  ];

  programs.zen-browser.enable = true;
  programs.ghostty.enable = true;
  programs.firefox.enable = true;
  programs.fuzzel.enable = true;
  programs.swaylock.enable = true;
  services.mako.enable = true;
  services.polkit-gnome.enable = true;
  services.network-manager-applet.enable = true;
  xsession.preferStatusNotifierItems = true;

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      modules-left = [ "niri/workspaces" "niri/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "pulseaudio" "network" "tray" ];
      clock.format = "{:%a %b %d  %H:%M}";
      "niri/window".max-length = 60;
      pulseaudio = {
        format = "Volume {volume}%";
        format-muted = "Muted";
        on-click = "pavucontrol";
      };
      network = {
        format-ethernet = "{ifname}: {ipaddr}";
        format-wifi = "{essid} ({signalStrength}%)";
        format-disconnected = "Offline";
      };
    };
  };

  systemd.user.services.swaybg = {
    Unit = {
      Description = "Desktop wallpaper";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i ${./images/IMG_1799.png}";
      Restart = "on-failure";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };

  xdg.configFile."niri/config.kdl".source = ./config/niri.kdl;
}
