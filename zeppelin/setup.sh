#!/bin/bash

pushd /root/zeppelin >/dev/null

if [ -d /root/spark-ec2/zeppelin/conf ]
then
    cp -f /root/spark-ec2/zeppelin/conf/* conf/
fi

mkdir -p /mnt/hdfs/s3
chmod 777 /mnt/hdfs/s3
chown -R zeppelin .

sudo -u zeppelin bin/zeppelin-daemon.sh restart

if [ -d conf/interpreters ]
then
    echo "Waiting for zeppelin to start..."
    sleep 10
    for interpreter in conf/interpreters
    do
        echo curl -s -XPOST --data-binary @${interpreter} http://localhost:8080/api/interpreter/setting
        curl -s -XPOST --data-binary @${interpreter} http://localhost:8080/api/interpreter/setting
    done
fi


popd >/dev/null
