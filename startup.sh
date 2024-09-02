#!/bin/bash
set -ex

# Start ssh server
sudo /usr/sbin/sshd

# Start hadoop and other services
start-all.sh

sleep infinity
