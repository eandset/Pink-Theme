#!/bin/bash

PINK='\033[0;35m'
NC='\033[0m'

FORCE_INSTALL_WITHOUT_BACKUP=false
NEED_INSTALL_PACKAGES=true

usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -f    Install without backup (force)"
    echo "  -i    Not install packages (configs only)"
    echo "  -h    Show help"
    exit 0
}

# Parsing flags
while getopts "bih" opt; do
  case $opt in
    f)
      FORCE_INSTALL_WITHOUT_BACKUP=true
      ;;
    i)
      NEED_INSTALL_PACKAGES=false
      ;;
    h)
      usage
      ;;
    *)
      usage
      ;;
  esac
done

echo -e "${PINK}🚀 Starting Pink-Theme full installation...${NC}"

# 1. Install packages
if [[ $NEED_INSTALL_PACKAGES == "true" ]]; then
    if [ -f "./install-packages.sh" ]; then
        chmod +x ./install-packages.sh
        ./install-packages.sh
    else
        echo "❌  install-packages.sh not found"
        exit 1
    if
fi

# 2. Run backup
if [ -f "./backup.sh" ]; then
    chmod +x ./backup.sh
    ./backup.sh
else
    if [[ $FORCE_INSTALL_WITHOUT_BACKUP == "true" ]]; then
        echo "⚠️  backup.sh script not found, continuing without backup..."
    else
        echo "❌  backup not found. Use -f for install without backup (WARNING!)"
        exit 1
    fi
fi

# 3. Deploy configs to ~/.config
echo -e "${PINK}📂 Deploying new configs to ~/.config...${NC}"
CONFIG_DIRS=(
    "cava" "fastfetch" "hypr" "kitty" "Kvantum" 
    "qt5ct" "qt6ct" "quickshell" "rofi" "waybar" 
    "vesktop" "yazi" "swaync"
)

mkdir -p ~/.config

for dir in "${CONFIG_DIRS[@]}"; do
    if [ -d "config/$dir" ]; then
        rm -rf "$HOME/.config/$dir"
        cp -r "config/$dir" "$HOME/.config/"
        echo "✅ Config installed: $dir"
    fi
done

# 4. Special handling for peaclock (from root to ~/.peaclock)
if [ -d "peaclock" ]; then
    echo -e "${PINK}🕒 Setting up peaclock...${NC}"
    rm -rf "$HOME/.peaclock"
    cp -r "peaclock" "$HOME/.peaclock"
    echo "✅ Peaclock directory installed to ~/.peaclock"
fi

# 5. Setup ZSH parts
if [ -d "zsh" ]; then
    echo -e "${PINK}🎨 Setting up ZSH themes and scripts...${NC}"
    
    chmod +x ./OHZ-with-custom-install.sh
    ./OHZ-with-custom-install.sh
fi

echo -e "${PINK}✨ ALL DONE! Please restart your system or Hyprland session.${NC}"