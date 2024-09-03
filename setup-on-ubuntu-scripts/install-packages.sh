# Install packages (Clean up if needed)
if [ "$CLEAN_UP" = "yes" ]; then
    echo "Installing packages and clean cache: $TO_INSTALL"
    sudo apt update
    sudo apt install -y $TO_INSTALL
    sudo apt autoremove -y
    sudo rm -rf /var/lib/apt/lists/*
else
    echo "Just installing packages without clean cache: $TO_INSTALL"
    sudo apt install -y $TO_INSTALL
fi
