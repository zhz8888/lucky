FROM debian AS builder
WORKDIR /app

ARG TARGETARCH
ENV BUILT_ON_PLATFORM $TARGETARCH

RUN apt-get update && apt-get install -y curl wget tar jq tree

COPY install.sh /app/install.sh
RUN bash /app/install.sh

FROM alpine
LABEL maintainer="https://github.com/zhz8888"

RUN apk update && apk upgrade
RUN apk add --no-cache bash curl wget net-tools tar ca-certificates busybox-suid tzdata jq
RUN ln -sf /bin/busybox /usr/bin/crontab

EXPOSE 16601

WORKDIR /app
WORKDIR /goodluck

COPY --from=builder /app/lucky /app/lucky

ENTRYPOINT ["/app/lucky"]

CMD ["-c", "/goodluck/lucky.conf", "-runInDocker"]