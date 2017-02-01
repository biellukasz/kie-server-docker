####### BASE ############
FROM jboss/wildfly:10.0.0.Final


####### MAINTAINER ############
MAINTAINER "Karel Suta" "ksuta@redhat.com"


####### ENVIRONMENT ############
ENV JAVA_OPTS -Xms256m -Xmx768m -Djava.net.preferIPv4Stack=true
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

# ENV KIE_SERVER_DB_USER PostgreSQL database user name
# ENV KIE_SERVER_DB_PASSWORD PostgreSQL database user password
ENV KIE_SERVER_DB_NAME sampledb
ENV KIE_SERVER_DB_JNDI java:jboss/datasources/PostgreDS
# ENV KIE_SERVER_DB_HOST host IP for PostgreSQL DB
ENV KIE_SERVER_DB_PORT 5432

# ENV KIE_SERVER_ROUTER

ENV USE_QUARTZ false


####### Drools KIE Server CUSTOM CONFIGURATION ############
RUN mkdir -p /opt/jboss/.m2
ADD settings.xml /opt/jboss/.m2/settings.xml
ADD start_kie-server.sh $JBOSS_HOME/bin/start_kie-server.sh
ADD deployable/kie-server.war $JBOSS_HOME/standalone/deployments/kie-server.war
RUN touch $JBOSS_HOME/standalone/deployments/kie-server.war.dodeploy


####### INSTALL DATABASE DRIVER ############
ADD deployable/postgresql.jar /tmp/postgresql-driver.jar
ADD add-database.cli /tmp/add-database.cli
RUN $JBOSS_HOME/bin/jboss-cli.sh --file=/tmp/add-database.cli

ADD quartz-definition.properties $JBOSS_HOME/quartz/quartz-definition.properties


####### ADD USERS TO WILDFLY ############
RUN $JBOSS_HOME/bin/add-user.sh -u john -p john -g admin,kie-server,engineering -a -s
RUN $JBOSS_HOME/bin/add-user.sh -u mary -p mary -g admin,kie-server,HR -a -s
RUN $JBOSS_HOME/bin/add-user.sh -u kieserver -p kieserver1! -g kie-server -a -s


###### SWITCH USER root ######
USER root


###### INSTALL PACKAGES ######
RUN yum install -y net-tools


###### CHANGE FILE PROPERTIES ######
RUN chmod +x $JBOSS_HOME/bin/start_kie-server.sh
RUN chgrp -R 0 /opt/jboss
RUN chmod -R g+rw /opt/jboss
RUN find /opt/jboss -type d -exec chmod g+x {} +


####### CUSTOM JBOSS USER ############
# Switchback to jboss user
USER jboss


####### RUNNING KIE SERVER ############
WORKDIR $JBOSS_HOME/bin/
CMD ["./start_kie-server.sh"]
