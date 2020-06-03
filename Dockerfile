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

RUN         sudo dpkg --add-architecture i386 
RUN         apt update
RUN         apt upgrade -y
RUN         apt install lib32gcc1 wget -y
RUN         wget -nc https://dl.winehq.org/wine-builds/winehq.key
RUN         apt-key add winehq.key
RUN         apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' -y
RUN         add-apt-repository ppa:cybermax-dexter/sdl2-backport -y
RUN         apt install --install-recommends winehq-stable -y
RUN         wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
RUN         mkdir -p /home/container/steam/steamcmd
RUN         tar -zxvf steamcmd_linux.tar.gz -C /home/container/steam/steamcmd
RUN         apt clean
RUN         useradd -d /home/container -m container
RUN         cd /home/container 
USER        container
ENV         HOME /home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
