FROM certbot/certbot:v0.38.0

MAINTAINER Stephen Neal <stephen@stephenneal.net>

# Domain & email environment variable
ENV certs_dir=/etc/letsencrypt/live
ENV validation_domain=validation.example.com
ENV email=example@example.com
ENV staging=0

# Update OS and add bash support
RUN apk update && apk add \
    bash \
    python3


# Install Python dependencies
COPY ./requirements.txt ./requirements.txt
RUN pip3 install --upgrade pip && pip3 install -r ./requirements.txt && rm ./requirements.txt

# Copy script files
COPY /scripts/ /scripts/

ENTRYPOINT ["bash"]
CMD ["/scripts/entrypoint.sh"]