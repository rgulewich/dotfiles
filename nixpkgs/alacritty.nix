{ config, pkgs, ... }:
{
  #
  # config reference:
  #   https://github.com/alacritty/alacritty/blob/master/alacritty.yml
  #
  home.file.".config/alacritty/alacritty.yml".source = "${config.home.homeDirectory}/src/me/dotfiles/config/alacritty/alacritty.yml";
}
