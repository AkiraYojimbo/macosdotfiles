# Ask for the administrator password upfront
sudo -v

# Enable full keyboard access to all controls
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3



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
# Still need to install Cisco AnyConnect Secure Mobility Client, Logitech Options, Microsoft Office,
