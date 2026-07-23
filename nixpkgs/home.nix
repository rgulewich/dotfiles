{ config, pkgs, ... }:

let
  home_dir = builtins.getEnv "HOME";
  local_imports = if builtins.pathExists("${home_dir}/etc/local.nix") then ["${home_dir}/etc/local.nix"] else [];

in
rec {
  imports = [
    ./alacritty.nix
    ./ghostty.nix
    ./tmux.nix
    ./vim.nix
    ./zsh.nix
  ] ++ local_imports;

  # Other dotfiles
  # Leader Key config (replaces skhd's leader mode). Installed via `brew install leader-key`.
  home.file."Library/Application Support/Leader Key/config.json".source =
    "${config.home.homeDirectory}/src/me/dotfiles/config/leader-key/config.json";

  home.stateVersion = "22.05";
}
