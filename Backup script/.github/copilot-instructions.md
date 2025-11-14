## Purpose

Help an AI coding agent be productive in this repository: a tiny shell-based backup utility for a homelab/server that relies on rsync and locally-mounted backup storage.

## Quick repo summary

- This repo contains a single primary script: `backup-rsync.sh` and a short `Instructions.md` with basic run notes.
- The script is intended to run on a Linux server (requires root to read `/root` and `/var/log` and to write logs to `/var/log`).

## Key files

- `backup-rsync.sh` — the backup script (source of truth). Look here for variables, rsync flags, and the logging behavior.
- `Instructions.md` — basic run instructions: `chmod +x backup-rsync.sh` then `./backup-rsync.sh` and links to rsync docs.

## Important patterns & conventions (from `backup-rsync.sh`)

- Variable naming: `date` and `time` are computed at the top and used to build the log filename: `/var/log/backup-log_$time-$date.txt`.
- `backup_dirs` is a quoted, space-separated string of directories to back up (example: "/home /var/log /etc /root /opt"). Preserve the quoting when editing.
- Destination path is `dest="/backup"`. The script expects `dest` to be a mounted filesystem — it uses `mountpoint -q $dest` and will abort if not mounted.
- Disk-space check: `available_space=$(df "$dest" | awk 'NR == 2{print $4}')` — this yields 1K-block units. The script compares against `10485760` (10 * 1024 * 1024 ≈ 10GB in KB). Keep that unit in mind when changing thresholds.
- rsync invocation: `rsync -auv --exclude={...} "${backup_dirs}" "${dest}" | tee /var/log/backup-log_$time-$date.txt`
  - Flags: `-a` (archive), `-u` (skip files newer on receiver), `-v` (verbose). When testing locally, use `-n` for dry-run (e.g., `-avn`).
  - Excludes: several `/dev`, `/proc`, `/sys`, `/tmp`, `/run`, `/mnt`, `/media`, `/cdrom`, `/lost+found` entries are excluded using a brace-list.

## Run & test guidance (concrete)

- To run (from `Instructions.md`):

  chmod +x backup-rsync.sh
  ./backup-rsync.sh

- For safe testing / debugging:
  - Dry-run: edit `dest` to a local temporary directory you control and run `rsync -avn` (add `-n` to `rsync` flags). Example: change `dest="/tmp/test-backup"` then run the script.
  - Verbose debugging: run `bash -x ./backup-rsync.sh` to trace execution and variable values.

## What an AI agent should and should not change

- Should: make small, contained improvements — parameterize `dest` or `backup_dirs` (via ENV or CLI args), add a `--dry-run` mode, or add error messages with more detail. When changing logging, preserve the current `time-date` naming scheme unless you update all references.
- Should not: silently change permissions, the rsync exclude list, or remove the mount check — these are intentional safety measures. Don't assume a different unit for `available_space` (it's 1K-blocks from `df`).

## Examples to reference when making edits

- To change the low-space threshold, update the literal `10485760` (currently ~10GB in 1K blocks) and keep a comment explaining the unit.
- To add an exclude, extend the brace list after `--exclude=` in the existing `rsync` command so the style remains consistent.

## Environment & privileges

- Script expects to run as root (reads `/root`, writes to `/var/log`, and writes to `dest`). If modifying paths, note permission implications.

## Notes and small follow-ups you can implement

- Consider parameterizing `backup-rsync.sh` with CLI flags or env vars (e.g., `DEST`, `DRY_RUN`) — but document clearly and keep backward compatibility.
- Add a `--check` or `--health` mode (only verify mount and space) so a scheduler can run it without attempting a full backup.

If anything in this file is unclear or you'd like more detail about a particular area (dry-run examples, a suggested CLI flag layout, or safety tests), tell me which part to expand.
