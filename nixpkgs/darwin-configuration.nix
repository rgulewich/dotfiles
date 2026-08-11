{ config, pkgs, openspec, ... }:

let
  # Literals rather than `builtins.getEnv`: darwin-rebuild evaluates this as
  # root, where $USER/$HOME resolve to root's, not yours.
  current_user = "rob";
  home_dir = "/Users/rob";

in
rec {
  imports = [
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
      pkgs.go_1_25
      pkgs.grpcurl
      pkgs.home-manager
      pkgs.inconsolata
      pkgs.imagemagick
      pkgs.jd-diff-patch
      pkgs.jrnl
      pkgs.jq
      pkgs.lorri
      pkgs.moreutils
      pkgs.nnn
      pkgs.nmap
      pkgs.neovim
      pkgs.nodejs
      pkgs.niv
      (pkgs.callPackage ./openspec.nix { src = openspec; })
      pkgs.python312
      pkgs.python312Packages.pip
      pkgs.python312Packages.pyyaml
      pkgs.reattach-to-user-namespace
      pkgs.ripgrep
      pkgs.rustc
      pkgs.terraform
      pkgs.tmux
      pkgs.vim
      pkgs.yq
    ];

  # Auto upgrade nix package and the daemon service.
  #services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.zsh.enable = true;

  # `darwin-rebuild switch` evaluates this flake as root, and libgit2 refuses
  # to read a repository owned by another user unless it is marked safe.
  # Without this, every rebuild fails with "repository path ... is not owned
  # by current user".
  environment.etc."gitconfig".text = ''
    [safe]
    	directory = ${home_dir}/src/me/dotfiles
  '';

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
  #system.stateVersion = 4;
  system.stateVersion = 6;

  system.primaryUser = "rob";

  # Disable documentation until https://github.com/LnL7/nix-darwin/issues/217 is fixed.
  documentation.enable = false;
}
