#!/bin/bash

# Ask for the Webhook URL
read -p "Enter your discord webhook_url: " webhook_url

# Ask for frequency
echo "Enter the frequency for the job in hours:"
read -p "Frequency: " frequency

# Current directory
current_dir=$(pwd)

# JSON file path
json_file="$current_dir/notifier_config.json"

# Script path in the current directory
script_path="$current_dir/notifier.sh"

# Log path in the current directory
log_path="$current_dir/notifier_log.log"

# Check if the webhook URL is not empty
if [ -n "$webhook_url" ]; then
    # Create or update the JSON file with the webhook URL
    echo "{\"webhook_url\": \"$webhook_url\"}" > "$json_file"
    echo "Webhook URL has been written to $json_file"

    # Prepare the line to be inserted
    insert_line="WEBHOOK_URL=\"$webhook_url\""

    # Check if the webhook URL is already set in the script, to prevent duplicate entries
    if ! grep -q "WEBHOOK_URL=" "$script_path"; then
        # Insert the line at the second line of the script
        sed -i "1 a$insert_line" "$script_path"
        echo "Webhook URL has been inserted into $script_path"
    else
        echo "Webhook URL is already present in the script."
    fi
else
    echo "No webhook URL provided; skipping update."
fi

# Check if the cron job with the specified script and frequency already exists
if ! crontab -l | grep -q "$script_path"; then
    # Add a new cron job with the specified frequency
    (crontab -l 2>/dev/null; echo "0 */$frequency * * * /bin/bash '$script_path' > '$log_path' 2>&1") | crontab -
    echo "Cron job added with the specified frequency."
else
    echo "Cron job for the script already exists."
fi
