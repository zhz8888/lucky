FROM alpine

ARG TARGETARCH

ENV BUILT_ON_PLATFORM $TARGETARCH

USER root

EXPOSE 16601

WORKDIR /goodluck

COPY install.sh /tmp/install.sh

RUN apk update && apk upgrade && apk add --no-cache bash curl wget net-tools jq tar ca-certificates busybox-suid
RUN ln -sf /bin/busybox /usr/bin/crontab
RUN bash /tmp/install.sh && rm /tmp/install.sh

ENTRYPOINT ["/etc/lucky"]

CMD ["-cd", "/goodluck"]
CMD ["crond", "-f", "-l", "8"]