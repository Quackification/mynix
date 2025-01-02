{pkgs, ...}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    plugins = [
        pkgs.hyprlandPlugins.hyprgrass
    ];
    settings = {
        "$mainMod" = "SUPER";
        monitor=",preferred,auto,auto";
        xwayland = { force_zero_scaling = true; };
        exec-once = [
            "kitty"
            "nm-applet"
            "fcitx5"
            "swww-daemon"
            "waybar"
            "librewolf"
            "bash ./start.sh"
            "systemctl --user start hyprpolkitagent"
        ];
        env = [
            "XCURSOR_SIZE,16"
            "HYPRCURSOR_SIZE,16"
        ];
        general = {
            gaps_in = 5;
            gaps_out = 20;

            border_size = 2;

            # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
            "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
            "col.inactive_border" = "rgba(595959aa)";

            # Set to true enable resizing windows by clicking and dragging on borders and gaps
            resize_on_border = false;

            # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
            allow_tearing = false;
        };
        decoration = {
            rounding = 10;

            # Change transparency of focused and unfocused windows
            active_opacity = "1.0";
            inactive_opacity = "1.0";

            shadow = {
                enabled = true;
                range = 4;
                render_power = 3;
                color = "rgba(1a1a1aee)";
            };

            # https://wiki.hyprland.org/Configuring/Variables/#blur
            blur = {
                enabled = true;
                size = 3;
                passes = 1;

                vibrancy = 0.1696;
            };
        };
        animations = {
            enabled = true;

            # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

            bezier = ["easeOutQuint,0.23,1,0.32,1"
                "easeInOutCubic,0.65,0.05,0.36,1"
                "linear,0,0,1,1"
                "almostLinear,0.5,0.5,0.75,1.0"
                "quick,0.15,0,0.1,1"
            ];

            animation = ["global, 1, 10, default"
                "border, 1, 5.39, easeOutQuint"
                "windows, 1, 4.79, easeOutQuint"
                "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
                "windowsOut, 1, 1.49, linear, popin 87%"
                "fadeIn, 1, 1.73, almostLinear"
                "fadeOut, 1, 1.46, almostLinear"
                "fade, 1, 3.03, quick"
                "layers, 1, 3.81, easeOutQuint"
                "layersIn, 1, 4, easeOutQuint, fade"
                "layersOut, 1, 1.5, linear, fade"
                "fadeLayersIn, 1, 1.79, almostLinear"
                "fadeLayersOut, 1, 1.39, almostLinear"
                "workspaces, 1, 1.94, almostLinear, fade"
                "workspacesIn, 1, 1.21, almostLinear, fade"
                "workspacesOut, 1, 1.94, almostLinear, fade"
            ];
        };
        master = {
            new_status = "master";
        };

        misc = {
            force_default_wallpaper = 0;
            disable_hyprland_logo = true;
        };

        input = {
            kb_layout = "us";
            follow_mouse = 1;
            sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
            accel_profile = "flat";
            touchpad = {
                natural_scroll = true;
                tap-to-click = true;
                scroll_factor = "0.4";
            };
        };
        bind = [
            # Screenshot
            ", PRINT, exec, hyprshot -m region"
            # Rofi keybind
            "$mainMod, S, exec, rofi -show drun -show-icons"
            # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
            "$mainMod, code:191, exec, kitty"
            "$mainMod, C, killactive"
            "$mainMod, M, exit"
            "$mainMod, E, exec, dolphin"
            "$mainMod, V, togglefloating"

            # Move focus with mainMod + arrow keys
            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"

            # Move windows with mainMod + SHIFT + arrow keys
            "$mainMod SHIFT, left, movewindow, l"
            "$mainMod SHIFT, right, movewindow, r"
            "$mainMod SHIFT, up, movewindow, u"
            "$mainMod SHIFT, down, movewindow, d"

            # Resize windows with mainMod + ALT + arrow keys
            "$mainMod ALT, right, resizeactive, 10 0"
            "$mainMod ALT, left, resizeactive, -10 0"
            "$mainMod ALT, up, resizeactive, 0 -10"
            "$mainMod ALT, down, resizeactive, 0 10"

            # Switch workspaces with mainMod + [0-9]
            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"

            # Move active window to a workspace with mainMod + SHIFT + [0-9]
            "$mainMod SHIFT, 1, movetoworkspace, 1"
            "$mainMod SHIFT, 2, movetoworkspace, 2"
            "$mainMod SHIFT, 3, movetoworkspace, 3"
            "$mainMod SHIFT, 4, movetoworkspace, 4"
            "$mainMod SHIFT, 5, movetoworkspace, 5"
            "$mainMod SHIFT, 6, movetoworkspace, 6"
            "$mainMod SHIFT, 7, movetoworkspace, 7"
            "$mainMod SHIFT, 8, movetoworkspace, 8"
            "$mainMod SHIFT, 9, movetoworkspace, 9"
            "$mainMod SHIFT, 0, movetoworkspace, 10"

            # Example special workspace (scratchpad)
            "$mainMod SHIFT, S, movetoworkspace, special:magic"

            # Scroll through existing workspaces with mainMod + scroll
            "$mainMod, mouse_down, workspace, e+1"
            "$mainMod, mouse_up, workspace, e-1"
        ];

        bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
        ];

        bindel = [
            ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            ",XF86MonBrightnessUp, exec, brightnessctl s 5%+"
            ",XF86MonBrightnessDown, exec, brightnessctl s 5%-"
        ];

        bindl = [
            ", XF86AudioNext, exec, playerctl next"
            ", XF86AudioPause, exec, playerctl play-pause"
            ", XF86AudioPlay, exec, playerctl play-pause"
            ", XF86AudioPrev, exec, playerctl previous"
        ];
        windowrulev2 = [
            "suppressevent maximize, class:.*"
            "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
            "opacity 0.8, class:kitty"
            "opacity 0.8, title:btop"
        ];

        plugin = {
            touch_gestures = {
                sensitivity = 5.0;
                edge_margin = 20;
                hyprgrass-bind = [
                    ", edge:r:l, workspace, +1"
                    ", edge:l:r, workspace, -1"
                    ", edge:u:d, exec, rofi -show drun -show-icons"
                    ", swipe:3:u, exec, rofi -show drun -show-icons"
                    ", swipe:3:d, killactive"
                    ", edge:d:u, exec, kill $(pgrep wvkbd-mobintl) || wvkbd-mobintl"
                ];
            };
        };
    };
  };
}
