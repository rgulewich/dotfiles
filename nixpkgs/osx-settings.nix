{ config, pkgs, ... }:
{

  # see https://daiderd.com/nix-darwin/manual/index.html#sec-options
  system.defaults.dock.autohide = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;
  system.defaults.finder.AppleShowAllExtensions = true;

  system.defaults.trackpad.Clicking = true;
}
