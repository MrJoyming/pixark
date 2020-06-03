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

RUN         dpkg --add-architecture i386 && \
            apt update && \
            apt install -y wget software-properties-common apt-transport-https libgcc1 && \
            wget -O - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add - && \
            add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' -y && \
            add-apt-repository ppa:cybermax-dexter/sdl2-backport -y && \
            apt install --install-recommends winehq-stable -y && \
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
