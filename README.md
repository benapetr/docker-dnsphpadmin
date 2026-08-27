# docker-dnsphpadmin
This project is to wrap the [dnsphpadmin](https://github.com/benapetr/dnsphpadmin) tool into a Docker image.

The image builds dnsphpadmin 2.0.4 by default:
```
./build.sh
```

The helper scripts use Docker when available and fall back to Podman. To force one engine:
```
CONTAINER_ENGINE=podman ./build.sh
```

To build a different dnsphpadmin release, override the build argument:
```
DNSPHPADMIN_VERSION=2.0.1 ./build.sh
```

Apache's ``httpd.conf`` and DNSphpAdmin's ``config.php`` files could be located in a mounted volume for persistent configuration:
```
docker run -d \
  --name dnsadmin \
  -p 8080:80/tcp \
  -v ./my-conf:/etc/dnsphpadmin \
  -e VERBOSE=${VERBOSE} \
etaylashev/dnsphpadmin:${ARCH}latest
```
