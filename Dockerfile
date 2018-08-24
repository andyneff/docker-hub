FROM alpine:3.8

SHELL ["/usr/bin/env", "sh", "-euxvc"]

ARG HUB_VERSION=2.5.1

RUN apk add --no-cache --virtual .deps wget ; \
    wget -q -O hub.tgz "https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz"; \
	tar xzf hub.tgz; \
    mv hub*/bin/hub /usr/local/bin/hub; \
	rm -r hub*; \
    apk del --no-cache .deps