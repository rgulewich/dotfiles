{ pkgs, ... }:

let
  home_dir = builtins.getEnv "HOME";
  local_imports = if builtins.pathExists("${home_dir}/etc/local.nix") then ["${home_dir}/etc/local.nix"] else [];

in
rec {
  imports = [
    ./alacritty.nix
    ./tmux.nix
    ./vim.nix
    ./zsh.nix
  ] ++ local_imports;

  home.stateVersion = "22.05";
}
