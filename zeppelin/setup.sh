#!/bin/bash

pushd /root/zeppelin >/dev/null
USER=$(cat .user)
su -s /bin/bash $USER -c 'bin/zeppelin-daemon.sh start'
popd >/dev/null
