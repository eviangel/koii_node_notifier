#!/bin/bash

# Ask for the Webhook URL
read -p "Enter your discord webhook_url: " webhook_url

# Ask for frequency
echo "Enter the frequency for the job in minutes:"
read -p "Frequency: " frequency

# Current directory
current_dir=$(pwd)

# JSON file path
json_file="$current_dir/notifier_config.json"

# Script path in the current directory
script_path="$current_dir/test.sh"

# Check if the webhook URL is not empty
if [ -n "$webhook_url" ]; then
    # Prepare the line to be inserted
    insert_line="WEBHOOK_URL=\"$webhook_url\""

    # Insert the line at the second line of the script
    sed -i "1 a$insert_line" "$script_path"

    echo "Webhook URL has been inserted into $script_path"
else
    echo "No webhook URL provided; skipping update."
fi

# Add a new cron job with the specified frequency
(crontab -l 2>/dev/null; echo "*/$frequency * * * * /bin/bash '$script_path'") | crontab -

# Inform the user that the cron job has been added
echo "Cron job added with the specified frequency."