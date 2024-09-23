#!/bin/bash
set -ex

INITIALIZED_FILE="/home/hadoop/hadoop_store/.initialized"
if [ -f "$INITIALIZED_FILE" ]; then
    echo "Already initialized"

    # Start ssh server
    sudo service ssh start

    # Start hadoop and other services
    start-all.sh
else
    source /usr/local/bin/install-initialize.sh
    echo "Initialized" >> $INITIALIZED_FILE
fi

hive --service hiveserver2 --hiveconf hive.server2.thrift.port=10000 --hiveconf hive.root.logger=INFO,console

sleep infinity
