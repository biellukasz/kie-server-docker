####### BASE ############
FROM jboss/wildfly:10.0.0.Final


####### MAINTAINER ############
MAINTAINER "Karel Suta" "ksuta@redhat.com"


####### ENVIRONMENT ############
ENV JAVA_OPTS -Xms256m -Xmx1024m -Djava.net.preferIPv4Stack=true
ENV JBOSS_BIND_ADDRESS 0.0.0.0
ENV SERVER_CONFIG standalone-full.xml
# ENV DOCKER_IP retrieved from pod IP or hostname
ENV DOCKER_PORT 8080

# ENV KIE_SERVER_ID kie-server
ENV KIE_SERVER_CONTEXT_PATH kie-server
ENV KIE_SERVER_USER kieserver
ENV KIE_SERVER_PWD kieserver1!

# ENV KIE_MAVEN_REPO
ENV KIE_MAVEN_REPO_USER john
ENV KIE_MAVEN_REPO_PASSWORD john

# ENV KIE_SERVER_CONTROLLER
ENV KIE_SERVER_CONTROLLER_USER john
ENV KIE_SERVER_CONTROLLER_PWD john

ENV POSTGRESQL_USER userPostgre
ENV POSTGRESQL_PASSWORD kvqkMKFxeTgiEqvC
ENV POSTGRESQL_DATABASE sampledb
ENV POSTGRESQL_JNDI java:jboss/datasources/PostgreDS
# ENV POSTGRESQL_SERVICE_HOST taken from postgre DB pod
# ENV POSTGRESQL_SERVICE_PORT taken from postgre DB pod


####### Drools KIE Server CUSTOM CONFIGURATION ############
RUN mkdir -p $HOME/.m2
ADD settings.xml $JBOSS_HOME/../.m2/settings.xml
ADD start_kie-server.sh $JBOSS_HOME/bin/start_kie-server.sh
ADD application-users.properties $JBOSS_HOME/standalone/configuration/application-users.properties
ADD application-roles.properties $JBOSS_HOME/standalone/configuration/application-roles.properties
ADD deployable/kie-server.war $JBOSS_HOME/standalone/deployments/kie-server.war
RUN touch $JBOSS_HOME/standalone/deployments/kie-server.war.dodeploy


####### INSTALL DATABASE DRIVER ############
ADD deployable/postgresql.jar /tmp/postgresql-driver.jar
ADD add-database.cli /tmp/add-database.cli
RUN $JBOSS_HOME/bin/jboss-cli.sh --file=/tmp/add-database.cli


###### SWITCH USER root ######
USER root


###### INSTALL PACKAGES ######
RUN yum install -y net-tools


###### CHANGE FILE PROPERTIES ######
RUN chmod +x $JBOSS_HOME/bin/start_kie-server.sh


####### CUSTOM JBOSS USER ############
# Switchback to jboss user
USER jboss


####### RUNNING KIE SERVER ############
WORKDIR $JBOSS_HOME/bin/
CMD ["./start_kie-server.sh"]
