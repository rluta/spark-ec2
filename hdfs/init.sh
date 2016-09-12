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

case ${HADOOP_MAJOR_VERSION} in
  2.7)
    version="2.7.3"
  ;;
  *)
    version="2.4.1"
  ;;
esac

wget https://s3.amazonaws.com/gedatalab/binaries/hadoop-${version}.tar.gz
echo "Unpacking Hadoop"
tar xvzf hadoop-*.tar.gz > /tmp/spark-ec2_hadoop.log
rm hadoop-*.tar.gz
mv hadoop-${version} hdfs
mv hadoop-native-${version} hadoop-native

# Have single conf dir
rm -rf $ROOT_DIR/hdfs/etc/hadoop/
ln -s $ROOT_DIR/hdfs/conf $ROOT_DIR/hdfs/etc/hadoop

/root/spark-ec2/copy-dir $ROOT_DIR/hdfs

popd > /dev/null
