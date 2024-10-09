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

domains_txt='/etc/letsencrypt/domains.txt'
sleep 3
until [[ -f ${domains_txt} ]]
do
    echo "Domains list file NOT found " ${domains_txt}
    sleep 3
done
echo "File found " ${domains_txt}

# Run cerbot for each validation domain
for vd in ${validation_domain}; do
    python3 /scripts/certbot.py \
        --email "${email}" \
        --staging "${staging}" \
        --validation-domain "${vd}"
done

# Display certificates
echo "### Existing SSL certificates ..."
certbot certificates

# Restart webservers
sh /scripts/restart-webservers.sh