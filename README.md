# syncthing docker

A quick docker for of https://syncthing.net/

1-Create folders for volumes:

 - syncthink configuration folder: `/path/to/syncthing/config`
 - syncthink data folder: `/path/to/syncthing/data`

2-Start container: `docker run --name syncthing -d --restart always -p 8384:8384 -p 22000:22000 -v /path/to/syncthing/config:/home/syncthing/config -v /path/to/syncthing/data:/home/syncthing/Sync fenrir/syncthing`

 - 8384/tcp => WebUI, keep this access private
 - 22000/tcp => protocole

3-Create "shares" in "/home/syncthing/Sync" (from the docker point of view), ie: /home/syncthing/Sync/photos)

=>documentation: https://docs.syncthing.net/intro/getting-started.html
