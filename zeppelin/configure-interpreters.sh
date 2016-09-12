#!/bin/bash

pushd /root/zeppelin >/dev/null

# Delete default spark interpreter settings
echo "Removing default spark interpreter"
sparkid=$(curl -s http://localhost:8080/api/interpreter/setting | jq -r '.body[]| select(.name == "spark") |.id')
curl -s -XDELETE http://localhost:8080/api/interpreter/setting/$sparkid

# Update based on provided configs
for interpreter in $*
do
    echo "Creating $interpreter"
    int_file="conf/interpreters/${interpreter}.json"
    if [ -f "$int_file" ]
    then
        curl -s -XPOST --data-binary @${int_file} http://localhost:8080/api/interpreter/setting
    else
       echo "Warning: ${int_file} does not exist, ignoring $interpreter"
    fi
done

popd >/dev/null