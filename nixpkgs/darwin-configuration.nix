{ config, pkgs, ... }:

let
  current_user = builtins.getEnv "USER";
  home_dir = builtins.getEnv "HOME";

in
rec {
  imports = [
    <home-manager/nix-darwin>
    ./osx-settings.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = false;
  nixpkgs.config.allowUnsupportedSystem = false;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      #pkgs.alacritty
      pkgs.autojump
      pkgs.broot
      pkgs.cargo
      pkgs.direnv
      pkgs.fira-code
      pkgs.fzf
      pkgs.go_1_21
      pkgs.home-manager
      pkgs.inconsolata
      pkgs.imagemagick7
      pkgs.jd-diff-patch
      pkgs.jrnl
      pkgs.jq
      pkgs.lorri
      pkgs.moreutils
      pkgs.nnn
      pkgs.nmap
      pkgs.neovim
      pkgs.nodejs-18_x
      pkgs.niv
      pkgs.python312
      pkgs.python312Packages.pip
      pkgs.reattach-to-user-namespace
      pkgs.ripgrep
      pkgs.rustc
      pkgs.skhd
      pkgs.tmux
      pkgs.vim
      pkgs.yq
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.zsh.enable = true;

  # Let Home Manager install and manage itself.
  #programs.home-manager.enable = true;
  #programs.tmux.enable = true;

  users.users."${current_user}" = {
    name = "rob";
    home = "${home_dir}";
  };

  home-manager.users."${current_user}" = import ./home.nix;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # Disable documentation until https://github.com/LnL7/nix-darwin/issues/217 is fixed.
  documentation.enable = false;
}
