#!/usr/bin/env bash

# Assumptions:
#  - $domain_args has been set by certbot.py script
#  - $email and $staging_cmd have been set by env vars

# Request Let's Encrypt certificate for ${domain}
# TODO: replace with get request send to validation.hpadesign.com
certbot certonly --webroot \
    -w /webroot/certbot \
    ${domain_args} \
    --email ${email} \
    ${staging_cmd} \
    --rsa-key-size 4096 \
    --keep-until-expiring \
    --agree-tos \
    --non-interactive