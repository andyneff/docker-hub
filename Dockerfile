FROM golang:alpine as builder

RUN apk add --no-cache bash git

ARG HUB_VERSION=v2.5.1

RUN git clone -b ${HUB_VERSION} https://github.com/github/hub.git $GOPATH/src/github.com/github/hub/

WORKDIR $GOPATH/src/github.com/github/hub/

RUN ./script/build -o bin/hub

# Scrtipt is broken, GREAT Don't care
# RUN bash ./script/install.sh

FROM alpine:3.8

RUN apk add --no-cache git

COPY --from=builder /go/src/github.com/github/hub/bin/hub /usr/local/bin/hub
# Don't care
# COPY --from=builder /usr/local/share/man/man1/hub*.1 /usr/local/share/man/man1/


# FROM alpine:3.8

# SHELL ["/usr/bin/env", "sh", "-euxvc"]

# RUN apk add --no-cache --virtual .deps wget ; \
#     wget -q -O hub.tgz "https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz"; \
# 	tar xzf hub.tgz; \
#     mv hub*/bin/hub /usr/local/bin/hub; \
# 	rm -r hub*; \
#     apk del --no-cache .deps