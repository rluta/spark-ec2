#!/bin/bash

pushd /root > /dev/null

if [ -d "pipeline" ]; then
  echo "Pipeline seems to be installed. Exiting."
  return 0
fi

aws s3 cp s3://$PIPELINE_BUCKET/binaries/aldatalab-$PIPELINE_VERSION.tgz .
if [ $? != 0 ]; then
  echo "ERROR: Unknown Pipeline version"
  return -1
fi

echo "Unpacking Pipeline"
tar xvzf aldatalab-*.tgz > /tmp/spark-ec2_pipeline.log
rm aldatalab-*.tgz
mv `ls -d aldatalab-*` pipeline

popd > /dev/null
