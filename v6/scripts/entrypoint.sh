#!/usr/bin/env bash

# Wait for nginx-laravel containers to write domain names to text file
sleep 10

# Check if staging is enabled via ENV vars
if [[ ${staging} -ne 0 ]];
then
    echo "Staging environment enabled... certbot is using '--staging' flag."
else
    echo "Production environment enabled... certbot is NOT using '--staging' flag."
fi

# Execute certbot command
echo "### Requesting Let's Encrypt certificate for ${domain} ..."
echo "### Using validation domain ${validation_domain}"
python3 /scripts/certbot.py \
    --email "${email}" \
    --staging "${staging}" \
    --validation-domain "${validation_domain}"

# Display certificates
echo "### Existing SSL certificates ..."
certbot certificates