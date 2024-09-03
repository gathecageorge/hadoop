CHECK_CURRENT_USER=$(whoami)
if [ "$CHECK_CURRENT_USER" != "root" ]; then
  echo "Only root can execute this script"
  exit 1
fi

# Expects argument with the username ie ./install-user.sh myusername
if [ $# -ne 1 ] && [ $# -ne 2 ]; then
  echo "Usage: $0 <username> <clean-up: default no>"
  exit 1
fi

USERNAME="$1"
CLEAN_UP="${2:-no}"

apt update
apt install -y sudo
groupadd --gid 1000 $USERNAME 
useradd --uid 1000 --gid 1000 -m $USERNAME 
echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME 
chmod 0440 /etc/sudoers.d/$USERNAME
echo "USER $USERNAME created successfully"

# Clean up for dockerfile
if [ "$CLEAN_UP" = "yes" ]; then
  apt autoremove -y
  rm -rf /var/lib/apt/lists/*
fi
