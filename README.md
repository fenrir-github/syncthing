# syncthing docker

A quick docker of https://syncthing.net/

1-Create folder for data persistence:

 - syncthing folder: `/path/to/syncthing/`
Configuration will be in `/path/to/syncthing/.local`
Data will be in `/path/to/syncthing/`

2-Start container: `docker run --name syncthing -d --restart always -p 8384:8384 -p 22000:22000 -v /path/to/syncthing:/syncthing fenrir/syncthing`

 - 8384/tcp => WebUI, keep this access private and add a good password
 - 22000/tcp => protocole

3-Create "shares" in "~/" (from the docker point of view it's /syncthing/), ie: ~/photos

=>documentation: https://docs.syncthing.net/intro/getting-started.html
