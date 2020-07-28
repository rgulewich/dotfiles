{ config, pkgs, ... }:
{
  xdg.configFile."tmux/tmux.conf".source = /Users/rob/src/me/dotfiles/tmux.conf;
}
