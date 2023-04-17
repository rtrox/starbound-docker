#!/usr/bin/env bash

# Enable debugging
# set -x

# Setup error handling
set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o errexit   # set -e : exit the script if any statement returns a non-true return value

CONFIG_FILE="${HOMEDIR}/starbound/storage/starbound_server.config"

while [ ! -f ${CONFIG_FILE} ]; do
    printf "."
    sleep 1
done

if ! [ -z ${SERVER_NAME+x} ]; then
    sed -i "s/\"serverName\".*$/\"serverName\" : \"${SERVER_NAME}\",/g" ${CONFIG_FILE}
fi

if ! [ -z ${SERVER_PORT+x} ]; then
    sed -i "s/\"gameServerPort\".*$/\"gameServerPort\" : ${SERVER_PORT},/g" ${CONFIG_FILE}
    sed -i "s/\"queryServerPort\".*$/\"queryServerPort\" : ${SERVER_PORT},/g" ${CONFIG_FILE}
fi

if ! [ -z ${RCON_PORT+x} ]; then
    sed -i "s/\"runRconServer\".*$/\"runRconServer\" : true,/g" ${CONFIG_FILE}
    sed -i "s/\"rconServerPort\".*$/\"rconServerPort\" : ${RCON_PORT},/g" ${CONFIG_FILE}
fi

if ! [ -z ${RCON_PASSWORD+x} ]; then
    sed -i "s/\"runRconServer\".*$/\"runRconServer\" : true,/g" ${CONFIG_FILE}
    sed -i "s/\"rconServerPassword\".*$/\"rconServerPassword\" : \"${RCON_PASSWORD}\",/g" ${CONFIG_FILE}
fi

if ! [ -z ${RUN_RCON_SERVER+x} ]; then
    sed -i "s/\"runRconServer\".*$/\"runRconServer\" : true,/g" ${CONFIG_FILE}
fi

if ! [ -z ${RUN_QUERY_SERVER+x} ]; then
    sed -i "s/\"runQueryServer\".*$/\"runQueryServer\" : true,/g" ${CONFIG_FILE}
fi

if ! [ -z ${MAX_PLAYERS+x} ]; then
    sed -i "s/\"maxPlayers\".*$/\"maxPlayers\" : ${MAX_PLAYERS},/g" ${CONFIG_FILE}
fi

if ! [ -z ${MAX_TEAM_SIZE+x} ]; then
    sed -i "s/\"maxTeamSize\".*$/\"maxTeamSize\" : ${MAX_TEAM_SIZE},/g" ${CONFIG_FILE}
fi