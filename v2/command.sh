#!/usr/bin/env bash

# Check if staging is enabled via ENV vars
if [[ ${staging} -ne 0 ]];
then
    echo "Production environment enabled... certbot is NOT using '--staging' flag."
    staging_cmd=""
else
    echo "Staging environment enabled... certbot is using '--staging' flag."
    staging_cmd="--staging"
fi

# Delete dummy certificate for ${domain}
rm -Rf /etc/letsencrypt/live/${domain} \
    && rm -Rf /etc/letsencrypt/archive/${domain} \
    && rm -Rf /etc/letsencrypt/renewal/${domain}.conf

# TODO: Pull SSL certs from AWS S3

# TODO: Check certificate expiration date

# TODO: run lets encrypt if certificate is going to expire
# Request Let's Encrypt certificate for ${domain}
certbot certonly --webroot \
    -w /webroot/certbot \
    --email ${email} \
    -d ${domain} \
    ${staging_cmd} \
    --rsa-key-size 4096 \
    --agree-tos \
    --non-interactive \
    --force-renewal

certbot certificates

# Keep alive for 60 seconds
sleep 60

# TODO: Push SSL certs to AWS S3