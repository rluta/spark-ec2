#!/bin/bash

ROOT_DIR=${ROOT_DIR:-/root}
HDFS_DIR=${ROOT_DIR}/hdfs

# Set hdfs url to make it easier
HDFS_URL="hdfs://$PUBLIC_DNS:9000"
echo "export HDFS_URL=$HDFS_URL" >> ~/.bash_profile

pushd /root/spark-ec2/hdfs > /dev/null
source ./setup-slave.sh

for node in $SLAVES $OTHER_MASTERS; do
  echo $node
  ssh -t -t $SSH_OPTS root@$node "/root/spark-ec2/hdfs/setup-slave.sh" & sleep 0.3
done
wait

/root/spark-ec2/copy-dir ${HDFS_DIR}/conf

NAMENODE_DIR=/mnt/hdfs/dfs/name

if [ -f "$NAMENODE_DIR/current/VERSION" ]; then
  echo "Hadoop namenode appears to be formatted: skipping"
else
  echo "Formatting ephemeral HDFS namenode..."
  ${HDFS_DIR)/bin/hadoop namenode -format
fi

echo "Starting ephemeral HDFS..."

# Start HDFS
${HDFS_DIR}/sbin/start-dfs.sh

if [ ! -z "${USE_YARN}" ]; then
    echo "Starting YARN"
    ${HDFS_DIR}/sbin/start-yarn.sh
fi

popd > /dev/null
