#!/bin/sh
printenv | grep -v "no_proxy" >> /etc/environment  # Use environs vars
crontab /crontab.txt  # Update crontab
crond -f  # Start cron in foreground
