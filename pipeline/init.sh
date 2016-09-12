#!/bin/bash

pushd /root > /dev/null

if [ -d "pipeline" ]; then
  echo "Pipeline seems to be installed. Exiting."
  return 0
fi

archive=aldatalab_${SCALA_VERSION}-$PIPELINE_VERSION-${SPARK_VERSION}.tgz
aws s3 cp s3://$PIPELINE_BUCKET/binaries/$archive .
if [ $? != 0 ]; then
  echo "ERROR: Unknown Pipeline version"
  return -1
fi

echo "Unpacking Pipeline"
tar xvzf $archive > /tmp/spark-ec2_pipeline.log
rm $archive
mv `ls -d aldatalab*` pipeline

popd > /dev/null
