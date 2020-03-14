#!/bin/bash
set -e
source /tmp/buildconfig
source /etc/os-release
set -x

## Temporarily disable dpkg fsync to make building faster.
if [[ ! -e /etc/dpkg/dpkg.cfg.d/docker-apt-speedup ]]; then
	echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup
fi

echo "deb http://security.ubuntu.com/ubuntu xenial-security main" >> /etc/apt/sources.list

## Update pkg repos
apt update

## Install things we need
$minimal_apt_get_install python3 python3-pip curl ffmpeg git jq dumb-init

## Create user
adduser --uid 1000 --shell /bin/bash scdl
addgroup scdl users
