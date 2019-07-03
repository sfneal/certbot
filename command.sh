#!/usr/bin/env bash

# Delete dummy certificate for ${domain}
rm -Rf /etc/letsencrypt/live/${domain} \
    && rm -Rf /etc/letsencrypt/archive/${domain} \
    && rm -Rf /etc/letsencrypt/renewal/${domain}.conf

# Request Let's Encrypt certificate for ${domain}
certbot certonly --webroot \
    -w /var/www/certbot \
    --email stephen@hpadesign.com \
    -d ${domain} \
    --rsa-key-size 4096 \
    --agree-tos \
    --force-renewal