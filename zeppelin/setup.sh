#!/bin/bash

pushd /root/zeppelin >/dev/null

mkdir -p /mnt/ephemeral-hdfs/s3
chmod 777 /mnt/ephemeral-hdfs/s3
sudo -u zeppelin bin/zeppelin-daemon.sh restart

if [ -d /root/spark-ec2/zeppelin/conf ]
then
    cp spark-ec2/zeppelin/conf/* zeppelin/conf/
fi

if [ -d /root/spark-ec2/zeppelin/skel ]
then
    cp -f spark-ec2/zeppelin/skel/.??* zeppelin/
    cp -f spark-ec2/zeppelin/skel/.??* /root/
fi

if [ -d /root/zeppelin/conf/interpreters ]
then
    echo "Waiting for zeppelin to start..."
    for interpreter in zeppelin/interpreters
    do
        echo curl -s -XPOST --data-binary @${interpreter} http://localhost:8080/api/interpreter/setting
        curl -s -XPOST --data-binary @${interpreter} http://localhost:8080/api/interpreter/setting
    done
fi

popd >/dev/null
