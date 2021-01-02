{ config, pkgs, ... }:
{
  xdg.configFile."tmux/tmux.conf".source = "${config.home.homeDirectory}/src/me/dotfiles/tmux.conf";
}
