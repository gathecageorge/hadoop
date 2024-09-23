ARG_CURRENT_USER=$1

# Start SSH
sudo service ssh start

# Create hadoop data dir and format folder for hdfs
sudo mkdir -p hadoop_store/hdfs
sudo chown -R $ARG_CURRENT_USER:$ARG_CURRENT_USER hadoop_store/
hdfs namenode -format

# Create hive dir in dfs
hadoop/sbin/start-all.sh
hadoop/bin/hdfs dfs -mkdir /tmp
hadoop/bin/hdfs dfs -chmod g+w /tmp
hadoop/bin/hdfs dfs -mkdir -p /home/$ARG_CURRENT_USER/hive/warehouse 
hadoop/bin/hdfs dfs -chmod g+w /home/$ARG_CURRENT_USER/hive/warehouse

# Init hive DB
hive/bin/schematool -initSchema -dbType derby

echo "Done initializing hadoop and hive"
