#!/bin/bash

for user in maryam adam jacob; do
	echo Password@1 | passwd --stdin $user;
done
