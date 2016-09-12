#!/bin/bash

ROOT_DIR=${ROOT_DIR:-/root}
HDFS_DIR=${ROOT_DIR}/hdfs

echo "Starting YARN"
${HDFS_DIR}/sbin/start-yarn.sh