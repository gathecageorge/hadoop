FROM ubuntu:22.04
SHELL ["/bin/bash", "-c"]
COPY setup-on-ubuntu-scripts/ /temp

# Add user hadoop and allow sudo: Arguments passed <username> <clean-up>
RUN /temp/install-user.sh hadoop yes

# Change to created user and work directory to home folder of the user
WORKDIR /home/hadoop
USER hadoop

# Setup ssh: Arguments passed <script-dir> <clean-up>
RUN /temp/install-ssh.sh /temp yes

# Setup hadoop: Arguments passed <username> <script-dir> <clean-up>
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
ENV HDFS_NAMENODE_USER="hadoop"
ENV HDFS_DATANODE_USER="hadoop"
ENV HDFS_SECONDARYNAMENODE_USER="hadoop"
ENV YARN_RESOURCEMANAGER_USER="hadoop"
ENV YARN_NODEMANAGER_USER="hadoop"
# endregion HADOOP VARIABLES END
RUN /temp/install-hadoop.sh hadoop /temp yes

# Setup hive: Arguments passed <username> <script-dir> <clean-up>
# region HIVE_SETTINGS_HERE
ENV HIVE_HOME="/home/hadoop/hive"
ENV PATH="$PATH:$HIVE_HOME/bin"
# endregion HIVE_SETTINGS_HERE
RUN /temp/install-hive.sh hadoop /temp yes

# Allow SSH and startup script
COPY startup.sh /usr/local/bin/startup.sh
EXPOSE 22
EXPOSE 8088
EXPOSE 9870
RUN sudo mkdir /var/run/sshd
RUN sudo rm -rf /temp

ENTRYPOINT ["/bin/bash", "-c", "/usr/local/bin/startup.sh"]
