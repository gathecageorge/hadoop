#!/bin/bash -i

# Make sure to cd to user home dir
CURRENT_USER="$(whoami)"
WORK_DIR=$(dirname "$(readlink -f "${BASH_SOURCE}")")

cd /home/$CURRENT_USER

# Install tools
sudo apt install -y openjdk-8-jdk openjdk-8-jre ssh openssh-server

# SSH setup
mkdir -p .ssh
ssh-keygen -q -t rsa -N '' -f .ssh/id_rsa
cat .ssh/id_rsa.pub > .ssh/authorized_keys

# Get hadoop and cleanup
wget https://www.dropbox.com/s/subianzkgumcpel/hadoop-3.2.0.tar.gz
tar xfvz hadoop-3.2.0.tar.gz
mv hadoop-3.2.0 hadoop
rm hadoop-3.2.0.tar.gz

# Setup bashrc: Use >> so to append instead of replace like others
if grep -q "#HADOOP VARIABLES START" .bashrc; then
    echo "The file .bashrc is already okay"
else
    echo "Updating .bashrc file"

    cp .bashrc .backrc.bak
    cat $WORK_DIR/config/bashrc >> .bashrc
    sed -i "s/CURRENT_USER_TO_BE_REPLACED/$CURRENT_USER/g" .bashrc
fi
source .bashrc


# setup hadoop
cat $WORK_DIR/config/core-site.xml > hadoop/etc/hadoop/core-site.xml
cat $WORK_DIR/config/hadoop-env.sh > hadoop/etc/hadoop/hadoop-env.sh
cat $WORK_DIR/config/hdfs-site.xml > hadoop/etc/hadoop/hdfs-site.xml
cat $WORK_DIR/config/mapred-site.xml > hadoop/etc/hadoop/mapred-site.xml
cat $WORK_DIR/config/yarn-site.xml > hadoop/etc/hadoop/yarn-site.xml
sed -i "s/CURRENT_USER_TO_BE_REPLACED/$CURRENT_USER/g" hadoop/etc/hadoop/hdfs-site.xml

# Create data dir and format folder for hdfs
mkdir -p hadoop_store/hdfs
hdfs namenode -format

echo
echo "*********************************************************************"
echo "Done setting up hadoop, now you need to close the terminal and open another one to get new changes from.bashrc"
echo "Another option is to run the following command"
echo
echo "source ~/.bashrc"
echo
echo "After running command above or on a new terminal you can start hadoop by running command below"
echo
echo "start-all.sh"
echo
echo "To check all services started successfully run command below"
echo
echo "jps"
