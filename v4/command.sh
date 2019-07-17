#!/usr/bin/env bash

# Give the webserver 20 seconds to startup/run commands
sleep 20;

# Check if staging is enabled via ENV vars
if [[ ${staging} -ne 0 ]];
then
    echo "Staging environment enabled... certbot is using '--staging' flag."
    staging_cmd="--staging --dry-run"
else
    echo "Production environment enabled... certbot is NOT using '--staging' flag."
    staging_cmd=""
fi

# Remove dummy cert directories and pack domains list into arg for certbot cli
# Execute certbot command
python3 /sites-scripts/certbot.py --domains "${domain}"

# Display certificates
certbot certificates

# Keep alive for 60 seconds
sleep 60