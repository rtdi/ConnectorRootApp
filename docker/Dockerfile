FROM tomcat:9-jdk14-openjdk-oracle

LABEL maintainer="info@rtdi.io"

ADD https://raw.githubusercontent.com/rtdi/ConnectorRootApp/master/docker/server.xml conf/server.xml
ADD https://raw.githubusercontent.com/rtdi/ConnectorRootApp/master/docker/localhost-rsa-cert.pem conf/security/ssl/
ADD https://raw.githubusercontent.com/rtdi/ConnectorRootApp/master/docker/localhost-rsa-key.pem conf/security/ssl/
ADD https://raw.githubusercontent.com/rtdi/ConnectorRootApp/master/docker/tomcat-users-orig.xml conf/
ADD https://github.com/SAP/openui5/releases/download/1.81.2/openui5-runtime-1.81.2.zip ./webapps/openui5.war
ADD https://raw.githubusercontent.com/rtdi/ConnectorRootApp/master/docker/context.xml conf/
ADD https://github.com/rtdi/ConnectorRootApp/releases/latest/download/ROOT.war ./webapps/
RUN set -eux; yum update -y; yum install -y openssl; yumdb set reason dep openssl;


ADD https://raw.githubusercontent.com/rtdi/ConnectorRootApp/master/docker/appcontainer.sh bin/
RUN chmod +x bin/appcontainer.sh

EXPOSE 8080
EXPOSE 8443


CMD [ "appcontainer.sh" ]
