FROM ubuntu:22.04
SHELL ["/bin/bash", "-c"]
COPY setup-on-ubuntu-scripts/ /temp

# Add user anaconda and allow sudo: Arguments passed <username> <clean-up>
RUN /temp/install-user.sh anaconda yes

# Change to created user and work directory to home folder of the user
WORKDIR /home/anaconda
USER anaconda

# Setup anaconda: Arguments passed <username> <script-dir> <clean-up>
# region ANACONDA_SETTINGS_HERE
ENV ANACONDA_HOME="/home/anaconda/Anaconda"
ENV PATH="$PATH:$ANACONDA_HOME/bin"
# endregion ANACONDA_SETTINGS_HERE
RUN /temp/install-anaconda.sh anaconda /temp yes

# Allow SSH and startup script
COPY startup-anaconda.sh /usr/local/bin/startup.sh
EXPOSE 8888
RUN sudo rm -rf /temp

ENTRYPOINT ["/bin/bash", "-c", "/usr/local/bin/startup.sh"]
