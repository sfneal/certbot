#!/usr/bin/env bash

set -e

# Function to check if a Docker container is running
is_container_running() {
    local container_name=$1

    # Check if the container is running
    sudo docker inspect -f '{{.State.Running}}' $(sudo docker ps -a --format "{{.Names}}" | grep "${container_name}")
}

# Show Docker version
sudo docker -v
sleep 20

# Execute Docker command on each container
for cn in ${container_name}; do
	while true; do
		# Get names of docker containers with 'nginx' in name
		container_id="$(sudo docker ps -a --format "table {{.Names}}" | grep ${cn})"

		# Confirm that the container_id is not empty
		if [[ ${#container_id} == 0 ]]; then
			# Try removing the '-' char to resolve the container ID
			cn=${cn//-/}
		else
			break
		fi
	done

	# Check to see that the container is running before executing command
	if [[ $(is_container_running ${cn}) == true ]]; then
		echo "Preparing to execute command on container with the ID '${container_id}'..."

		# Issue reload command to nginx webserver container
		sudo docker exec "${container_id}" bash "${container_cmd}"
		echo "Successfully restarted ${container_id}"
	else
		echo "Skipping command execution on container with the ID '${container_id}' because it is not running..."
	fi
done
