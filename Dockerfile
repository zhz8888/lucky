FROM debian:trixie AS builder
WORKDIR /app

ARG TARGET_ARCH
ENV BUILT_ON_PLATFORM $TARGET_ARCH

RUN apt-get update && apt-get upgrade -y && apt-get install -y curl wget tar jq tree

COPY install.sh /app/install.sh
RUN bash /app/install.sh

FROM alpine
LABEL maintainer="https://github.com/zhz8888"

RUN apk update && apk upgrade && apk add --no-cache bash curl wget net-tools tar ca-certificates busybox-suid tzdata jq
RUN ln -sf /bin/busybox /usr/bin/crontab

EXPOSE 16601

WORKDIR /app
WORKDIR /goodluck

COPY --from=builder /app/lucky /app/lucky

ENTRYPOINT ["/app/lucky"]

CMD ["-c", "/goodluck/lucky.conf", "-runInDocker"]