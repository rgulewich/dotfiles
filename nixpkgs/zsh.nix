{ config, pkgs, ... }:
{
  home.file.".zshrc".source = "${config.home.homeDirectory}/src/me/dotfiles/zshrc";
  home.file.".profile.d/common".source = "${config.home.homeDirectory}/src/me/dotfiles/profile.d/common";
  home.file.".profile.d/git".source = "${config.home.homeDirectory}/src/me/dotfiles/profile.d/git";
  home.file.".profile.d/local".source = "${config.home.homeDirectory}/etc/profile.d/local";
}
