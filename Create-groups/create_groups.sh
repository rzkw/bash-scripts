#!/bin/bash
#
#

while IFS=":" read group gid; do
	echo "Creating group with $group with GID of $gid";
	groupadd -g $gid $group;
done < groups.txt
