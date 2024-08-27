#!/bin/bash

# Container name
CONTAINER_NAME="docker_tmp"

# Check if the container exists (either running or stopped)
CONTAINER_ID=$(docker ps -aq -f name=$CONTAINER_NAME)

if [ -n "$CONTAINER_ID" ]; then
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        echo "Container '$CONTAINER_NAME' is already running."
        # Get a shell into the running container
        docker exec -it $CONTAINER_NAME /bin/sh -c "cd /root && /bin/bash"
    else
        echo "Container '$CONTAINER_NAME' is stopped. Restarting it."
        # Start the stopped container
        docker start $CONTAINER_NAME
        # Get a shell into the restarted container
        docker exec -it $CONTAINER_NAME /bin/sh -c "cd /root && /bin/bash"
    fi
else
    echo "Container '$CONTAINER_NAME' does not exist. Creating and setting up a new one."

    # Run a new container with a dummy command to keep it running
    docker run -d --name $CONTAINER_NAME kalilinux/kali-rolling /bin/sh -c "sleep infinity"

    # Create a setup file with the commands inside the container
    echo '#!/bin/sh' > setup.sh
    echo 'apt update && apt upgrade && apt -y install kali-linux-headless' >> /tmp/setup.sh
    docker cp /tmp/setup.sh $CONTAINER_NAME:/setup.sh
    docker cp /tmp/setup.sh $CONTAINER_NAME:/root/setup.sh

    # Attach to the new container with a shell
    docker exec -it $CONTAINER_NAME /bin/sh -c "cd /root && /bin/bash"
fi
