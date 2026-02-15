#!/bin/bash

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string 'Always'

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# System Preferences > Keyboard >
defaults write NSGlobalDomain KeyRepeat -int 5

# System Preferences > Keyboard >
defaults write NSGlobalDomain InitialKeyRepeat -int 26

# System Preferences > Dock > Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool false

# System Preferences > Accessibility > Mouse & Trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad '{
    Clicking = 0;
    DragLock = 0;
    Dragging = 0;
    TrackpadCornerSecondaryClick = 0;
    TrackpadFiveFingerPinchGesture = 2;
    TrackpadFourFingerHorizSwipeGesture = 2;
    TrackpadFourFingerPinchGesture = 2;
    TrackpadFourFingerVertSwipeGesture = 2;
    TrackpadHandResting = 1;
    TrackpadHorizScroll = 1;
    TrackpadMomentumScroll = 1;
    TrackpadPinch = 1;
    TrackpadRightClick = 1;
    TrackpadRotate = 1;
    TrackpadScroll = 1;
    TrackpadThreeFingerDrag = 0;
    TrackpadThreeFingerHorizSwipeGesture = 2;
    TrackpadThreeFingerTapGesture = 0;
    TrackpadThreeFingerVertSwipeGesture = 2;
    TrackpadTwoFingerDoubleTapGesture = 0;
    TrackpadTwoFingerFromRightEdgeSwipeGesture = 3;
    USBMouseStopsTrackpad = 0;
    UserPreferences = 1;
    version = 5;
}'

# System Preferences > Accessibility > Display > Pointer > Pointer Size
defaults write com.apple.universalaccess mouseDriverCursorSize -int 2

# System Preferences > Accessibility > Display > Pointer > Pointer Fill Color
defaults write com.apple.universalaccess cursorFill '{
    alpha = 1;
    blue = 0;
    green = "0.1491314173";
    red = 1;
}'

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder > View > Show Path Bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Location to save screenshots
mkdir -p "${HOME}/Pictures/Screenshots"
defaults write com.apple.screencapture location -string '${HOME}/Pictures/Screenshots'

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Kill affected apps
for app in "Dock" "Finder"; do
  killall "${app}" > /dev/null 2>&1
done

# Done
echo "Done. Note that some of these changes require a logout/restart to take effect."
