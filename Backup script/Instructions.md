Script to back up homelab server to locally mounted external storage. Script uses if loop to check whether storage is mounted before backing up selected directories to storage. If storage is missing script exits with an error message. 

To make executable:

```
chmod +x backup-rsync.sh
```

To run script:

```
./backup-rsync.sh
```

Debugged using Claude and Copilot.

Links and resources:

[How to back up using shell scripts](https://documentation.ubuntu.com/server/how-to/backups/back-up-using-shell-scripts/)

[Sysadmin tools: Using rsync to manage backup, restore, and file synchronization ](https://www.redhat.com/en/blog/rsync-synchronize-backup-restore)

[How to Back Up and Restore Your Linux System Using the Rsync Utility](https://jumpcloud.com/blog/how-to-backup-linux-system-rsync)