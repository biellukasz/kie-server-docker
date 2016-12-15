####### BASE ############
FROM jboss/base-jdk:8


####### MAINTAINER ############
MAINTAINER "Karel Suta" "ksuta@redhat.com"


####### ENVIRONMENT ############
ENV ROUTER_HOME=/opt/jboss \
    KIE_SERVER_ROUTER_REPO_DIR=/opt/jboss \
    ROUTER_HOSTNAME_EXTERNAL=http://localhost:9000/


####### EXPOSE ROUTER PORT ############
EXPOSE 9000


####### Drools KIE Workbench CUSTOM CONFIGURATION ############
ADD deployable/kie-server-router.jar $ROUTER_HOME/kie-server-router.jar


####### RUNNING KIE WORKBENCH ############
WORKDIR $ROUTER_HOME
CMD [ "sh", "-c", "java -jar -Dorg.kie.server.router.host=$HOSTNAME -Dorg.kie.server.router.port=9000 -Dorg.kie.server.router.repo=$KIE_SERVER_ROUTER_REPO_DIR -Dorg.kie.server.router.url.external=$ROUTER_HOSTNAME_EXTERNAL $ROUTER_HOME/kie-server-router.jar" ]
