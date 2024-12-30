FROM alpine

ARG TARGETARCH

ENV BUILT_ON_PLATFORM $TARGETARCH

USER root

COPY install.sh /tmp/install.sh

RUN apk update && apk upgrade && apk add --no-cache bash curl wget net-tools jq tar ca-certificates

RUN bash /tmp/install.sh && rm /tmp/install.sh

EXPOSE 16601

WORKDIR /goodluck

ENTRYPOINT ["/usr/share/lucky"]

CMD ["-cd", "/goodluck"]