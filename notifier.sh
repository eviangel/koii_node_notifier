#!/bin/bash

# Define the docker image name
CONTAINER_NAME="task_node"

# Check if the container is running
CONTAINER_RUNNING=$(docker ps --filter "name=^/${CONTAINER_NAME}$" --format "{{.Names}}")

echo "Checking for container: $CONTAINER_NAME"
echo "Containers found: $CONTAINER_RUNNING"

# If the container is not running, then send the message
if [ -z "$CONTAINER_RUNNING" ]; then
    # Use Python to read the Webhook URL from the JSON file
    WEBHOOK_URL=$(python3 -c "import json; print(json.load(open('notifier_config.json'))['webhook_url'])")
    MESSAGE="Your koii node Docker container isn't running! Please check your VPS. To start it, go to the VPS-task directory and run: docker compose up."

    # Check if the WEBHOOK_URL is empty
    if [ -z "$WEBHOOK_URL" ]; then
        echo "Webhook URL is not defined. Please check your notifier_config.json file."
        exit 1
    fi

    # Send a message to the webhook
    curl -H "Content-Type: application/json" \
         -d "{\"content\": \"$MESSAGE\"}" \
         $WEBHOOK_URL
fi
