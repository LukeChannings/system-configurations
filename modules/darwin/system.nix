{
  pkgs,
  lib,
  ...
}:
{
  config = lib.mkIf pkgs.stdenv.isDarwin {
    services.nix-daemon.enable = true;

    security.pam.enableSudoTouchIdAuth = true;
    system.defaults.LaunchServices.LSQuarantine = false;

    ## Activity Monitor
    system.defaults.ActivityMonitor.ShowCategory = 101;

    ## NS Global Domain
    system.defaults.NSGlobalDomain.AppleShowAllFiles = false;
    system.defaults.NSGlobalDomain.AppleEnableMouseSwipeNavigateWithScrolls = true;
    system.defaults.NSGlobalDomain.AppleEnableSwipeNavigateWithScrolls = true;
    system.defaults.NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;
    system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
    system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
    system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
    system.defaults.NSGlobalDomain.AppleShowScrollBars = "Automatic";
    system.defaults.NSGlobalDomain.AppleScrollerPagingBehavior = true;
    system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
    system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
    system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
    system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
    system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
    system.defaults.NSGlobalDomain.NSAutomaticWindowAnimationsEnabled = true;
    system.defaults.NSGlobalDomain.NSDisableAutomaticTermination = false;
    system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
    system.defaults.NSGlobalDomain.AppleWindowTabbingMode = "manual";
    system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
    system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
    system.defaults.NSGlobalDomain.NSTableViewDefaultSizeMode = 2;
    system.defaults.NSGlobalDomain.NSTextShowsControlCharacters = false;
    system.defaults.NSGlobalDomain.NSUseAnimatedFocusRing = true;
    system.defaults.NSGlobalDomain.NSScrollAnimationEnabled = true;
    system.defaults.NSGlobalDomain.NSWindowResizeTime = 0.20;
    system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true;
    system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
    system.defaults.NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;
    system.defaults.NSGlobalDomain."com.apple.keyboard.fnState" = false;
    system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    system.defaults.NSGlobalDomain."com.apple.sound.beep.feedback" = 1;
    system.defaults.NSGlobalDomain."com.apple.trackpad.enableSecondaryClick" = true;
    system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = true;
    system.defaults.NSGlobalDomain.AppleICUForce24HourTime = true;
    system.defaults.NSGlobalDomain._HIHideMenuBar = false;
    system.defaults.CustomSystemPreferences.NSGlobalDomain = {
      AppleSpacesSwitchOnActivate = false;
    };

    ## Menu Bar
    system.defaults.menuExtraClock.ShowDayOfMonth = true;
    system.defaults.menuExtraClock.ShowDayOfWeek = true;
    system.defaults.menuExtraClock.ShowDate = 0;

    ## Dock
    system.defaults.dock.autohide = false;
    system.defaults.dock.show-process-indicators = false;
    system.defaults.dock.static-only = true;
    system.defaults.dock.tilesize = 32;
    system.defaults.CustomUserPreferences."com.apple.dock" = { "mru-spaces" = false; };

    ## Finder
    system.defaults.finder.AppleShowAllFiles = false;
    system.defaults.finder.ShowStatusBar = false;
    system.defaults.finder.ShowPathbar = true;
    system.defaults.finder.FXDefaultSearchScope = "SCcf";
    system.defaults.finder.FXPreferredViewStyle = "clmv";
    system.defaults.finder.AppleShowAllExtensions = true;
    system.defaults.finder.CreateDesktop = false;
    system.defaults.finder.QuitMenuItem = false;
    system.defaults.finder._FXShowPosixPathInTitle = false;
    system.defaults.finder.FXEnableExtensionChangeWarning = false;

    ## Login Window
    system.defaults.loginwindow.SHOWFULLNAME = false;
    system.defaults.loginwindow.GuestEnabled = false;
    system.defaults.loginwindow.DisableConsoleAccess = true;

    ## Spaces
    system.defaults.spaces.spans-displays = false;

    ## Trackpad
    system.defaults.trackpad.Clicking = true;
    system.defaults.trackpad.Dragging = false;
    system.defaults.trackpad.TrackpadRightClick = true;
    system.defaults.trackpad.TrackpadThreeFingerDrag = true;
    system.defaults.trackpad.ActuationStrength = 1;

    ## TextEdit
    system.defaults.CustomUserPreferences."com.apple.TextEdit" = {
        "RichText" = false;
        "SmartQuotes" = false;
      };
  };
}
