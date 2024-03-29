# fenrir/syncthing
# syncthing
#
# VERSION 11.6.0
#
FROM debian:bullseye-slim
MAINTAINER Fenrir <dont@want.spam>

ENV DEBIAN_FRONTEND noninteractive
ENV VERSION stable

# Configure APT and install packages
RUN	echo 'APT::Install-Suggests "false";' > /etc/apt/apt.conf &&\
	echo 'APT::Install-Recommends "false";' >> /etc/apt/apt.conf &&\
	echo 'Aptitude::Recommends-Important "false";' >> /etc/apt/apt.conf &&\
	echo 'Aptitude::Suggests-Important "false";' >> /etc/apt/apt.conf &&\
	apt-get update &&\
	apt-get -y dist-upgrade &&\
	apt-get -y install \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg
	
# Install syncthing
	# Create syncthing user
RUN	useradd syncthing --home /home/syncthing --create-home --shell /sbin/nologin &&\
	#Add repo key
	curl -s https://syncthing.net/release-key.txt | apt-key add - &&\
	curl -s -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg &&\
	# Add repo
	# echo "deb https://apt.syncthing.net/ syncthing $VERSION" | tee /etc/apt/sources.list.d/syncthing.list &&\
	echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | tee /etc/apt/sources.list.d/syncthing.list &&\
	# Increase preference of Syncthing's packages ("pinning")
	printf "Package: *\nPin: origin apt.syncthing.net\nPin-Priority: 990\n" | tee /etc/apt/preferences.d/syncthing &&\
	# Install packages
	apt-get update && apt-get -y install syncthing

VOLUME ["/home/syncthing/config", "/home/syncthing/Sync"]
EXPOSE 8384/tcp 22000/tcp

USER syncthing
ENV STNOUPGRADE=1
ENV STNODEFAULTFOLDER=1
ENTRYPOINT ["/usr/bin/syncthing", "-home", "/home/syncthing/config", "-gui-address", "0.0.0.0:8384", "-no-browser"]
# ENTRYPOINT	["/bin/bash"]
