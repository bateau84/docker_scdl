# docker_scdl
scdl in docker

docker run -d -e SCDL_USERNAME=<soundcloud-username> -e SCDL_AUTH_TOKEN=<soundcloud-auth-token> -e SCDL_DOWNLOAD_PATH=/path/to/some/dir/ bateau/alpine_scdl:latest

use -v to mount up a local folder to download to and change the SCDL_DOWNLOAD_PATH to desired path
