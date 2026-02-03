# Check for Arch Linux
if [ ! -f /etc/arch-release ]; then
    echo "❌ This script is designed for Arch Linux (uses yay/pacman)."
    exit 1
fi

# Install yay
if [ -f "./install_yay.sh" ]; then
    chmod +x ./install_yay.sh
    ./install_yay.sh
else
    echo "❌ Error: install_yay.sh not found!"
    exit 1
fi

# Install packages
PACKAGES=(
    cava 
    fastfetch 
    fzf 
    hyprland 
    kitty 
    kvantum 
    rofi 
    vesktop
    yazi
    swaync
    peaclock
    waybar
    qt5ct 
    qt6ct 
    quickshell-git 
    zoxide
    zsh
)

echo -e "${PINK}📦 Installing all packages via yay...${NC}"
yay -S --needed --noconfirm "${PACKAGES[@]}"