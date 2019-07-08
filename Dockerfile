FROM certbot/certbot:v0.33.1

MAINTAINER=stephen@hpadesign.com

# Domain & email environment variable 
ENV domain=example.com
ENV email=stephen@hpadesign.com 

# Update OS and add bash support
RUN apk update && apk add bash \
	&& mkdir /webroot/ && mkdir /webroot/certbot/

# Copy entrypoint and command scripts
COPY ./command.sh /scripts/command.sh

ENTRYPOINT ["bash"]
CMD ["/scripts/command.sh"]