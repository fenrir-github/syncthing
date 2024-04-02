# fenrir/syncthing
# syncthing
#
# VERSION 12.0.0
#
FROM debian:bookworm-slim
MAINTAINER Fenrir <dont@want.spam>

ENV DEBIAN_FRONTEND noninteractive
ENV VERSION stable

# Configure APT and install packages
RUN     echo 'APT::Install-Suggests "false";' > /etc/apt/apt.conf &&\
        echo 'APT::Install-Recommends "false";' >> /etc/apt/apt.conf &&\
        echo 'Aptitude::Recommends-Important "false";' >> /etc/apt/apt.conf &&\
        echo 'Aptitude::Suggests-Important "false";' >> /etc/apt/apt.conf &&\
        apt-get update &&\
        apt-get -y dist-upgrade &&\
        apt-get -y install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg &&\
  rm -rf /var/lib/apt/lists/*

# Install syncthing
        #Add repo key
RUN     curl --location --silent --output /etc/apt/keyrings/syncthing-archive-keyring.gpg --create-dirs https://syncthing.net/release-key.gpg &&\
        # Add repo
  echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | tee /etc/apt/sources.list.d/syncthing.list &&\
        # Increase preference of Syncthing's packages ("pinning")
        printf "Package: *\nPin: origin apt.syncthing.net\nPin-Priority: 990\n" | tee /etc/apt/preferences.d/syncthing &&\
        # Install packages
        apt-get update && apt-get -y install syncthing &&\
  rm -rf /var/lib/apt/lists/*

# Create syncthing user
RUN useradd -r syncthing --shell /sbin/nologin &&\
  mkdir /syncthing &&\
  chown syncthing:syncthing /syncthing &&\
  usermod --home /syncthing syncthing

VOLUME ["/syncthing"]
EXPOSE 8384/tcp 22000/tcp

USER syncthing
ENV STNOUPGRADE=1
ENV STNODEFAULTFOLDER=1
ENTRYPOINT ["/usr/bin/syncthing", "--gui-address", "0.0.0.0:8384", "--no-browser"]
