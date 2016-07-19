#!/bin/bash

mysqladmin create $HIVE_DB

mysql $HIVE_DB <<EOF
create user $HIVE_USER;
grant usaage on *.* to `$HIVE_USER`@`localhost` identified by '$HIVE_PASSWORD';
grant all to $HIVE_DB.* to `$HIVE_USER`@`localhost` identified by '$HIVE_PASSWORD';
flush privileges;
EOF

cd /root/hive/sql
mysql $HIVE_DB < hive-schema-1.2.0.mysql.sql