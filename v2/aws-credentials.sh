#!/usr/bin/env bash
aws configure set aws_access_key_id ${aws_access_key_id} && \
aws configure set aws_secret_access_key ${aws_secret_access_key} && \
aws configure set aws_region_name ${aws_region_name}
echo AWS S3: credentialed!