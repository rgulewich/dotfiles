{ config, pkgs, ... }:
{
  home.file.".zshrc".source = "${config.home.homeDirectory}/src/me/dotfiles/zshrc";
  home.file.".profile.d".source = "${config.home.homeDirectory}/src/me/dotfiles/profile.d";
}
