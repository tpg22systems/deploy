# TPG Golf Control Stystem Deploy 

This is in two parts, the Commit script, and the Deploy Docker Compose 

## Prerequisites

### Docker with the compose plugin

To run the game control server, you need to have "Docker" and the "compose plugin" installed. 

### Make

To use the makefile you will need to have "make" installed 

### Whitelist your IP

Since there is no authentication on the registry, it is IP address locked for now, so you may need to get your IP whitelisted first (office@camart.co.uk)

### Tell Docker to use insecure connection

This script commits to docker.camart.co.uk:5000 registry.  This registry does not use ssl. Therefore you will need to tell Docker not to use ssl:

1. vi /etc/docker/daemon.json
2. assuming it is empty, add this json object: { "insecure-registries":["docker.camart.co.uk:5000"] }
3. service docker restart

## Usage

### Production server (default)

To run a server using images tagged as "prod", simply invoke make: 

```bash
make 
```

### Staging server 

To run a staving server, which will load images tagged "latest"  use the "staging" recipe:

```bash
make staging
```

### Development server 

To run a development server, you will need to be using this command from within the tpg22-control-build repository. 

```bash
make dev
```

## Operations

### Updating to the latest images

Docker compose will automatically swap out containers. Runing make again, with the correct parameters should replace images that need updates.

Running *make* again will shut down only the images that need changing, and update them.

### Updating just config

It is possible to only update the config without a full image update.

```bash
make config
```

### Updateing node-red flow

Sometimes you just want to ensure that the flow is at the latest version.
This will also restart the container to get the new flow operational.

```bash
make logic 
```

### Shutdown

The down command will safely shutdown all containers. Use the command that matches your initial up commands. 

```bash
make down
```

```bash
make prod-down 
```

```bash
make dev-down 
```

### Wipe

If you want to start everything over, wipe all the containers and run make again. 

``` bash
make wipe
```

## Configuration options

### Locally stored context

The game data is normally stored in a docker volume. If you want to get easy access to the data to make it very simple for backup and restore, you can mount a directory on the host. Make sure that the direcory is writable.

Set **LOGIC_CONTEXT** in the .env file.

```bash
LOGIC_CONTEXT=./context
```
