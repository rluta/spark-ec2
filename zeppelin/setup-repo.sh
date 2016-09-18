#!/bin/bash

pushd /root >/dev/null

if [[ "${ZEPPELIN_MODE}" != "git" ]]
then
    echo "No git repo to set up, exiting"
    exit 0
fi

if [ ! -z "${ZEPPELIN_GIT_ORIGIN}" ]; then
    git clone ${ZEPPELIN_GIT_ORIGIN} notebook
    chown -R zeppelin /root/notebook
else
    echo "Error: ZEPPELIN_GIT_ORIGIN not defined"
    exit 1
fi

cp  /root/spark-ec2/zeppelin/hooks/* /root/notebook/.git/hooks/
chmod 755 /root/notebook/.git/hooks/*

cp -r /root/spark-ec2/zeppelin/cron/* /usr/local/bin/
cp /root/spark-ec2/zeppelin/zeppelin /etc/cron.d/
killall -1 cron

popd >/dev/null