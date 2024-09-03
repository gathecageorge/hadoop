# SSH setup
ARG_SCRIPT_DIR=$1
CLEAN_UP="${2:-no}"

TO_INSTALL="ssh openssh-server"
source $ARG_SCRIPT_DIR/install-packages.sh $CLEAN_UP

mkdir -p .ssh
ssh-keygen -q -t ed25519 -N '' -f .ssh/id_ed25519
cat .ssh/id_ed25519.pub > .ssh/authorized_keys
