#!/usr/bin/env bash

# Setup error handling
set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o errexit   # set -e : exit the script if any statement returns a non-true return value

INSTALL_DIR="${HOMEDIR}/starbound/"

#Exit Handler
exit_handler()
{
	printf "\nWaiting for server to shutdown...\n"
	kill -SIGINT "$child"
	sleep 5

	printf "Terminating..,\n"
	exit 0
}
trap "exit_handler" SIGHUP SIGINT SIGQUIT SIGTERM

printf  "Running as user: %s\n" "$(whoami)"


while [ ! -f "$INSTALL_DIR/installed" ]; do
    printf "Starbound server not found. Attach and run %s.\n" "${HOMEDIR}/install.sh"
    sleep 5
done

while [ ! -z $DO_UPDATE ]; do
    printf "DO_UPDATE variable is set, waiting for update. Attach and run %s.\n" "${HOMEDIR}/install.sh"
    sleep 5
done

# Start Server
printf "Starting Starbound server...\n"
cd ${INSTALL_DIR}linux/ && ./starbound_server &

child=$!

wait $child