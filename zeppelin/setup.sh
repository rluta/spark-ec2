#!/bin/bash

pushd /root/zeppelin >/dev/null

if [ -d /root/spark-ec2/zeppelin/conf ]
then
    cp /root/spark-ec2/zeppelin/conf/* zeppelin/conf/
fi

if [ -d /root/spark-ec2/zeppelin/skel ]
then
    cp -f /root/spark-ec2/zeppelin/skel/.??* zeppelin/
    cp -f /root/spark-ec2/zeppelin/skel/.??* /root/
fi


mkdir -p /mnt/ephemeral-hdfs/s3
chmod 777 /mnt/ephemeral-hdfs/s3
sudo -u zeppelin bin/zeppelin-daemon.sh restart

if [ -d /root/zeppelin/conf/interpreters ]
then
    echo "Waiting for zeppelin to start..."
    sleep 10
    for interpreter in /root/zeppelin/conf/interpreters
    do
        echo curl -s -XPOST --data-binary @${interpreter} http://localhost:8080/api/interpreter/setting
        curl -s -XPOST --data-binary @${interpreter} http://localhost:8080/api/interpreter/setting
    done
fi

popd >/dev/null
