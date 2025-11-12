#!/bin/bash
#
# Backup script using rsync
#

# Date for log:
date=$(date +%d-%m-%Y)
time=$(date +%H-%M-%S)

# What to back up:
backup_dirs="/home /var/log /etc /root /opt"

# Where to backup to:
dest="/backup-sdb1"

# Check for available disk space before backup:
available_space=$(df "$dest" | awk '{print $4}')

if [ "$available_space" -lt 10485760 ]; then

    echo "Not enough disk space available on $dest. Backup aborted."
    exit 1

fi


if mountpoint -q $dest; then

    # Show status message if backup directory is mounted:

    echo "Backing up $backup_dirs to $dest using rsync"

    # Backup directories using rsync and write message to log file:

    rsync -auv --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/cdrom/*,/lost+found} "$backup_dirs" "$dest" | tee /var/log/backup-log_$time-$date.txt
    
    if [ $? -eq 0 ]; then

        echo "Backup complete $time $date"

    else

        echo "Backup error $time $date"

    fi

else

    # Show error if backup directory is not mounted:

    echo "$dest is not mounted. Backup failed."
    exit 1

fi 