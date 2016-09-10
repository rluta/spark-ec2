#!/bin/bash

USER="zeppelin"

pushd /root > /dev/null

if [ ! -z "$(getent group hadoop)" ]
then
    GROUP_ADD="-G hadoop"
else
    GROUP_ADD=""
fi

if [ -d "zeppelin/bin" ]; then
  echo "Zeppelin seems to be installed. Exiting."
  return 0
fi

if id $USER >/dev/null 2>&1; then
  echo "User $USER exists"
else
  echo "Creating $USER user"
  useradd -r ${GROUP_ADD} -m $USER
fi

# Github tag:
if [[ "$ZEPPELIN_VERSION" == *\|* ]]
then
  # Not yet supported
  echo "Zeppelin git hashes are not yet supported. Please specify a Zeppelin release version."
# Pre-package zeppelin version
else
  wget https://s3.amazonaws.com/gedatalab/binaries/zeppelin-$ZEPPELIN_VERSION.tar.gz
  if [ $? != 0 ]; then
    echo "ERROR: Unknown Zeppelin version"
    return -1
  fi

  echo "Unpacking Zeppelin"
  tar xvzf zeppelin-*.tar.gz > /tmp/spark-ec2_zeppelin.log
  rm zeppelin-*.tar.gz
  if [ -d zeppelin ]
  then
    mv zeppelin zeppelin.base
    ln -sf $(ls -d zeppelin-*) zeppelin
    cp -f zeppelin.base/conf/* zeppelin/conf
    rmdir zeppelin.base
  fi

  chmod 751 /root
  chown -R $USER zeppelin
fi

popd > /dev/null
