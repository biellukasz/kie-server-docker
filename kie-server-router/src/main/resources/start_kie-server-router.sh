#!/usr/bin/env bash


# Default arguments for running the KIE Execution server.
ROUTER_ARGUMENTS="-Dorg.kie.server.router.host=$HOSTNAME -Dorg.kie.server.router.port=9000 -Dorg.kie.server.router.repo=$KIE_SERVER_ROUTER_REPO_DIR -Dorg.kie.server.router.url.external=$ROUTER_HOSTNAME_EXTERNAL"


# Controller argument for the KIE Server router. Only enabled if set the environment variable/s or detected container linking.
if [ -n "$KIE_SERVER_CONTROLLER" ]; then
    echo "Using '$KIE_SERVER_CONTROLLER' as KIE server controller"
    ROUTER_ARGUMENTS="$ROUTER_ARGUMENTS -Dorg.kie.server.controller=$KIE_SERVER_CONTROLLER -Dorg.kie.server.controller.user=$KIE_SERVER_CONTROLLER_USER -Dorg.kie.server.controller.pwd=$KIE_SERVER_CONTROLLER_PWD"
fi


echo "Router arguments '$ROUTER_ARGUMENTS' "


exec java -jar $ROUTER_ARGUMENTS $ROUTER_HOME/kie-server-router.jar
exit $?