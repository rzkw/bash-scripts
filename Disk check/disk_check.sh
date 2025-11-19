#!/bin/bash
#Script takes one argument to represent percentage threshold
#

#Check if argument was provided

if [ -z "$1" ]; then
        echo "Usage: disk_check.sh <threshold>"
        exit 1

else
        disk_usage="$(df -h / | awk 'NR==2 { print $5 }' | sed 's/%//g')"
        if (( $disk_usage >= $1 )); then
                echo "WARNING Disk usage is at ${disk_usage}% - threshold exceeded"
        elif (( $disk_usage < $1 )); then
                echo "OK: Disk usage is at ${disk_usage}% - within normal range"
        fi
fi
