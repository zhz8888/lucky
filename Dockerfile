FROM alpine

USER root

COPY install.sh /tmp/install.sh

RUN apk update && apk upgrade && apk add --no-cache bash curl wget net-tools

RUN bash /tmp/install.sh && rm /tmp/install.sh

EXPOSE 16601

WORKDIR /goodluck

ENTRYPOINT ["/usr/share/lucky"]

CMD ["-cd", "/goodluck"]