#!/bin/bash

export BORG_REPO

DEFAULT_ARCHIVE="${HOSTNAME}_$(date +%Y-%m-%d)"
ARCHIVE="${ARCHIVE:-$DEFAULT_ARCHIVE}"

if [ ! "$(ls -A $BORG_REPO)" ]; then
    borg init -v --show-rc --encryption=repokey
fi

if [ -n "${EXCLUDE:-}" ]; then
    OLD_IFS=$IFS
    IFS=';'

    EXCLUDE_BORG=''
    for i in $EXCLUDE; do
        EXCLUDE_BORG="${EXCLUDE_BORG} --exclude ${i}"
    done

    IFS=$OLD_IFS
else
    EXCLUDE_BORG=''
fi

borg create -v --stats --show-rc $EXCLUDE_BORG ::"$ARCHIVE" $BACKUP_DIRS

if [ -n "${PRUNE:-}" ]; then
    if [ -n "${PRUNE_PREFIX:-}" ]; then
        PRUNE_PREFIX="--prefix=${PRUNE_PREFIX}"
    else
        PRUNE_PREFIX=''
    fi
    if [ -z "${KEEP_DAILY:-}" ]; then
        KEEP_DAILY=7
    fi
    if [ -z "${KEEP_WEEKLY:-}" ]; then
        KEEP_WEEKLY=4
    fi
    if [ -z "${KEEP_MONTHLY:-}" ]; then
        KEEP_MONTHLY=6
    fi

    borg prune -v --stats --show-rc $PRUNE_PREFIX --keep-daily=$KEEP_DAILY --keep-weekly=$KEEP_WEEKLY --keep-monthly=$KEEP_MONTHLY
fi

borg check -v --show-rc
