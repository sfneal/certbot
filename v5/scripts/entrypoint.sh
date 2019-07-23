#!/usr/bin/env bash

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
python3 /scripts/certbot.py \
    --domains "${domain}" \
    --email "${email}" \
    --staging "${staging}" \
    --validation-domain "${validation_domain}"

# Wait for Dind container to pull certs from validation server and restart nginx
sleep 30

# Display certificates
echo "### Updated SSL certificates ..."
certbot certificates

# Keep alive for 60 seconds
sleep 60