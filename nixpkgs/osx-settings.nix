{ config, pkgs, ... }:
let
  current_user = builtins.getEnv "USER";
  home_dir = builtins.getEnv "HOME";

in
{

  system.defaults.".GlobalPreferences" = {
    "com.apple.mouse.scaling" = 3.0;
  };
  system.defaults.trackpad.Clicking = true;

  system.defaults.NSGlobalDomain = {
    # Make a sound when system volume changes
    "com.apple.sound.beep.feedback" = 1;
    # Mute alert noises
    "com.apple.sound.beep.volume" = 0.1;
    # Scroll the direction god intended
    "com.apple.swipescrolldirection" = false;
  };

  # see https://daiderd.com/nix-darwin/manual/index.html#sec-options
  system.defaults.dock.autohide = true;
  system.defaults.finder = {
    FXEnableExtensionChangeWarning = false;
    AppleShowAllExtensions = true;
    # Show list view by default
    FXPreferredViewStyle = "Nlsv";
    ShowStatusBar = true;
  };


  system.defaults.CustomUserPreferences = {
    "com.apple.finder" = {
      # Set default finder window to home folder
      NewWindowTarget = "PfLo";
      NewWindowTargetPath = "file://${home_dir}";
    };

    NSGlobalDomain = {
      # https://tisgoud.nl/2020/10/silence-is-foo/
      # Disable interface sounds
      "com.apple.sound.uiaudio".enabled = false;
      # Disable press-and-hold for keys in favor of key repeat.
      ApplePressAndHoldEnabled = true;
    };
  };

  # https://medium.com/@zmre/nix-darwin-quick-tip-activate-your-preferences-f69942a93236
  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
