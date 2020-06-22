FROM tomcat:9-jdk14-openjdk-oracle

LABEL maintainer="info@rtdi.io"

ADD https://raw.githubusercontent.com/rtdi/ConnectorRootApp/master/docker/server.xml conf/server.xml
ADD https://raw.githubusercontent.com/rtdi/ConnectorRootApp/master/docker/localhost-rsa-cert.pem conf/security/ssl/
ADD https://raw.githubusercontent.com/rtdi/ConnectorRootApp/master/docker/localhost-rsa-key.pem conf/security/ssl/
ADD https://raw.githubusercontent.com/rtdi/ConnectorRootApp/master/docker/tomcat-users.xml conf/security/
ADD https://github.com/SAP/openui5/releases/download/1.78.1/openui5-runtime-1.78.1.zip ./webapps/openui5.war
ADD https://raw.githubusercontent.com/rtdi/ConnectorRootApp/master/docker/context.xml conf/
ADD https://raw.githubusercontent.com/rtdi/ConnectorRootApp/master/docker/create_cert.sh ./
ADD https://github.com/rtdi/ConnectorRootApp/releases/latest/download/ROOT.war ./webapps/

EXPOSE 8080
EXPOSE 8443


CMD ["catalina.sh", "run"]
