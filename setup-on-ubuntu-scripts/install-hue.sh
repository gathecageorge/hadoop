# Set variables
ARG_CURRENT_USER=$1
ARG_SCRIPT_DIR=$2
CLEAN_UP="${3:-no}"

TO_INSTALL="build-essential python2.7-dev libsqlite3-dev software-properties-common"
source $ARG_SCRIPT_DIR/install-packages.sh $CLEAN_UP

# Install python3.8
sudo add-apt-repository ppa:deadsnakes/ppa
DEBIAN_FRONTEND=noninteractive sudo apt install -yq python3.8 git ant gcc g++ libffi-dev libkrb5-dev libmysqlclient-dev libsasl2-dev libsasl2-modules-gssapi-mit libsqlite3-dev libssl-dev libxml2-dev libxslt-dev make maven libldap2-dev python3.8-dev python-setuptools libgmp3-dev python3.8-distutils
wget https://bootstrap.pypa.io/get-pip.py
python3.8 get-pip.py
rm get-pip.py

# Hue
wget https://github.com/cloudera/hue/archive/refs/tags/release-4.11.0.tar.gz
tar xfvz release-4.11.0.tar.gz
mv hue-release-4.11.0 hue
rm release-4.11.0.tar.gz

# Variables
export PYTHON_VER=python3.8
export SKIP_PYTHONDEV_CHECK=true
export LDFLAGS="-L/usr/local/opt/libffi/lib -L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-L/usr/local/opt/libffi/lib/include -L/usr/local/opt/openssl@1.1/lib/include"
export ROOT=/home/hadoop/hue

# Install hue
cd hue
make apps
build/env/bin/hue runserver
