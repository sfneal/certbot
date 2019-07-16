FROM certbot/certbot:v0.33.1

MAINTAINER stephen@hpadesign.com

# Domain & email environment variable 
ENV domain=example.com
ENV email=example@example.com
ENV staging=0

# Make ACME challenge root
RUN mkdir /webroot/ && mkdir /webroot/certbot/

# Update OS and add bash support
RUN apk update && apk add \
    bash \
    python3

# Copy script files & install Python dependencies
RUN pip3 install --upgrade pip && pip3 install dirutility
COPY ./sites-scripts/ /sites-scripts/

# Copy entrypoint and command scripts
COPY ./command.sh /scripts/command.sh

ENTRYPOINT ["bash"]
CMD ["/scripts/command.sh"]