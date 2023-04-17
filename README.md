# Starbound Docker

Starbound Server inside a container, optimized for use in docker-compose/portainer/kubernetes.

# Running via Docker Compose

First, edit the environmental variables in [`examples/docker-compose.yaml`](examples/docker-compose.yaml), and then run:

```bash
docker-compose up -d
```

Once started you will see this message in the logs:
```
Starbound server not found. Attach and run /home/steam/install.sh.
```

Proceed to "Authenticating & Installing"

# Running in Kubernetes

Similar to docker-compose, but instead, edit [`kubernetes.yaml`](examples/kubernetes.yaml) and:

```bash
kubectl apply -f examples/kubernetes.yaml
```

Once started you will see this message in the logs:
```
Starbound server not found. Attach and run /home/steam/install.sh.
```

Proceed to "Authenticating & Installing"

# Authenticating & Installing

Because Starbound requires login to download, you'll need to enter your Steam Guard code, so first install must be slightly interactive. Once installed, interaction is only needed when you'd like to update. Once you're ready:

1. Enter the container
```
docker exec -it starbound-docker-starbound-1 /bin/bash
```

2. Run the install script
```
/home/steam/install.sh
```

3. Enter your Steam Guard code when you see the prompt:
```
steam@3dfa89b7a099:/$ /home/steam/install.sh
Running as user: steam
Installing to /home/steam/starbound/
Redirecting stderr to '/home/steam/Steam/logs/stderr.txt'
[  0%] Checking for available updates...
[----] Verifying installation...
[  0%] Downloading update...
[  0%] Checking for available updates...
[----] Download complete.
[----] Extracting package...
[----] Extracting package...
[----] Extracting package...
[----] Extracting package...
[----] Installing update...
[----] Installing update...
[----] Installing update...
[----] Installing update...
[----] Installing update...
[----] Installing update...
[----] Installing update...
[----] Installing update...
[----] Cleaning up...
[----] Update complete, launching Steamcmd...
Redirecting stderr to '/home/steam/Steam/logs/stderr.txt'
[  0%] Checking for available updates...
[----] Verifying installation...
Steam Console Client (c) Valve Corporation - version 1679680174
-- type 'quit' to exit --
Loading Steam API...OK
@sSteamCmdForcePlatformType linux
"@sSteamCmdForcePlatformType" = "linux"
force_install_dir /home/steam/starbound
Logging in user 'yourusername' to Steam Public...
Enter the current code from your Steam Guard Mobile Authenticator app
Two-factor code:ABCDF
OK
Waiting for client config...OK
Waiting for user info...OK
```

# Updating

1. Set the `DO_UPDATE` environmental variable (it doesn't matter what you set it to as long as it's set) in your `docker-compose.yaml` or `kubernetes.yaml` file.

2. Restart your container. Because the `DO_UPDATE` var is set, it will go back into the `Attach and run` loop.

3. Attach and re-run `/home/steam/install.sh`.

4. remove the `DO_UPDATE` env variable from your config and restart.