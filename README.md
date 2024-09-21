# Running

Using docker compose will build the image locally and run it. This might take alot of time, just git clone this repo, cd into the directory and run `docker compose up -d`

Using docker command is easier and uses an already built image thus faster.

```bash
docker run -d --name hadoop -p 8088:8088 -p 9870:9870 -p 8888:8888 --rm gathecageorge/hadoop:3.2.0

# If on apple silicon or arm
docker run -d --platform linux/amd64 --name hadoop -p 8088:8088 -p 9870:9870 -p 8888:8888 --rm gathecageorge/hadoop:3.2.0
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
docker run --name test-script -p 8088:8088 -p 9870:9870 -p 2223:22 -p 8888:8888 -ti ubuntu:22.04 bash

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
