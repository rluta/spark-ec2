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

if [ ! -z "${ZEPPELIN_INTERPRETERS}" ]
then
    echo "Waiting for zeppelin to start..."
    sleep 10

    # Delete default spark interpreter settings
    echo "Removing default spark interpreter"
    sparkid=$(curl -s http://localhost:8080/api/interpreter/setting | jq -r '.body[]| select(.name == "spark") |.id')
    curl -s -XDELETE http://localhost:8080/api/interpreter/setting/$sparkid

    # Update based on provided configs
    for interpreter in ${ZEPPELIN_INTERPRETERS}
    do
        echo "Creating $interpreter"
        int_file="conf/interpreters/${interpreter}.json"
        if [ -f "$int_file" ]
        then
            curl -s -XPOST --data-binary @${int_file} http://localhost:8080/api/interpreter/setting
        else
           echo "Warning: ${int_file} does not exist, ignoring $interpreter"
        fi
    done
fi


popd >/dev/null
