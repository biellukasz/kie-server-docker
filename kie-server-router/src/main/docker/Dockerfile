####### BASE ############
FROM jboss/base-jdk:8


####### MAINTAINER ############
MAINTAINER "Karel Suta" "ksuta@redhat.com"


####### ENVIRONMENT ############
ENV ROUTER_HOME=/opt/jboss \
    KIE_SERVER_ROUTER_REPO_DIR=/opt/jboss \
    ROUTER_HOSTNAME_EXTERNAL=http://localhost:9000/

# ENV KIE_SERVER_CONTROLLER
ENV KIE_SERVER_CONTROLLER_USER john
ENV KIE_SERVER_CONTROLLER_PWD john


####### EXPOSE ROUTER PORT ############
EXPOSE 9000


####### Kie server router CUSTOM CONFIGURATION ############
ADD deployable/kie-server-router.jar $ROUTER_HOME/kie-server-router.jar
ADD start_kie-server-router.sh $ROUTER_HOME/start_kie-server-router.sh


###### SWITCH USER root ######
USER root


###### CHANGE FILE PROPERTIES ######
RUN chmod +x $ROUTER_HOME/start_kie-server-router.sh
RUN chgrp -R 0 /opt/jboss
RUN chmod -R g+rw /opt/jboss
RUN find /opt/jboss -type d -exec chmod g+x {} +


####### CUSTOM JBOSS USER ############
# Switchback to jboss user
USER jboss


####### RUNNING Kie server router ############
WORKDIR $ROUTER_HOME
CMD ["./start_kie-server-router.sh"]
