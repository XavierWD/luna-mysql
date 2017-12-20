#!/bin/bash

base_dir=$(dirname $0)/..

# Which java to use
if [ -z "$JAVA_HOME" ]; then
  JAVA="java"
else
  JAVA="$JAVA_HOME/bin/java"                                                                                                                      
fi

if [ -z "$LUNA_MYSQL_JVM_PERFORMANCE_OPTS" ]; then
  LUNA_MYSQL_JVM_PERFORMANCE_OPTS="-server -XX:+UseG1GC -XX:MaxGCPauseMillis=20 -XX:InitiatingHeapOccupancyPercent=35"
fi

if [ -z "$LUNA_MYSQL_HEAP_OPTS" ]; then
  LUNA_MYSQL_HEAP_OPTS="-Xmx1G -Xms1G"
fi

while [ $# -gt 0 ]; do
  COMMAND=$1
  case $COMMAND in
    -daemon)
      DAEMON_MODE="true"                                                                                                                          
      shift
      ;;
    *)
      break
      ;;
  esac
done

target_dir="$base_dir/target"
CLASSPATH="$CLASSPATH:$target_dir/luna-0.0.1.jar"

if [ "x$DAEMON_MODE" = "xtrue" ]; then
  nohup $JAVA $LUNA_MYSQL_JVM_PERFORMANCE_OPTS $LUNA_MYSQL_HEAP_OPTS -cp $CLASSPATH luna.LunaMysql "$@" >/etc/null 2>&1 &
else
  exec $JAVA $LUNA_MYSQL_JVM_PERFORMANCE_OPTS $LUNA_MYSQL_HEAP_OPTS -cp $CLASSPATH luna.LunaMysql "$@"
fi
