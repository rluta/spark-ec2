#!/bin/bash

ES_VERSION="2.3.2"
pushd /root > /dev/null

if [ -d "elasticsearch" ]; then
  echo "Elasticsearch seems to be installed. Exiting."
  return 0
fi

echo "Unpacking Elasticsearch"
useradd -r -U elasticsearch
wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${ES_VERSION}/elasticsearch-${ES_VERSION}.tar.gz
tar xvzf elasticsearch-*.tar.gz > /tmp/spark-ec2_es.log
rm elasticsearch-*.tar.gz
mv `ls -d elasticsearch-* | grep -v ec2` elasticsearch

./elasticsearch/bin/plugin install mobz/elasticsearch-head
yes | ./elasticsearch/bin/plugin install cloud-aws

chown -R elasticsearch elasticsearch

popd > /dev/null
