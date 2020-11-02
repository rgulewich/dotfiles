{ config, pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.file.".vimrc".source = "${config.home.homeDirectory}/src/me/dotfiles/vimrc";

  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile "${config.home.homeDirectory}/src/me/dotfiles/vimrc";
    plugins = with pkgs.vimPlugins; [
      spacevim
      vim-colors-solarized
      vim-go
    ];
  };
}
