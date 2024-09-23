# Ports
```bash
# gathecageorge/hadoop:3.2.0
- 8088:8088 # Hadoop main
- 9870:9870 # Hadoop browser

# quay.io/jupyter/all-spark-notebook:latest
- 8888:8888 # Jupyter notebook with pyspark
```

# Running

Using docker compose is the recommended way to run. Just git clone this repo, cd into the directory and run `docker compose up -d`. This will start hue, mysql database for hue and hadoop. For hadoop, online prebuilt image will be used, incase you want to build locally, change `hadoop.yml` to `hadoop-build.yml` in `.env` file. 

If you want to start jupyter notebooks with pyspark you need to add `jupyter.yml` to `.env` file with `:` before each yml file.

Using docker command.

```bash
# Run on an x64 host machine
docker run -v hadoop_store:/home/hadoop/hadoop_store -v ./sampledata:/home/hadoop/sampledata -d --name hadoop -p 8088:8088 -p 9870:9870 --rm gathecageorge/hadoop:3.2.0

# If on apple silicon or arm
docker run -v hadoop_store:/home/hadoop/hadoop_store -v ./sampledata:/home/hadoop/sampledata -d --platform linux/amd64 --name hadoop -p 8088:8088 -p 9870:9870 --rm gathecageorge/hadoop:3.2.0

# To run jupyter notebooks with pyspark image use below command instead
docker run -v ./sampledata:/home/jovyan/work -d --name jupyter -p 8888:8888 --rm quay.io/jupyter/all-spark-notebook:latest
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
# Will install hadoop and hive
docker run --rm -v ./setup-on-ubuntu-scripts:/setup --name test-script -p 8088:8088 -p 9870:9870 -p 2223:22 -ti ubuntu:22.04 bash

# On the shell opened for ubuntu container

# 1st batch of commands as root user; can be copied together
cd /setup && ./install-user.sh hadoop && su hadoop

# 2nd batch of commands as hadoop user; can be copied together
cd /home/hadoop && /setup/setup.sh
bash # Optional to open bash instead of sh shell
```
