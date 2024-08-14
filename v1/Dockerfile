FROM certbot/certbot:v0.33.1

LABEL org.opencontainers.image.authors="stephen@stephenneal.net"

# Domain & email environment variable 
ENV domain=example.com
ENV email=example@example.com
ENV staging=0

# Update OS and add bash support
RUN apk update && apk add bash \
    && mkdir /webroot/ \
	&& mkdir /webroot/certbot/

# Copy entrypoint and command scripts
COPY ./command.sh /scripts/command.sh

ENTRYPOINT ["bash"]
CMD ["/scripts/command.sh"]