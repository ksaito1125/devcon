#! /bin/bash

USERNAME=$1

groupadd -g $(ls -n /var/run/docker.sock  | awk '{print $4}') docker
usermod -aG docker ksaito
chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}
exec tail -f /dev/null
