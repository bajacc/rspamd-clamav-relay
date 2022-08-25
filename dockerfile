FROM alpine:3.16

EXPOSE 25

RUN apk add --no-cache bash postfix rspamd rspamd-controller rspamd-proxy rspamd-fuzzy clamav

COPY conf/main.cf /etc/postfix
COPY conf/logging.inc local.d
COPY conf/antivirus.conf /etc/rspamd/local.d/
COPY conf/milter_headers.conf /etc/rspamd/local.d/
COPY run.sh run.sh

RUN ["mkdir", "/run/clamav"]
RUN ["chown", "-R", "clamav:clamav", "/run/clamav"]

RUN ["chmod", "+x", "run.sh"]
ENTRYPOINT ["./run.sh"]
