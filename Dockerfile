FROM alpine:latest

RUN apk upgrade --no-cache
RUN apk add --no-cache borgbackup

COPY docker-entrypoint.sh .
COPY crontab.txt .
COPY backup.sh .
RUN chmod 755 /docker-entrypoint.sh
RUN chmod 755 /crontab.txt
RUN chmod 755 /backup.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
