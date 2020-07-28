{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./tmux.nix
    ./vim.nix
    ./zsh.nix
  ];
}
