FROM certbot/certbot:v0.33.1

MAINTAINER stephen@hpadesign.com

# Domain & email environment variable
ENV domain=example.com
ENV email=example@example.com
ENV staging=0

# AWS S3 creditentials
ENV aws_s3=0
ENV aws_access_key_id=""
ENV aws_secret_access_key=""
ENV aws_region_name=""

# Make certbot root directory for ACME challenges
RUN mkdir /webroot/ && mkdir /webroot/certbot/

# Update OS and add bash support
RUN apk update && apk add bash python3 \
    && pip3 install --upgrade pip \
	&& pip3 install awscli

# Copy entrypoint and command scripts
COPY ./command.sh /scripts/command.sh
COPY ./aws-credentials.sh /scripts/aws-credentials.sh

ENTRYPOINT ["bash"]
CMD ["/scripts/command.sh"]