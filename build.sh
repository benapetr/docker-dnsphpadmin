#!/bin/bash
set -e

#-- Check architecture
[[ $(uname -m) =~ ^armv7 ]] && ARCH="armv7-" || ARCH=""

VERBOSE=${VERBOSE:-1}
DNSPHPADMIN_VERSION=${DNSPHPADMIN_VERSION:-2.0.4}
source functions.sh      #-- Use common functions
detect_container_engine

#docker build --no-cache --rm \
$CONTAINER_ENGINE build --rm \
  --build-arg DNSPHPADMIN_VERSION=${DNSPHPADMIN_VERSION} \
  -t etaylashev/dnsphpadmin:${ARCH}latest .
