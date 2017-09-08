#!/bin/bash
sudo /sbin/sshd -D &
trap 'kill -TERM $PID' TERM INT
if [[ -z "$@" || "$@" == "/bin/bash" ]]; then
    /bin/bash
else
    $@
fi
PID=$!
wait $PID
trap - TERM INT
wait $PID
