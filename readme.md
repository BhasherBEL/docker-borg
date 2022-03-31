# Borg Docker Alpine

Alpine-based Docker image that runs a `borg` backup on a daily basis using `cron`. The backups can be pruned based on the configuration. The official BorgBackup documentation is available [here](https://borgbackup.readthedocs.io/en/stable/). 

## Docker run

The image can be run with:

```sh
docker run \
	--name borg
	-e BORG_REPO=/borg/repo
	-e BORG_PASSPHRASE=very-secure-password
	-e BACKUP_DIRS=/borg/data
	-e PRUNE=1									# Optional
	-e KEEP_DAILY=7								# Optional
	-e KEEP_WEEKLY=4							# Optional
	-e KEEP_MONTHLY=12							# Optional
	-v my-backup-repo:/borg/repo:rw
	-v /home:/borg/data:ro
	bhasherbel/borg
```

## Docker-compose

It is also possible to run it with `docker-compose`. Here is an example of configuration:

```sh
version: '3'
services:
  borg:
    image: bhasherbel/borg:latest
    container_name: borg
    environment:
      - BORG_REPO=/borg/repo
      - BACKUP_DIRS=/borg/data
      - BORG_PASSPHRASE=very-secure-password
      - PRUNE=1									# Optional
      - KEEP_DAILY=7							# Optional
      - KEEP_WEEKLY=4							# Optional
      - KEEP_MONTHLY=12							# Optional
    volumes:
      - my-backup-repo:/borg/repo:rw
      - /home:/borg/data:ro
```
