# ----------------------------------
# PixARK Dockerfile
# Environment: Ubuntu:18.04 + Wine
# ----------------------------------
FROM        ubuntu:18.04

MAINTAINER  mingking, <mingking@rootx.pw>

# Install Dependencies

EXPOSE      27015/tcp
EXPOSE      27015/udp
EXPOSE      27016/tcp
EXPOSE      27016/udp
EXPOSE      27017/tcp
EXPOSE      27017/udp

RUN         sudo dpkg --add-architecture i386 && \
            wget -nc https://dl.winehq.org/wine-builds/winehq.key  && \
            apt-key add winehq.key && \
            apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' -y && \
            add-apt-repository ppa:cybermax-dexter/sdl2-backport -y && \
            apt update && \
            apt upgrade -y && \
            apt install --install-recommends winehq-stable && \
            wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
            mkdir -p /home/container/steam/steamcmd && \
            tar -zxvf steamcmd_linux.tar.gz -C /home/container/steam/steamcmd && \
            apt clean && \
            useradd -d /home/container -m container && \
            cd /home/container 

USER        container
ENV         HOME /home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
