FROM certbot/certbot:v0.33.1

MAINTAINER stephen@hpadesign.com

# Domain & email environment variable
ENV certs_dir=/etc/letsencrypt/live
ENV validation_domain=validation.example.com
ENV email=example@example.com
ENV staging=0

# Update OS and add bash support
RUN apk update && apk add \
    bash \
    python3

# Copy script files
COPY /scripts/ /scripts/

# Install Python dependencies
RUN pip3 install --upgrade pip && pip3 install -r /scripts/requirements.txt

ENTRYPOINT ["bash"]
CMD ["/scripts/entrypoint.sh"]