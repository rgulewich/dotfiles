{ pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile /Users/rob/src/me/dotfiles/vimrc;
    plugins = with pkgs.vimPlugins; [
      spacevim
      vim-colors-solarized
      vim-go
    ];
  };
}
