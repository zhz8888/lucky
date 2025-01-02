FROM alpine

USER root

RUN apk update && apk upgrade && apk add --no-cache bash curl wget net-tools tar ca-certificates busybox-suid
RUN ln -sf /bin/busybox /usr/bin/crontab

EXPOSE 16601

WORKDIR /app
WORKDIR /goodluck

COPY lucky /app/lucky

RUN type nohup >/dev/null 2>&1 && nohup=nohup \
    $nohup /app/lucky -c "/app/lucky.conf" >/dev/null 2>&1 & \
    mkdir -p /etc/periodic/minutely/ \
    echo "*/1 * * * * test -z \"\$(pidof lucky)\" && /app/lucky -c /app/lucky.conf #lucky保守模式守护进程" > /etc/periodic/minutely/lucky-check \
    chmod +x /etc/periodic/minutely/lucky-check

ENTRYPOINT ["/app/lucky"]

CMD ["-c" "/goodluck/lucky.conf" "-runInDocker"]