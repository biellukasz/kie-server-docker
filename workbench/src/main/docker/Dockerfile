####### BASE ############
FROM jboss/wildfly:10.0.0.Final


####### MAINTAINER ############
MAINTAINER "Karel Suta" "ksuta@redhat.com"


####### ENVIRONMENT ############
ENV JAVA_OPTS -Xms256m -Xmx1024m -Djava.net.preferIPv4Stack=true
ENV JBOSS_BIND_ADDRESS 0.0.0.0
ENV SERVER_CONFIG standalone.xml


####### Drools KIE Workbench CUSTOM CONFIGURATION ############
ADD start_workbench.sh $JBOSS_HOME/bin/start_workbench.sh
ADD deployable/jbpm-workbench.war $JBOSS_HOME/standalone/deployments/jbpm-workbench.war
RUN touch $JBOSS_HOME/standalone/deployments/jbpm-workbench.war.dodeploy


####### ADD LOGIN MODULE ############
ADD add-login-module.cli /tmp/add-login-module.cli
RUN $JBOSS_HOME/bin/jboss-cli.sh --file=/tmp/add-login-module.cli


####### ADD USERS TO WILDFLY ############
RUN $JBOSS_HOME/bin/add-user.sh -u john -p john -g admin,kie-server,engineering -a -s
RUN $JBOSS_HOME/bin/add-user.sh -u mary -p mary -g admin,kie-server,HR -a -s


###### SWITCH USER root ######
USER root


###### CHANGE FILE PROPERTIES ######
RUN chmod +x $JBOSS_HOME/bin/start_workbench.sh
RUN chgrp -R 0 /opt/jboss
RUN chmod -R g+rw /opt/jboss
RUN find /opt/jboss -type d -exec chmod g+x {} +


####### CUSTOM JBOSS USER ############
# Switchback to jboss user
USER jboss


####### RUNNING KIE WORKBENCH ############
WORKDIR $JBOSS_HOME/bin/
CMD ["./start_workbench.sh"]
