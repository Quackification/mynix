{
    services.dunst = {
        enable = true;
        settings = {
            global = {
                frame_color = "#6f7fa5";
                separator_color = "frame";
                highlight = "#6f7fa5";
                corner_radius = 5;
            };
            urgency_low = {
                background = "#2d303b";
                foreground = "#dfe6ff";
            };
            urgency_normal = {
                background = "#2d303b";
                foreground = "#dfe6ff";
            };
            urgency_critical = {
                background = "#2d303b";
                foreground = "#dfe6ff";
                frame_color = "#fa8794";
            };
        };
    };
}
