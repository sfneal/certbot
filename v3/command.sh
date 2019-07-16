#!/usr/bin/env bash

# Give the webserver 10 seconds to startup/run commands
sleep 10;

# Check if staging is enabled via ENV vars
if [[ ${staging} -ne 0 ]];
then
    echo "Staging environment enabled... certbot is using '--staging' flag."
    staging_cmd="--staging"
else
    echo "Production environment enabled... certbot is NOT using '--staging' flag."
    staging_cmd=""
fi

# Run certbot script for each domain
python3 /sites-scripts/certbot.py --domains "${domain}"

# Display certificates
certbot certificates

# Keep alive for 60 seconds
sleep 60