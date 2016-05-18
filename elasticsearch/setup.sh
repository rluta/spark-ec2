#!/bin/bash

pushd /root/elasticsearch >/dev/null

/root/spark-ec2/copy-dir /root/elasticsearch

SLAVES=`cat /root/spark-ec2/slaves`

for slave in $SLAVES; do
    echo "Starting Elasticsearch $slave"
    ../spark-ec2/ssh-no-keychecking.sh $slave "useradd -r -U elasticsearch"
    ../spark-ec2/ssh-no-keychecking.sh $slave "chown -R elasticsearch /root/elasticsearch"
    ../spark-ec2/ssh-no-keychecking.sh -tt $slave "sudo -u elasticsearch -b /root/elasticsearch/bin/elasticsearch -d"
done

popd >/dev/null