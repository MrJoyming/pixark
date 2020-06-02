# ----------------------------------
# PixARK Dockerfile
# Environment: Ubuntu:16.04 + Wine
# ----------------------------------
FROM        ubuntu:16.04

MAINTAINER  mingking, <mingking@rootx.pw>

# Install Dependencies

EXPOSE      27015/tcp
EXPOSE      27015/udp
EXPOSE      27016/tcp
EXPOSE      27016/udp
EXPOSE      27017/tcp
EXPOSE      27017/udp

RUN         dpkg --add-architecture i386 && \
            apt update && \
            apt upgrade -y && \
            apt install -y wget software-properties-common apt-transport-https lib32gcc1 steamcmd  && \
            wget https://dl.winehq.org/wine-builds/Release.key && \
            apt-key add Release.key && \
            apt-add-repository 'https://dl.winehq.org/wine-builds/ubuntu/' -y && \
            apt update && \
            apt install -y winehq-stable && \
            apt clean && \
            useradd -d /home/container -m container && \
            cd /home/container

USER        container
ENV         HOME /home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
