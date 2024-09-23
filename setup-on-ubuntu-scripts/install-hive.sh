# Set variables
ARG_CURRENT_USER=$1
ARG_SCRIPT_DIR=$2

wget https://downloads.apache.org/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz
tar xfvz apache-hive-3.1.3-bin.tar.gz
mv apache-hive-3.1.3-bin hive
rm apache-hive-3.1.3-bin.tar.gz

# Update bashrc
if grep -q "# HIVE_SETTINGS_HERE" .bashrc; then
    echo "The file .bashrc is already okay for hive"
else
    echo "Updating .bashrc file for hive"

    cp .bashrc .backrc.bak.hive
    cat $ARG_SCRIPT_DIR/hive-config/bashrc >> .bashrc
    sed -i "s/CURRENT_USER_TO_BE_REPLACED/$ARG_CURRENT_USER/g" .bashrc
fi

# Update hive-config.sh
if grep -q "# HIVE_SETTINGS_HERE" hive/bin/hive-config.sh; then
    echo "The file hive/bin/hive-config.sh is already okay for hive"
else
    echo "Updating hive/bin/hive-config.sh file for hive"

    cp hive/bin/hive-config.sh hive/bin/hive-config.sh.bak.hive
    cat $ARG_SCRIPT_DIR/hive-config/hive-config.sh >> hive/bin/hive-config.sh
    sed -i "s/CURRENT_USER_TO_BE_REPLACED/$ARG_CURRENT_USER/g" hive/bin/hive-config.sh
fi

# Put hive config
cat $ARG_SCRIPT_DIR/hive-config/hive-site.xml > hive/conf/hive-site.xml

# source .bashrc
source .bashrc
