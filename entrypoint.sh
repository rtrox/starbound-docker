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


if [ ! -f "$INSTALL_DIR/installed" ]; then
    printf "Waiting for install or update. Attach to the container and run %s.\n" "${HOMEDIR}/install.sh"
	printf "\nTo attach in docker:\n"
	printf "\tdocker exec -it <container name> bash\n"
	printf "\nTo attach in Kubernetes:\n"
	printf "\tkubectl exec -it <pod name> -- bash\n"
fi

while [ ! -f "$INSTALL_DIR/installed" ]; do
    printf "."
    sleep 5
done

while [ ! -z $DO_UPDATE ]; do
	printf "."
    sleep 5
done

printf "\n\nInstall/Update complete.\n"


# Start Server
printf "Starting Starbound server...\n"
cd ${INSTALL_DIR}linux/ && ./starbound_server &

child=$!

# Configure Server
printf "Configuring Starbound server... "
/home/steam/configure_server.sh
printf "Done.\n"

wait $child

tail -f /dev/null