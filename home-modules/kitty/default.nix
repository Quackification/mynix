{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      window_padding_width = 10;
      bold_font = "JetBrainsMono Nerd Font Mono Extra Bold";
      bold_italic_font = "JetBrainsMono Nerd Font Mono Extra Bold Italic";
      font_family = "JetBrainsMono Nerd Font Mono";
      font_size = 8.0;
    };
  };
}
