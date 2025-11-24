#!/bin/bash
#Script accepts multiple filenames as arguments
#
#

if [ -z "$1" ]; then
        echo "Usage: log_analyzer.sh file1 file2 ..."
        exit 1
fi

for FILE in "$@"; do
        if [ -r "$FILE" ]; then
                error_count=$(grep -i "error" $FILE | wc -l)
                echo "File: $FILE - Error count: $error_count"
        else
                echo "File: $FILE - Not accessible"
        fi
done
