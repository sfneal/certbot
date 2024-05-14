# Base PHP image tags
ARG certbot_tag=v1.18.0

FROM certbot/certbot:${certbot_tag} as builder

# Set working directory
WORKDIR /home/root/server

# Update OS and add bash support
RUN apk update \
    && apk add --update --no-cache --virtual .tmp-build-deps \
      gcc \
      libc-dev \
      linux-headers \
      postgresql-dev \
    && apk add \
      libffi-dev \
      python3

# Install Python dependencies
COPY ./requirements.txt ./requirements.txt
RUN pip3 install --upgrade pip \
	&& pip3 install --target=/home/root/server/dependencies -r ./requirements.txt



# Build from base certbot/certbot image
FROM certbot/certbot:${certbot_tag}
MAINTAINER Stephen Neal <stephen@stephenneal.net>

WORKDIR /home/root/server

# Domain & email environment variable
ENV certs_dir=/etc/letsencrypt/live
ENV validation_domain=validation.example.com
ENV email=example@example.com
ENV staging=0

# Update OS and add bash support
RUN apk update && apk add \
    python3

# Copy compiled builds
COPY --from=builder	/home/root/server .

# Set Python path
ENV PYTHONPATH="${PYTHONPATH}:/home/root/server/dependencies"

# Copy script files
COPY /scripts/ /scripts/

ENTRYPOINT ["sh"]
CMD ["/scripts/entrypoint.sh"]