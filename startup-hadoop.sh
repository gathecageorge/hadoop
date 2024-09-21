#!/bin/bash
set -ex

# Start ssh server
sudo /usr/sbin/sshd

# Start hadoop and other services
start-all.sh

hive --service hiveserver2 --hiveconf hive.server2.thrift.port=10000 --hiveconf hive.root.logger=INFO,console

sleep infinity
