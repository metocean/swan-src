#!/bin/bash

if [ "$START_SSH_SERVER" -eq 1 ]; then
    if [ ! "$SSH_SERVER_PORT" -eq 22 ]; then
        sudo -E sed -i -r "s/#Port 22/Port $SSH_SERVER_PORT/g" /etc/ssh/sshd_config
        sudo -E /bin/sh -c 'echo "    Port $SSH_SERVER_PORT" >> /etc/ssh/ssh_config'
    fi
    echo "Starting SSH server at port ${SSH_SERVER_PORT-22}..."
    sudo /sbin/sshd -D &
fi

exec "$@"