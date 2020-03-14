#!/bin/bash
set -e
set -x

SCDL_USERNAME=${SCDL_USERNAME:-BOGUS}
SCDL_AUTH_TOKEN=${SCDL_AUTH_TOKEN:-TOKEN_NOT_SETT}
SCDL_DOWNLOAD_PATH=${SCDL_DOWNLOAD_PATH:-/home/abc/soundcloud/}
SCDL_DOWNLOAD_PATH_ESC=${SCDL_DOWNLOAD_PATH//\//\\\/}
SCDL_DEBUG=${SCDL_DEBUG:-"false"}
SCDL_HOME=$(grep scdl /etc/passwd | cut -d':' -f6)

/usr/bin/pip3 install setuptools
/usr/bin/pip3 install wheel
/usr/bin/pip3 install git+https://github.com/flyingrub/scdl

sed -r -i 's/auth_token = .*/auth_token = '${SCDL_AUTH_TOKEN}'/' ${SCDL_HOME}/.config/scdl/scdl.cfg
sed -r -i 's/path = .*/path = '${SCDL_DOWNLOAD_PATH_ESC}'/' ${SCDL_HOME}/.config/scdl/scdl.cfg

cat ${SCDL_HOME}/.config/scdl/scdl.cfg

MY_ID=$(curl -s 'http://api.soundcloud.com/me?oauth_token='${SCDL_AUTH_TOKEN} | jq -r '.id')
MY_USERNAME=$(curl -s 'http://api.soundcloud.com/me?oauth_token='${SCDL_AUTH_TOKEN} | jq -r '.username')

if [ ! -f ${SCDL_DOWNLOAD_PATH}scdl.lock ]; then
    if touch ${SCDL_DOWNLOAD_PATH}scdl.lock; then

        if [ ${SCDL_DEBUG} == "true" ]; then
            DEBUG_STRING="--debug"
        else
            DEBUG_STRING=""
        fi

        /home/scdl/.local/bin/scdl -l https://soundcloud.com/${MY_USERNAME} -a --download-archive ${SCDL_DOWNLOAD_PATH}completed -c ${DEBUG_STRING} --onlymp3 --addtofile || true

        rm -rf ${SCDL_DOWNLOAD_PATH}scdl.lock
    fi
fi
