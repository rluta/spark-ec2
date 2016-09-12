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

if [ ! -z "${ZEPPELIN_INTERPRETERS}" ]; then
  echo "Waiting for zeppelin to start..."
  sleep 20
  /root/spark-ec2/zeppelin/configure-interpreters.sh ${ZEPPELIN_INTERPRETERS}
fi

popd >/dev/null
