#!/bin/sh
set -x
TOMCATROOT=/usr/local/tomcat/conf
SECURITYROOT=$TOMCATROOT/security
if [ -d ${SECURITYROOT}/ssl ]
then
  echo "SSL directory exists"
else
  echo "SSL directory ${SECURITYROOT}/ssl does not exist, creating it"
  mkdir ${SECURITYROOT}/ssl
fi
if [ "${SSLHOSTNAME}" != "" ]
then
  if [ -s ${SECURITYROOT}/ssl/localhost-rsa-key.pem && -s ${SECURITYROOT}/ssl/localhost-rsa-cert.pem ]
  then
    echo "SSL keyfiles exist already and are not overwritten hence"
  else
    echo "Creating self signed certificates for ${SSLHOSTNAME}"
    openssl req -x509 -newkey rsa:4096 -keyout ${SECURITYROOT}/ssl/localhost-rsa-key.pem -out ${SECURITYROOT}/ssl/localhost-rsa-cert.pem -days 36500 -passout pass:changeit -subj "/C=/ST=/L=/O=rtdi.io/CN=${SSLHOSTNAME}"
  fi
fi
if [ "${TOMCATPWD}" != "" ]
then
  echo "Copying the tomcat-users-orig.xml and setting the password in the tomcat-users.xml file"
  sed -e "s/rtdi\!io/${TOMCATPWD}/g" ${TOMCATROOT}/tomcat-users-orig.xml > ${SECURITYROOT}/tomcat-users.xml
elif [ -f "${SECURITYROOT}/tomcat-users.xml" ]
then
  echo "The tomcat-users.xml file exists, leaving it untouched"
else
  echo "No tomcat-users.xml file found, copying the tomcat-users-orig.xml with its defaults"
  cp ${TOMCATROOT}/tomcat-users-orig.xml ${SECURITYROOT}/tomcat-users.xml
fi

exec catalina.sh run

