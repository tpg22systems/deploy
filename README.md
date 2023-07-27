# Commit and Deploy

This is in two parts, the Commit script, and the Deploy Docker Compose 

* The Commit Script is for updating the Registry from a local, updated version
* The Deploy Docker Compose File is to run up the system from the Registry

## Commit Script

### Prerequisites

#### Whitelist your IP

Since there is no authentication on the registry, it is IP address locked for now, so you may need to get your IP whitelisted first (office@camart.co.uk)

#### Tell Docker to use insecure connection

This script commits to docker.camart.co.uk:5000 registry.  This registry does not use ssl. Therefore you will need to tell Docker not to use ssl:

1. vi /etc/docker/daemon.json
2. assuming it is empty, add this json object: { "insecure-registries":["docker.camart.co.uk:5000"] }
3. service docker restart

### Usage

1. run up the tpg22-control-build in the usual way (docker compose build && docker compose up -d)
2. execute commit.sh from any directory

That's it really.

Note that you cannot run commit.sh twice without recomposing tpg22-control-build (not that you should need to)

This is because the script relies on the names of the containers, and these get substituted for image IDs when committed.

The script will of course cease to work if/when containers change name, though the :numerical_suffix can change (eg stoplight/prism:4) 

## Deploy Docker Compose File

This is currently dependent on the Mosqitto config directory from tpg22-control-build as well as the Compose File.  Hopefully this can be remedied.

It has been tested as far as getting the green status lights on the gui, but it is possible that there are subtler issues that we have not noticed - perhaps other config directories from tpg22-control-build ?

Just CD to the directory, and run 'docker compose up -d' in the usual way. Images will be fetched/updated from the Registry
