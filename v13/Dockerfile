# Base PHP image tags
ARG certbot_tag=v1.32.2

# Build from base certbot/certbot image
FROM certbot/certbot:${certbot_tag}
MAINTAINER Stephen Neal <stephen@stephenneal.net>

# Domain & email environment variable
ENV certs_dir=/etc/letsencrypt/live
ENV validation_domain=validation.example.com
ENV email=example@example.com
ENV staging=0

# Update OS and add bash support
RUN apk update && apk add \
    python3

# Install Python dependencies
COPY ./requirements.txt ./requirements.txt
RUN pip3 install --upgrade pip \
	&& pip3 install -r ./requirements.txt \
	&& rm ./requirements.txt

# Copy script files
COPY /scripts/ /scripts/

ENTRYPOINT ["sh"]
CMD ["/scripts/entrypoint.sh"]