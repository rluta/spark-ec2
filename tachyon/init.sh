#!/bin/bash

pushd /root > /dev/null

if [ -d "tachyon" ]; then
  echo "Tachyon seems to be installed. Exiting."
  return 0
fi

# Github tag:
if [[ "$TACHYON_VERSION" == *\|* ]]
then
  # Not yet supported
  echo "Tachyon git hashes are not yet supported. Please specify a Tachyon release version."
# Pre-package tachyon version
else
  case "$TACHYON_VERSION" in
    *)
     wget https://s3.amazonaws.com/gedatalab/binaries/tachyon-$TACHYON_VERSION-bin.tar.gz
      if [ $? != 0 ]; then
        echo "ERROR: Unknown Tachyon version"
        return -1
      fi
  esac

  echo "Unpacking Tachyon"
  tar xvzf tachyon-*.tar.gz > /tmp/spark-ec2_tachyon.log
  rm tachyon-*.tar.gz
  mv `ls -d tachyon-*` tachyon
fi

popd > /dev/null
