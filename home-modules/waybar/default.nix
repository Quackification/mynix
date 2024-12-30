{ pkgs, ... }:
{
  programs.waybar = {
    package = (
      pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    );
    enable = true;
    settings.mainBar = {
      layer = "top";
      modules-left = [
        "custom/distro"
        "tray"
      ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [
        "clock"
        "pulseaudio"
        "power-profiles-daemon"
        "battery"
        "memory"
        "cpu"
        "temperature"
        "custom/sleep"
        "custom/reboot"
        "custom/shutdown"
      ];
      "custom/distro" = {
        format = "<span font='Awesome 6 Free Regular' size='medium'></span>";
        tooltip = false;
      };
      "hyprland/workspaces" = {
        disable-scroll = false;
        all-outputs = true;
        on-click = "activate";
        format = "<span font='Awesome 6 Free Regular'>{icon}</span>";
        format-icons = {
          default = "<span color='#f5e0dc'></span>";
          active = "<span color='#f5e0dc'></span>";
          urgent = "<span color='#f5e0dc'>󰗖</span>";
          empty = "<span color='#f5e0dc'></span>";
        };
        persistent-workspaces = {
          "1" = [ ];
          "2" = [ ];
          "3" = [ ];
          "4" = [ ];
          "5" = [ ];
        };
      };
      tray = {
        icon-size = 18;
        spacing = 5;
        tooltip = false;
      };
      clock = {
        format = "<span font='Awesome 6 Free Regular' size='large' rise='-500' color='#f5e0dc'> 󰥔</span>  {:%R}";
        format-alt = "<span font='Awesome 6 Free Regular' size='large' rise='-500' color='#f5e0dc'> 󰥔</span>  {:%A, %d. %b, %Y}";
        tooltip = false;
      };
      pulseaudio = {
        format = "<span font='Awesome 6 Free Regular' size='large' rise='-500' color='#f5e0dc'> </span>  {volume}%";
        tooltip = false;
      };
      "power-profiles-daemon" = {
      "format" = "{icon}";
      "tooltip-format" = "Power profile: {profile}\nDriver: {driver}";
      "tooltip" = true;
      "format-icons" = {
        "default" = "<span font='Awesome 6 Free Regular' size='large' color='#f5e0dc'></span>";
        "performance" = "<span font='Awesome 6 Free Regular' size='large' color='#f5e0dc'></span>";
        "balanced" = "<span font='Awesome 6 Free Regular' size='large' color='#f5e0dc'></span>";
        "power-saver" = "<span font='Awesome 6 Free Regular' size='large' color='#f5e0dc'></span>";
        };
      };
      "battery" = {
        "states" = {
            "warning" = 30;
            "critical" = 15;
        };
        "format" = "{icon} {capacity}%";
        "format-full" = "{icon} {capacity}%";
        "format-charging" = "  {capacity}%";
        "format-plugged" = "  {capacity}%";
        "format-alt" = "{icon}  {time}";
        "format-icons" = ["<span color='#f5e0dc'>  </span>"
          "<span color='#f5e0dc'>  </span>"
          "<span color='#f5e0dc'>  </span>"
          "<span color='#f5e0dc'>  </span>"
          "<span color='#f5e0dc'>  </span>"
          ];
      };	
      memory = {
        interval = 3;
        format = "<span font='Awesome 6 Free Regular' color='#f5e0dc'> </span>  <span rise='-200'>{}%</span>";
        tooltip = false;
      };
      cpu = {
        interval = 3;
        format = "<span font='Awesome 6 Free Regular' color='#f5e0dc'> </span>  <span rise='-200'>{usage}%</span>";
        tooltip = false;
      };
      "temperature" = {
        "critical-threshold" = 80;
        "format" = "<span color='#f5e0dc'> </span> {temperatureC}°C";
      };
      "custom/sleep" = {
        format = "<span font='Awesome 6 Free Regular' color='#f5e0dc'></span>";
        on-click = "systemctl sleep";
        tooltip = false;
      };
      "custom/reboot" = {
        format = "<span font='Awesome 6 Free Regular' color='#f5e0dc'></span>";
        on-click = "reboot";
        tooltip = false;
      };
      "custom/shutdown" = {
        format = "<span font='Awesome 6 Free Regular' color='#f5e0dc'>⏻</span>";
        on-click = "shutdown now";
        tooltip = false;
      };
    };
    style = builtins.readFile ./style.css;
  };
}
