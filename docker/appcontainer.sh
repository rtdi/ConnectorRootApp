#!/bin/sh
SECURITYROOT=/usr/local/tomcat/conf/security/
if [ "${SSLHOSTNAME}" != "" ]
then
  echo "Creating self signed certificates for ${SSLHOSTNAME}"
  openssl req -x509 -newkey rsa:4096 -keyout ${SECURITYROOT}/ssl/localhost-rsa-key.pem -out ${SECURITYROOT}/ssl/localhost-rsa-cert.pem -days 36500 -passout pass:changeit -subj "/C=/ST=/L=/O=rtdi.io/CN=${SSLHOSTNAME}"
fi
if [ "${TOMCATPWD}" != "" ]
then
  echo "Copying the tomcat-users-orig.xml and setting the password in the tomcat-users.xml file"
  sed -e "s/rtdi\!io/xyz/g" ${SECURITYROOT}/tomcat-users-orig.xml > ${SECURITYROOT}/tomcat-users.xml
elif [ -f "${SECURITYROOT}/tomcat-users.xml" ]
then
  echo "The tomcat-users.xml file exists, leaving it untouched"
else
  echo "No tomcat-users.xml file found, copying the tomcat-users-orig.xml with its defaults"
  cp ${SECURITYROOT}/tomcat-users-orig.xml ${SECURITYROOT}/tomcat-users.xml
fi

exec catalina.sh run

