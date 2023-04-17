#!/usr/bin/env bash

# Enable debugging
# set -x

# Setup error handling
set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o errexit   # set -e : exit the script if any statement returns a non-true return value

printf  "Running as user: %s\n" "$(whoami)"

INSTALL_DIR="${HOMEDIR}/starbound/"

if [ -z "$STEAM_USERNAME" ] || [ -z "$STEAM_PASSWORD" ]; then
    printf "STEAM_USERNAME and STEAM_PASSWORD environmental variables must be set.\n"
    exit
fi

if [ ! -d $INSTALL_DIR ]; then
    mkdir -p $INSTALL_DIR
fi

printf "Installing to %s\n" "${INSTALL_DIR}"

# Check that username and password are both set
if [ ! -z "$STEAM_USERNAME" ] && [ ! -z "$STEAM_PASSWORD" ]; then
	# Setup username/password for Steam
	sed -i "s/login anonymous/login $STEAM_USERNAME $STEAM_PASSWORD/g" /home/steam/install_starbound.txt

  ## FIXME: If we do this, then the installation will prompt us again for the Auth Code, not sure why?!
  # # Attempt to login
  # steamcmd +login $STEAM_USERNAME $STEAM_PASSWORD +quit
else
  echo "Missing STEAM_USERNAME and/or STEAM_PASSWORD, unable to continue!"
  exit 1
fi

# Install Mods
for mod in $STARBOUND_MODS; do
    if ! grep $mod $HOMEDIR/install.sh; then
       sed -i "/^quit/i\workshop_download_item 211820 ${mod}" $HOMEDIR/steamcmd/steamcmd.sh
    fi
done

/home/steam/steamcmd/steamcmd.sh +runscript /home/steam/install_starbound.txt

find ${INSTALL_DIR}steamapps/workshop/content/211820/ -mindepth 1 -type d -exec sed -i "/assetDirectories/a \"{}\"," ${INSTALL_DIR}linux/sbinit.config \;

touch ${INSTALL_DIR}installed
unset DO_UPDATE

printf "Install/Update sequence complete.\n"