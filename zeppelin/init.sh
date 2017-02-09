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
  if [ -d /root/zeppelin ]; then
    useradd -r ${GROUP_ADD} -d /root/zeppelin $USER
    cp /etc/skel/.??* /root/zeppelin
  else
    useradd -r ${GROUP_ADD} -d /root/zeppelin -m $USER
  fi
fi

# Github tag:
if [[ "$ZEPPELIN_VERSION" == *\|* ]]
then
  # Not yet supported
  echo "Zeppelin git hashes are not yet supported. Please specify a Zeppelin release version."
# Pre-package zeppelin version
else
  wget -O zeppelin-${ZEPPELIN_VERSION}-${SPARK_VERSION}.tar.gz http://apache.crihan.fr/dist/zeppelin/zeppelin-${ZEPPELIN_VERSION}/zeppelin-${ZEPPELIN_VERSION}-bin-all.tgz
  #wget https://fastdata-binaries.s3.amazonaws.com/zeppelin-${ZEPPELIN_VERSION}-${SPARK_VERSION}.tar.gz
  if [ $? != 0 ]; then
    echo "ERROR: Unknown Zeppelin version"
    return -1
  fi

  echo "Unpacking Zeppelin"
  tar xvzf zeppelin-*.tar.gz > /tmp/spark-ec2_zeppelin.log
  rm zeppelin-*.tar.gz
  if [ -d zeppelin/ ]
  then
    (cd zeppelin && tar cvf /tmp/zeppelin.tar .)
  fi 
  rm -rf zeppelin
  ln -sf $(ls -d zeppelin-*) zeppelin
  (cd zeppelin && tar xvf /tmp/zeppelin.tar)
  chmod 751 /root
  chown -R $USER zeppelin*
fi

popd > /dev/null
