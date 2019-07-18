#!/usr/bin/env bash

# Give the webserver 20 seconds to startup/run commands
sleep 20;

# Check if staging is enabled via ENV vars
if [[ ${staging} -ne 0 ]];
then
    echo "Staging environment enabled... certbot is using '--staging' flag."
else
    echo "Production environment enabled... certbot is NOT using '--staging' flag."
fi

# Display certificates
echo "### Existing SSL certificates ..."
certbot certificates

# Execute certbot command
echo "### Requesting Let's Encrypt certificate for ${domain} ..."
echo "### Using validation domain ${validation_domain}"
python3 /sites-scripts/certbot.py \
    --domains "${domain}" \
    --email "${email}" \
    --staging "${staging}" \
    --validation-domain "${validation_domain}"

# Display certificates
certbot certificates

# Keep alive for 60 seconds
sleep 60