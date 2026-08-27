FROM alpine:latest

ARG BUILD_DATE
ARG DNSPHPADMIN_VERSION=2.0.4
#-- default environment variables
ENV VERBOSE=1
ENV DNSPHPADMIN_VERSION=${DNSPHPADMIN_VERSION}
ENV URL_DNSPHPADMIN=https://github.com/benapetr/dnsphpadmin/releases/download/${DNSPHPADMIN_VERSION}/dnsphpadmin_${DNSPHPADMIN_VERSION}.tar.gz
ENV DIR_CODE=/var/dnsphpadmin
ENV DIR_CONF=/etc/dnsphpadmin

RUN apk --update --no-cache add apache2 apache2-ssl ssmtp bind-tools bind-libs ca-certificates wget \
  php84-apache2 php84-curl php84-gd php84-intl php84-ldap php84-mbstring php84-openssl php84-session php84-xml

#-- Redirect logs
RUN ln -sf /dev/stdout /var/log/apache2/access.log && ln -sf /dev/stderr /var/log/apache2/error.log

LABEL maintainer="Eugene Taylashev" \
  url="https://github.com/eugene-taylashev/docker-dnsphpadmin" \
  source="https://hub.docker.com/repository/docker/etaylashev/dnsphpadmin" \
  title="Run DnsPhpAdmin as a container" \
  description="DnsPhpAdmin is a DNS web admin panel written in PHP, designed to operate via nsupdate, for all kinds of RFC compliant DNS servers. "

#-- do preparations
RUN mkdir $DIR_CODE $DIR_CONF
RUN wget -O /tmp/dnsphpadmin.tar.gz $URL_DNSPHPADMIN \
  && tar -xzf /tmp/dnsphpadmin.tar.gz --strip-components=1 -C $DIR_CODE \
  && rm -f /tmp/dnsphpadmin.tar.gz

#-- ports exposed
EXPOSE 80
EXPOSE 443

#-- Volume with actual DnsPhpAdmin and configuration files
VOLUME $DIR_CONF

#-- default environment variables
ENV VERBOSE=0

COPY ./entrypoint.sh /usr/local/bin/

CMD ["entrypoint.sh"]
