# Ports
```bash
# gathecageorge/hadoop:3.2.0
- 8088:8088 # Hadoop main
- 9870:9870 # Hadoop browser

# gathecageorge/anaconda-jupyter-pyspark:latest
- 8888:8888 # Jupyter notebook
```

# Running

Using docker compose is the recommended way to run. Just git clone this repo, cd into the directory and run `docker compose up -d`. This will start hue, mysql database for hue and hadoop. For hadoop, online image will be used, incase you want to build locally, change `hadoop.yml` to `hadoop-build.yml` in `.env` file. 

If you want to start anaconda/jupyter/pyspark you need to add `anaconda.yml`(Uses remote image) or `anaconda-build.yml`(Build image locally, might take a long time) to `.env` file with `:` before each yml file.

Using docker command.

```bash
# Run on an x64 host machine
docker run -v ./sampledata:/home/hadoop/sampledata -d --name hadoop -p 8088:8088 -p 9870:9870 --rm gathecageorge/hadoop:3.2.0

# If on apple silicon or arm
docker run -v ./sampledata:/home/hadoop/sampledata -d --platform linux/amd64 --name hadoop -p 8088:8088 -p 9870:9870 --rm gathecageorge/hadoop:3.2.0

# To run anaconda/jupyter/pyspark image use below command instead
docker run -v ./sampledata:/home/anaconda/notebooks -d --name anaconda -p 8888:8888 --rm gathecageorge/anaconda-jupyter-pyspark:latest
```

# Setting up on ubuntu linux

You can also use this repo to setup an ubuntu linux with hive and hadoop. Just clone or download repo as zip, then execute commands below.

```bash
cd setup-on-ubuntu-scripts

# If you are using root user, you need to create a non root user, use below script to do that
./install-user.sh USERNAME_HERE
# to switch to created user
su USERNAME_HERE
# to switch to user home folder
cd /home/USERNAME_HERE
# If you are on /bin/sh shell, you need /bin/bash
bash

# Setup everything now
./setup.sh
```

# Test on an ubuntu container
```bash
# Runs an ubuntu container to test executing all the commands one by one
# Will install hadoop, hive, anaconda, pyspark, jupyter
docker run --name test-script -p 8888:8888 -p 8088:8088 -p 9870:9870 -p 2223:22 -ti ubuntu:22.04 bash

# On the shell opened for ubuntu container

# 1st batch of commands as root user; can be copied together
apt update && apt install -y git
git clone https://github.com/gathecageorge/hadoop.git /setup
cd /setup/setup-on-ubuntu-scripts
./install-user.sh hadoop
su hadoop

# 2nd batch of commands as hadoop user; can be copied together
cd /home/hadoop
bash
/setup/setup-on-ubuntu-scripts/setup.sh
```
