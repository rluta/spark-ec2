#!/bin/bash

service mysqld start
if mysqladmin create $HIVE_DB 2>/dev/null
then
    mysql $HIVE_DB <<EOF
create user $HIVE_USER;
grant usaage on *.* to $HIVE_USER@localhost identified by '$HIVE_PASSWORD';
grant all to $HIVE_DB.* to $HIVE_USER@localhost identified by '$HIVE_PASSWORD';
flush privileges;
EOF

    cd /root/hive/sql
    mysql $HIVE_DB < hive-schema-1.2.0.mysql.sql
else
    echo "Mysql DB $HIVE_DB already exists, skipping setup"
fi