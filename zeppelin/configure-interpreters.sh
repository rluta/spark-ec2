#!/bin/bash

pushd /root/zeppelin >/dev/null

# Update based on provided configs
for interpreter in $*
do
    id=$(curl -s http://localhost:8080/api/interpreter/setting | jq -r ".body[]| select(.name == '$interpreter') |.id")
    if [ ! -z "$id" ]; then
        echo "Removing previous interpreter $interpreter ($id)"
        curl -s -XDELETE http://localhost:8080/api/interpreter/setting/$sparkid
    fi

    echo "Creating new $interpreter"
    int_file="conf/interpreters/${interpreter}.json"
    if [ -f "$int_file" ]
    then
        curl -s -XPOST --data-binary @${int_file} http://localhost:8080/api/interpreter/setting
    else
       echo "Warning: ${int_file} does not exist, ignoring $interpreter"
    fi
done

popd >/dev/null