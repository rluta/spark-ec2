#!/bin/bash

pushd /root/zeppelin >/dev/null

mkdir -p /mnt/ephemeral-hdfs/s3
chmod 777 /mnt/ephemeral-hdfs/s3
sudo -u zeppelin bin/zeppelin-daemon.sh start
popd >/dev/null
