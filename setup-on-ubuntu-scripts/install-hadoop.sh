# Set variables
ARG_CURRENT_USER=$1
ARG_SCRIPT_DIR=$2
CLEAN_UP="${3:-no}"

TO_INSTALL="openjdk-8-jdk openjdk-8-jre"
source $ARG_SCRIPT_DIR/install-packages.sh $CLEAN_UP

# Get hadoop and cleanup
wget https://www.dropbox.com/s/subianzkgumcpel/hadoop-3.2.0.tar.gz
tar xfvz hadoop-3.2.0.tar.gz
mv hadoop-3.2.0 hadoop
rm hadoop-3.2.0.tar.gz

# Setup bashrc: Use >> so to append instead of replace like others
if grep -q "#HADOOP VARIABLES START" .bashrc; then
    echo "The file .bashrc is already okay"
else
    echo "Updating .bashrc file for hadoop"

    cp .bashrc .backrc.bak.hadoop
    cat $ARG_SCRIPT_DIR/hadoop-config/bashrc >> .bashrc
    sed -i "s/CURRENT_USER_TO_BE_REPLACED/$ARG_CURRENT_USER/g" .bashrc
fi

# setup hadoop
cat $ARG_SCRIPT_DIR/hadoop-config/core-site.xml > hadoop/etc/hadoop/core-site.xml
cat $ARG_SCRIPT_DIR/hadoop-config/hadoop-env.sh > hadoop/etc/hadoop/hadoop-env.sh
cat $ARG_SCRIPT_DIR/hadoop-config/hdfs-site.xml > hadoop/etc/hadoop/hdfs-site.xml
cat $ARG_SCRIPT_DIR/hadoop-config/mapred-site.xml > hadoop/etc/hadoop/mapred-site.xml
cat $ARG_SCRIPT_DIR/hadoop-config/yarn-site.xml > hadoop/etc/hadoop/yarn-site.xml
sed -i "s/CURRENT_USER_TO_BE_REPLACED/$ARG_CURRENT_USER/g" hadoop/etc/hadoop/hdfs-site.xml

# source bashrc
source .bashrc

