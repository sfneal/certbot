ARG certbot_tag=v0.38.0

FROM certbot/certbot:${certbot_tag} AS builder

# Set working directory
WORKDIR /home/root/server

# Update OS and add bash support
RUN apk update \
    && apk add --update --no-cache --virtual .tmp-build-deps \
      curl \
      gcc \
      libc-dev \
      linux-headers \
      postgresql-dev \
    && apk add \
      libffi-dev \
      python3 \
	  py3-six

# Install rust (for cyryptograhy Python package installation)
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install Python dependencies
COPY ["requirements-base.txt", "requirements.txt", "./"]
RUN pip3 install --upgrade pip \
    && pip3 install --target=/home/root/server/dependencies -r ./requirements.txt \
    && rm ./requirements-base.txt \
    && rm ./requirements.txt



# Build from base certbot/certbot image
FROM certbot/certbot:${certbot_tag}
LABEL org.opencontainers.image.authors="stephen@stephenneal.net"

WORKDIR /home/root/server

# Domain & email environment variable
ENV certs_dir=/etc/letsencrypt/live
ENV validation_domain=validation.example.com
ENV email=example@example.com
ENV staging=0

# Update OS and add bash support
RUN apk update && apk add \
    python3 \
	py3-six

# Copy compiled builds
COPY --from=builder	/home/root/server .

# Set Python path
ARG PYTHONPATH
ENV PYTHONPATH="${PYTHONPATH}:/home/root/server/dependencies"

# Copy script files
COPY /scripts/ /scripts/

ENTRYPOINT ["sh"]
CMD ["/scripts/entrypoint.sh"]