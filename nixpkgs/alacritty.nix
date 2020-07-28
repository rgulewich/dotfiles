{ config, pkgs, ... }:
{
  #
  # config reference:
  #   https://github.com/alacritty/alacritty/blob/master/alacritty.yml
  #

  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "xterm-256color";
      };

      mouse = {
        hide_when_typeing = true;
      };

      window = {
        dimensions = {
          columns = 188;
          lines = 58;
        };
      };

      colors = {
        primary = {
          background = "0x1d1f21";
          foreground = "0xc5c8c6";
        };
        cursor = {
          text = "0x000000";
          cursor = "0xc5c8c6";
        };
        normal = {
          black = "0x282a2e";
          red = "0xa54242";
          green = "0x6b9440";
          yellow = "0xde935f";
          blue = "0x5f819d";
          magenta = "0x85678f";
          cyan = "0x5e8d87";
          white = "0x707880";
        };
        bright = {
          black = "0x373b41";
          red = "0xcc6666";
          green = "0x9cbd68";
          yellow = "0xf0c674";
          blue = "0x81a2be";
          magenta = "0xb294bb";
          cyan = "0x8abeb7";
          white = "0xc5c8c6";
        };
      };

      font = {
        normal = {
          family = "FiraCode Nerd Font";
        };
        bold = {
          family = "FiraCode Nerd Font";
        };
        italic = {
          family = "FiraCode Nerd Font";
        };
        size = 16;
      };
    };
  };
}
