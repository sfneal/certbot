FROM certbot/certbot:latest

# Domain environment variable
ENV domain=example.com

# Update OS and add bash support
RUN apk update && apk add bash \
	&& mkdir /webroot/ && mkdir /webroot/letsencrypt/

# Copy entrypoint and command scripts
COPY ./command.sh /scripts/command.sh

ENTRYPOINT ["bash"]
CMD ["/scripts/command.sh"]