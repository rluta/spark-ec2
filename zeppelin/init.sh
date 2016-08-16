#!/bin/bash

USER="zeppelin"
GROUP="hadoop"
pushd /root > /dev/null

if [ -d "zeppelin" ]; then
  echo "Zeppelin seems to be installed. Exiting."
  return 0
fi

if id $USER >/dev/null 2>&1; then
  echo "User $USER exists"
  if id $USER | grep $GROUP >/dev/null; then
     echo "User $USER belongs to group $GROUP"
  else
     echo "Adding $USER to group $GROUP"
     usermod -a -G $GROUP
  fi
else
  echo "Creating $USER user"
  useradd -r -G $GROUP -d /root/$USER -m $USER
fi

# Github tag:
if [[ "$ZEPPELIN_VERSION" == *\|* ]]
then
  # Not yet supported
  echo "Zeppelin git hashes are not yet supported. Please specify a Zeppelin release version."
# Pre-package zeppelin version
else
  case "$ZEPPELIN_VERSION" in
    0.5.5)
      wget https://s3.amazonaws.com/gedatalab/binaries/zeppelin-0.5.5.tar.gz
      ;;
    *)
      wget https://s3.amazonaws.com/gedatalab/binaries/zeppelin-$ZEPPELIN_VERSION.tar.gz
      if [ $? != 0 ]; then
        echo "ERROR: Unknown Zeppelin version"
        return -1
      fi
  esac

  echo "Unpacking Zeppelin"
  tar xvzf zeppelin-*.tar.gz > /tmp/spark-ec2_zeppelin.log
  rm zeppelin-*.tar.gz
  mv `ls -d zeppelin-*` zeppelin

  chown -R $USER zeppelin


fi

popd > /dev/null
