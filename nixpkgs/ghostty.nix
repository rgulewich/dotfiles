{ config, pkgs, ... }:
{
  #
  # config reference:
  #   https://ghostty.org/docs/config/reference
  #
  home.file.".config/ghostty/config".source = "${config.home.homeDirectory}/src/me/dotfiles/config/ghostty/config";
}
