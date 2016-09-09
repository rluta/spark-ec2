#!/bin/bash

ROOT_DIR=${ROOT_DIR:-/root}
HDFS_DIR=${ROOT_DIR}/hdfs

USER=hadoop

pushd $ROOT_DIR > /dev/null

if id $USER >/dev/null 2>&1; then
  echo "User $USER exists"
else
  echo "Creating $USER user"
  useradd -r -m $USER
fi

if [ -d "hdfs" ]; then
  echo "HDFS seems to be installed. Exiting."
  return 0
fi

wget http://s3.amazonaws.com/spark-related-packages/hadoop-2.4.0.tar.gz
echo "Unpacking Hadoop"
tar xvzf hadoop-*.tar.gz > /tmp/spark-ec2_hadoop.log
rm hadoop-*.tar.gz
mv hadoop-2.4.0/ hdfs/

# Have single conf dir
rm -rf $ROOT_DIR/hdfs/etc/hadoop/
ln -s $ROOT_DIR/hdfs/conf $ROOT_DIR/hdfs/etc/hadoop

/root/spark-ec2/copy-dir $ROOT_DIR/hdfs

popd > /dev/null
