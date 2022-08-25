#!/bin/bash
sed -i "s/relayhost =/relayhost = $RELAY_HOST/" /etc/postfix/main.cf

sed -i "s/#TCPSocket 3310/TCPSocket 3310/" /etc/clamav/clamd.conf
sed -i "s/#TCPAddr localhost/TCPAddr localhost/" /etc/clamav/clamd.conf

freshclam
clamd

rspamd -u rspamd -g rspamd -d
postfix start-fg