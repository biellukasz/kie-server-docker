#!/usr/bin/env bash


# If not server identifier set via docker env variable, use the container's hostname as server id.
if [ ! -n "$KIE_SERVER_ID" ]; then
    KIE_SERVER_ID=kie-server-$HOSTNAME
fi
echo "Using '$KIE_SERVER_ID' as KIE server identifier"


# If not public IP configured using the DOCKER_IP env, obtain the internal network address for this container.
if [ ! -n "$DOCKER_IP" ]; then
    # Obtain current container's IP address.
    DOCKER_IP=$(/sbin/ifconfig eth0 | grep 'inet' | cut -d: -f2 | awk '{ print $2}')

    # If ifconfig failed get IP address from hostname.
    if [ ! -n "$DOCKER_IP" ]; then
        DOCKER_IP=$HOSTNAME
    fi
fi
echo "Using '$DOCKER_IP' as KIE server IP address"


KIE_SERVER_LOCATION="http://$DOCKER_IP:$DOCKER_PORT/$KIE_SERVER_CONTEXT_PATH/services/rest/server"
echo "Using '$KIE_SERVER_LOCATION' as KIE server location"


# Default arguments for running the KIE Execution server.
JBOSS_ARGUMENTS=" -b 0.0.0.0 -Dorg.kie.server.id=$KIE_SERVER_ID -Dorg.kie.server.user=$KIE_SERVER_USER -Dorg.kie.server.pwd=$KIE_SERVER_PWD -Dorg.kie.server.location=$KIE_SERVER_LOCATION"


# Controller argument for the KIE Execution server. Only enabled if set the environment variable/s or detected container linking.
if [ -n "$KIE_SERVER_CONTROLLER" ]; then
    echo "Using '$KIE_SERVER_CONTROLLER' as KIE server controller"
    echo "Using '$KIE_MAVEN_REPO' for the kie-workbench Maven repository URL"
    JBOSS_ARGUMENTS="$JBOSS_ARGUMENTS -Dorg.kie.server.controller=$KIE_SERVER_CONTROLLER -Dorg.kie.server.controller.user=$KIE_SERVER_CONTROLLER_USER -Dorg.kie.server.controller.pwd=$KIE_SERVER_CONTROLLER_PWD"
fi


# If database host isn't defined try to load one from environment property.
if [ ! -n "$KIE_SERVER_DB_HOST" ]; then
    # Obtain hostname from default PostgreSQL environment variable
    KIE_SERVER_DB_HOST=$POSTGRESQL_SERVICE_HOST

    if [ ! -n "$KIE_SERVER_DB_HOST" ]; then
        echo "Database hostname isn't defined, persistence will not work."
    fi
fi
export KIE_SERVER_DB_HOST
echo "Using '$KIE_SERVER_DB_HOST' as database hostname."


# Database arguments for the KIE Execution server.
JBOSS_ARGUMENTS="$JBOSS_ARGUMENTS -Dorg.kie.server.persistence.dialect=org.hibernate.dialect.PostgreSQLDialect -Dorg.kie.server.persistence.ds=$KIE_SERVER_DB_JNDI"


# If Quartz should be used
if [ "$USE_QUARTZ" == "true" ]; then
    echo "Using '$JBOSS_HOME/quartz/quartz-definition.properties' as Quartz properties"
    JBOSS_ARGUMENTS="$JBOSS_ARGUMENTS -Dorg.quartz.properties=$JBOSS_HOME/quartz/quartz-definition.properties"
fi


# If Kie server router is configured then use it
if [ -n "$KIE_SERVER_ROUTER" ]; then
    echo "Using '$KIE_SERVER_ROUTER' as KIE server router"
    JBOSS_ARGUMENTS="$JBOSS_ARGUMENTS -Dorg.kie.server.router=$KIE_SERVER_ROUTER"
fi


echo "JBoss arguments '$JBOSS_ARGUMENTS' "

# Start Wildfly with the given arguments.
echo "Running KIE Execution Server on JBoss Wildfly..."

exec ./standalone.sh -c $SERVER_CONFIG $JBOSS_ARGUMENTS
exit $?