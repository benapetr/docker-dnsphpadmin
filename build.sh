#!/bin/bash
set -e

#-- Check architecture
[[ $(uname -m) =~ ^armv7 ]] && ARCH="armv7-" || ARCH=""

DNSPHPADMIN_VERSION=${DNSPHPADMIN_VERSION:-2.0.2}

#docker build --no-cache --rm \
docker build --rm \
  --build-arg DNSPHPADMIN_VERSION=${DNSPHPADMIN_VERSION} \
  -t etaylashev/dnsphpadmin:${ARCH}latest .
