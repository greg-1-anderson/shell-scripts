<?php

/**
 * Save a certain subset of MacOS default preference values. Write a script similar to
 * https://github.com/pawelgrzybek/dotfiles/blob/master/setup-macos.sh to restore settings.
 *
 * Usage:
 *
 *   php save-macos-preferences.php > restore-macos-preferences.sh
 *
 */

// Properties to save
$properties = [
    'NSGlobalDomain AppleShowScrollBars'                      => 'Always show scrollbars',
    'com.apple.LaunchServices LSQuarantine'                   => 'Disable the “Are you sure you want to open this application?” dialog',
    'NSGlobalDomain NSAutomaticCapitalizationEnabled'         => 'Disable automatic capitalization as it’s annoying when typing code',
    'NSGlobalDomain NSAutomaticDashSubstitutionEnabled'       => 'Disable smart dashes as they’re annoying when typing code',
    'NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled'     => 'Disable automatic period substitution as it’s annoying when typing code',
    'NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled'      => 'Disable smart quotes as they’re annoying when typing code',
    'NSGlobalDomain NSAutomaticSpellingCorrectionEnabled'     => 'Disable auto-correct',

    'NSGlobalDomain KeyRepeat'                                => 'System Preferences > Keyboard >',
    'NSGlobalDomain InitialKeyRepeat'                         => 'System Preferences > Keyboard >',

    'com.apple.dock tilesize'                                 => 'System Preferences > Dock > Size',
    'com.apple.dock magnification'                            => 'System Preferences > Dock > Magnification',
    'com.apple.dock autohide'                                 => 'System Preferences > Dock > Automatically hide and show the Dock',
    'com.apple.dock show-process-indicators'                  => 'System Preferences > Dock > Show indicators for open applications',

    'com.apple.driver.AppleBluetoothMultitouch.trackpad'      => 'System Preferences > Accessibility > Mouse & Trackpad',
    'com.google.Chrome AppleEnableSwipeNavigateWithScrolls'   => "Don't let mouse-scrolling-twiches get converted into forward/back in Chrome",

    // For some reason, these do not work, even with 'sudo'
    'com.apple.universalaccess mouseDriverCursorSize'         => 'System Preferences > Accessibility > Display > Pointer > Pointer Size',
    'com.apple.universalaccess cursorFill'                    => 'System Preferences > Accessibility > Display > Pointer > Pointer Fill Color',

    'NSGlobalDomain AppleShowAllExtensions'                   => 'Finder: show all filename extensions',
    'com.apple.finder ShowPathbar'                            => 'Finder > View > Show Path Bar',
    'com.apple.finder _FXSortFoldersFirst'                    => 'Keep folders on top when sorting by name',

    'com.apple.screencapture location'                        => 'Location to save screenshots',
    'org.m0k.transmission DownloadLocationConstant'           => 'Location to save downloads',
    'com.apple.Safari AutoOpenSafeDownloads'                  => 'Prevent Safari from opening ‘safe’ files automatically after downloading',

    'NSGlobalDomain WebKitDeveloperExtras'                    => 'Add a context menu item for showing the Web Inspector in web views',

    // Tahoe settings
    'com.apple.universalaccess reduceTransparency'            => 'Reduce system-wide transparency (Accessibility > Display)',
    'com.apple.universalaccess reduceMotion'                  => 'Reduce system motion/animations (Accessibility > Motion)',
    'com.apple.controlcenter "NSStatusItem Visible Item-0"'   => 'Force a solid background on the Menu Bar',
    'com.apple.MenuBar showMenuBarBackground'                 => '',
    'com.apple.SwiftUI.DisableSolarium'                      => 'Disable the Liquid Glass "Solarium" rendering engine globally',

];

$home = getenv('HOME');

// Print script prefix
print <<< __EOT__
#!/bin/bash

# Before running:
#
#   1. Open System Settings
#   2. Navigate to Privacy & Security > Full Disk Access
#   3. Find Terminal in the list and toggle the switch to On
#   4. Restart Terminal

__EOT__;

// Read current value of setting and write out a script to restore it
foreach ($properties as $property => $comment) {
    $values = [];
    exec("defaults read $property 2>/dev/null", $values, $status);
    if ($status == 0) {
        $type = "-string";
        $value = implode("\n", $values);
        if (is_numeric($value)) {
            $type = "-int";
            $value = (int)$value;
            if (($value === 0) || ($value === 1)) {
                $type = "-bool";
                $value = $value ? 'true' : 'false';
            }
        } else {
            $value = str_replace($home, '${HOME}', $value);
            if (strpos($value, "\n") !== false) {
                $value = "'$value'";
            }
            else {
                $value = "\"$value\"";
            }
        }
        if (!empty($comment)) {
            print "\n# $comment\n";
        }
        if (strpos($value, '${HOME}')) {
            print "mkdir -p $value\n";
        }
        print "defaults write $property $type $value\n";
    }
}

// Print script postscript
print <<< __EOT__

# Show the ~/Library folder
chflags nohidden ~/Library

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Kill affected apps
for app in "Dock" "Finder" "ControlCenter"; do
  killall "\${app}" > /dev/null 2>&1
done

# Done
echo "Done. Note that some of these changes require a logout/restart to take effect."

__EOT__;


