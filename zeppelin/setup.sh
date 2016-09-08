#!/bin/bash

pushd /root/zeppelin >/dev/null

mkdir -p /mnt/ephemeral-hdfs/s3
chmod 777 /mnt/ephemeral-hdfs/s3
sudo -u zeppelin bin/zeppelin-daemon.sh restart

if [ -d spark-ec2/zeppelin/conf ]
then
    mv spark-ec2/zeppelin/conf/* zeppelin/conf/
fi

if [ -d zeppelin/interpreters ]
then
    for interpreter in zeppelin/interpreters
    do
        curl -s -XPOST --data-binary @$interpreter http://localhost:8080/api/interpreter/setting
    done
fi

popd >/dev/null
