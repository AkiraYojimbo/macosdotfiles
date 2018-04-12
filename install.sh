# Adapted from https://github.com/mathiasbynens/dotfiles/blob/master/.macos

# Ask for the administrator password upfront
sudo -v

# Enable full keyboard access to all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set the Home directory as the default for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Show Finder status bar
defaults write com.apple.finder ShowStatusBar -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# Top left screen corner → Disable screen saver
defaults write com.apple.dock wvous-tl-corner -int 6
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner → Start screen saver
defaults write com.apple.dock wvous-tr-corner -int 5
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner → Mission Control
defaults write com.apple.dock wvous-bl-corner -int 2
defaults write com.apple.dock wvous-bl-modifier -int 0
# Bottom right screen corner → Desktop
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

# Safari
# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Show Safari’s Favorites bar by default
# NOT Working
defaults write com.apple.Safari ShowFavoritesBar -bool true

# Enable the Develop menu
defaults write com.apple.Safari IncludeDevelopMenu -bool true

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Terminal
# Use the Pro theme by default in Terminal.app
osascript <<EOD

tell application "Terminal"

	local allOpenedWindows
	local initialOpenedWindows
	local windowID
	set themeName to "Pro"

	(* Store the IDs of all the open terminal windows. *)
	set initialOpenedWindows to id of every window

	(* Set the Pro theme as the default terminal theme. *)
	set default settings to settings set themeName

	(* Get the IDs of all the currently opened terminal windows. *)
	set allOpenedWindows to id of every window

	repeat with windowID in allOpenedWindows

		(* Close the additional windows that were opened in order
		   to add the custom theme to the list of terminal themes. *)
		if initialOpenedWindows does not contain windowID then
			close (every window whose id is windowID)

		(* Change the theme for the initial opened terminal windows
		   to remove the need to close them in order for the custom
		   theme to be applied. *)
		else
			set current settings of tabs of (every window whose id is windowID) to settings set themeName
		end if

	end repeat

end tell

EOD

# Put Dock on the left
defaults write com.apple.dock 'orientation' -string "left"

# Restart the Dock for various changes to take effect
killall Dock

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install Homebrew packages
homebrew_packages=(
  git
  node
  wp-cli
)

echo "Installing Homebrew packages..."
brew install ${homebrew_packages[@]}

echo "Cleaning up Homebrew..."
brew cleanup

echo "Installing Homebrew Cask..."
brew install caskroom/cask/brew-cask

# Install Homebrew Cask apps
homebrew_apps=(
    alfred
    firefox
    google-chrome
    highsierramediakeyenabler
    imageoptim
    insomnia
    onedrive
    slack
    spotify
    virtualbox
    visual-studio-code
    zotero
)

echo "Installing Homebrew Cask apps..."
brew cask install ${homebrew_apps[@]}

echo "Install Mac App Store apps..."
brew install mas

mas signin tuckerm@me.com

mac_apps=(
    425424353 # The Unarchiver
    441258766 # Magnet
    467337615 # NaviCat Essentials for SQL Server
    1091189122 # Bear
    1006087419 # SnippetsLab
    1295203466 # Microsoft Remote Desktop
    407963104 # Pixelmator
    1026349850 # Copied
)

mas install ${mac_apps[@]}

# Install fonts

# brew tap caskroom/fonts
# fonts=(
#  font-roboto
# )

# echo "installing fonts..."
# brew cask install ${fonts[@]}


# TODO
# wp-cli needs to be finished set up
# does alfred work? if not, add this line "brew cask alfred link"
# Still need to install Cisco AnyConnect Secure Mobility Client, Logitech Options, Microsoft Office...