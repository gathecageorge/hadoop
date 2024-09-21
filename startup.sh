#!/bin/bash
set -ex

# Start ssh server
sudo /usr/sbin/sshd

# Start hadoop and other services
start-all.sh

# Start jupyter
jupyter notebook --notebook-dir=/home/hadoop/notebooks --ip='*' --port=8888 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''

sleep infinity
