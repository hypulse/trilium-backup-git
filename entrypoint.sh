#!/bin/sh

touch /var/log/cron.log

(crontab -l 2>/dev/null; echo "$CRON_EXPRESSION \
export MAX_BACKUPS='$MAX_BACKUPS'; \
export API_ORIGIN='$API_ORIGIN'; \
export API_TOKEN='$API_TOKEN'; \
export GIT_ORIGIN_WITH_TOKEN='$GIT_ORIGIN_WITH_TOKEN'; \
export GIT_USER_EMAIL='$GIT_USER_EMAIL'; \
export GIT_USER_NAME='$GIT_USER_NAME'; \
/backup.sh >> /var/log/cron.log 2>&1") | crontab -

cron && tail -f /var/log/cron.log
