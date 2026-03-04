#!/bin/bash
for i in $(seq 1 254); do
    if ping -c 1 -W 1 192.168.1.$i > /dev/null 2>&1; then
        echo "192.168.1.$i is up"
    fi
done
