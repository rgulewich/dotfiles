{ config, pkgs, ... }:
{
  home.file.".zshrc".source = /Users/rob/src/me/dotfiles/zshrc;
  home.file.".profile.d".source = /Users/rob/src/me/dotfiles/profile.d;
}
