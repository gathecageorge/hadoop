FROM ubuntu:22.04
ARG UID=1000
ARG GID=1000
ARG USERNAME=hadoop

COPY config/ /temp

RUN \
    # Add user hadoop and allow sudo
    export DEBIAN_FRONTEND=noninteractive \
    && apt update && apt install -y sudo \
    && groupadd --gid $GID $USERNAME \
    && useradd --uid $UID --gid $GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

WORKDIR /home/hadoop
USER hadoop

RUN \
    # Install tools
    sudo apt install -y nano openjdk-8-jdk openjdk-8-jre ssh openssh-server \
    # SSH setup
    && mkdir -p .ssh \
    && ssh-keygen -q -t rsa -N '' -f .ssh/id_rsa \
    && cat .ssh/id_rsa.pub > .ssh/authorized_keys \
    # Get hadoop and cleanup
    && wget https://www.dropbox.com/s/subianzkgumcpel/hadoop-3.2.0.tar.gz \
    && tar xfvz hadoop-3.2.0.tar.gz \
    && mv hadoop-3.2.0 hadoop \
    && rm hadoop-3.2.0.tar.gz \
    # setup hadoop
    && cat /temp/core-site.xml > hadoop/etc/hadoop/core-site.xml \
    && cat /temp/hadoop-env.sh > hadoop/etc/hadoop/hadoop-env.sh \
    && cat /temp/hdfs-site.xml > hadoop/etc/hadoop/hdfs-site.xml \
    && cat /temp/mapred-site.xml > hadoop/etc/hadoop/mapred-site.xml \
    && cat /temp/yarn-site.xml > hadoop/etc/hadoop/yarn-site.xml \
    && mkdir -p hadoop_store/hdfs \
    && sudo rm -rf /temp \
    && hadoop/bin/hdfs namenode -format

# Variables

# region HADOOP VARIABLES START
ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
ENV HADOOP_INSTALL="/home/hadoop/hadoop"
ENV PATH="$PATH:$HADOOP_INSTALL/bin"
ENV PATH="$PATH:$HADOOP_INSTALL/sbin"
ENV HADOOP_MAPRED_HOME="$HADOOP_INSTALL"
ENV HADOOP_COMMON_HOME="$HADOOP_INSTALL"
ENV HADOOP_HDFS_HOME="$HADOOP_INSTALL"
ENV YARN_HOME="$HADOOP_INSTALL"
ENV HADOOP_COMMON_LIB_NATIVE_DIR="$HADOOP_INSTALL/lib/native"
ENV HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib/native"
# endregion HADOOP VARIABLES END

ENV HDFS_NAMENODE_USER="hadoop"
ENV HDFS_DATANODE_USER="hadoop"
ENV HDFS_SECONDARYNAMENODE_USER="hadoop"
ENV YARN_RESOURCEMANAGER_USER="hadoop"
ENV YARN_NODEMANAGER_USER="hadoop"

# Allow SSH and startup script
COPY startup.sh /usr/local/bin/startup.sh
EXPOSE 22
RUN sudo mkdir /var/run/sshd

ENTRYPOINT ["/bin/bash", "-c", "/usr/local/bin/startup.sh"]
