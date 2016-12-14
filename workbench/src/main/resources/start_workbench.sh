#!/usr/bin/env bash

# Start Wildfly with the given arguments.
echo "Running KIE Workbench on JBoss Wildfly..."

exec ./standalone.sh -c $SERVER_CONFIG -b $JBOSS_BIND_ADDRESS
exit $?