FROM alpine

USER root

RUN apk update && apk upgrade && apk add --no-cache bash curl wget net-tools tar ca-certificates busybox-suid
RUN ln -sf /bin/busybox /usr/bin/crontab

EXPOSE 16601

WORKDIR /app
WORKDIR /goodluck

COPY lucky /app/lucky

ENTRYPOINT ["/app/lucky"]

CMD ["-c" "/goodluck/lucky.conf" "-runInDocker"]