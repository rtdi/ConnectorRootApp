FROM tomcat:10

LABEL maintainer="info@rtdi.io"

ADD https://raw.githubusercontent.com/rtdi/ConnectorRootApp/master/docker/server.xml conf/server.xml
ADD https://raw.githubusercontent.com/rtdi/ConnectorRootApp/master/docker/tomcat-users-orig.xml conf/
ADD https://github.com/SAP/openui5/releases/download/1.120.20/openui5-runtime-1.120.20.zip ./webapps/openui5.war
ADD https://raw.githubusercontent.com/rtdi/ConnectorRootApp/master/docker/context.xml conf/
ADD https://github.com/rtdi/ConnectorRootApp/releases/download/latest/ROOT.war ./webapps/

ADD https://raw.githubusercontent.com/rtdi/ConnectorRootApp/master/docker/appcontainer.sh bin/
RUN chmod +x bin/appcontainer.sh

EXPOSE 8080
EXPOSE 8443


CMD [ "appcontainer.sh" ]
