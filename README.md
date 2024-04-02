# Syncthing docker

A quick docker of https://syncthing.net/

1-Create folder for data persistence: syncthing folder: `/path/to/syncthing/`
 - Configuration will be in `/path/to/syncthing/.local`
 - Data will be in `/path/to/syncthing/`

2-Start container: `docker run --name syncthing -d --restart always -p 8384:8384 -p 22000:22000 -v /path/to/syncthing:/syncthing fenrir/syncthing`

 - 8384/tcp => WebUI, keep this access private and add a good password
 - 22000/tcp => protocole

3-Create "shares" in "~/" (from the docker point of view it's /syncthing/), ie: ~/photos

=>documentation: https://docs.syncthing.net/intro/getting-started.html

# Migrating from previous version:

1-`move config to .local.state/syncthing and adjust permissions: `mkdir -p /path/to/syncthing/.local/state && mv /path/to/syncthing/conf /path/to/syncthing/.local/state/syncthing && mv /path/to/syncthing/Sync/* /path/to/syncthing/. && rmdir /path/to/syncthing/Sync && chown -R 999:999 /path/to/syncthing/`

2-`docker run --name syncthing -d --restart always -p 8384:8384 -p 22000:22000 -v /path/to/syncthing:/syncthing fenrir/syncthing`

3-Go to Action/Advanced and replace /home/syncthing/Sync/SHARENAME by /syncthing/SHARENAME for each share

