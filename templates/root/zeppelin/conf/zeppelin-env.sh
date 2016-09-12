#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

export MASTER=$(cat /root/spark-ec2/cluster-url)
# export ZEPPELIN_JAVA_OPTS      		# Additional jvm options. for example, export ZEPPELIN_JAVA_OPTS="-Dspark.executor.memory=8g -Dspark.cores.max=16"
# export ZEPPELIN_MEM            		# Zeppelin jvm mem options Default -Xmx1024m -XX:MaxPermSize=512m
# export ZEPPELIN_INTP_MEM       		# zeppelin interpreter process jvm mem options. Default = ZEPPELIN_MEM
# export ZEPPELIN_INTP_JAVA_OPTS 		# zeppelin interpreter process jvm options. Default = ZEPPELIN_JAVA_OPTS

# export ZEPPELIN_LOG_DIR        		# Where log files are stored.  PWD by default.
# export ZEPPELIN_PID_DIR        		# The pid files are stored. /tmp by default.
# export ZEPPELIN_WAR_TEMPDIR    		# The location of jetty temporary directory.
# export ZEPPELIN_NOTEBOOK_DIR   		# Where notebook saved
# export ZEPPELIN_NOTEBOOK_HOMESCREEN		# Id of notebook to be displayed in homescreen. ex) 2A94M5J1Z
# export ZEPPELIN_NOTEBOOK_HOMESCREEN_HIDE	# hide homescreen notebook from list when this value set to "true". default "false"
# export ZEPPELIN_NOTEBOOK_S3_BUCKET    # Bucket where notebook saved
# export ZEPPELIN_NOTEBOOK_S3_USER      # User in bucket where notebook saved. For example bucket/user/notebook/2A94M5J1Z/note.json
# export ZEPPELIN_IDENT_STRING   		# A string representing this instance of zeppelin. $USER by default.
# export ZEPPELIN_NICENESS       		# The scheduling priority for daemons. Defaults to 0.

#### Spark interpreter configuration ####

## Use provided spark installation ##
## defining SPARK_HOME makes Zeppelin run spark interpreter process using spark-submit
##
export SPARK_HOME=/root/spark
