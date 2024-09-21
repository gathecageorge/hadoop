#!/bin/bash -i

# Get some variables
CURRENT_USER="$(whoami)"
SCRIPT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE}")")

# If you are using root user, you need to create a non root user, use below script to do that
# ./install-user.sh USERNAME_HERE

# Change to user home folder
cd /home/$CURRENT_USER

source $SCRIPT_DIR/install-ssh.sh $SCRIPT_DIR # Arguments passed <script-dir>
source $SCRIPT_DIR/install-hadoop.sh $CURRENT_USER $SCRIPT_DIR # Arguments passed <username> <script-dir>
source $SCRIPT_DIR/install-hive.sh $CURRENT_USER $SCRIPT_DIR # Arguments passed <username> <script-dir>
source $SCRIPT_DIR/install-anaconda.sh $CURRENT_USER $SCRIPT_DIR # Arguments passed <username> <script-dir>
source $SCRIPT_DIR/install-done.sh
