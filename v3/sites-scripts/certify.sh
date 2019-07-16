#!/usr/bin/env bash

# Request Let's Encrypt certificate for ${domain}
certbot certonly --webroot \
    -w /webroot/certbot \
    --email ${email} \
    -d ${domain} \
    ${staging_cmd} \
    --rsa-key-size 4096 \
    --agree-tos \
    --non-interactive