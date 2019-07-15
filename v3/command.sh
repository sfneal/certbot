#!/usr/bin/env bash

# Check if staging is enabled via ENV vars
if [[ ${staging} -ne 0 ]];
then
    echo "Staging environment enabled... certbot is using '--staging' flag."
    staging_cmd="--staging"
else
    echo "Production environment enabled... certbot is NOT using '--staging' flag."
    staging_cmd=""
fi

# Give the webserver 10 seconds to startup/run commands
sleep 10;

# Delete dummy certificate for ${domain}
rm -Rf /etc/letsencrypt/live/${domain} \
    && rm -Rf /etc/letsencrypt/archive/${domain} \
    && rm -Rf /etc/letsencrypt/renewal/${domain}.conf

# Request Let's Encrypt certificate for ${domain}
certbot certonly --webroot \
    -w /webroot/certbot \
    --email ${email} \
    -d ${domain} \
    ${staging_cmd} \
    --rsa-key-size 4096 \
    --agree-tos \
    --non-interactive

certbot certificates

# Keep alive for 60 seconds
sleep 60