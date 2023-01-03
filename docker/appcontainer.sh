#!/bin/sh
set -x
TOMCATROOT=/usr/local/tomcat/conf
SECURITYROOT=$TOMCATROOT/security
if [ -d ${SECURITYROOT}/ssl ]
then
  echo "SSL directory exists"
else
  echo "SSL directory ${SECURITYROOT}/ssl does not exist, creating it"
  mkdir -p ${SECURITYROOT}/ssl
fi
if [ -s ${SECURITYROOT}/ssl/.certs ]
then
  if [ ! -s ${SECURITYROOT}/ssl/ca.pem ]
  then
    echo "Convert the file ${SECURITYROOT}/ssl/ca.pem to ${SECURITYROOT}/ssl/ca.der"
    openssl x509 -in ${SECURITYROOT}/ssl/ca.pem -inform pem -out ${SECURITYROOT}/ssl/ca.der -outform der
  else
    echo "A file ${SECURITYROOT}/ssl/ca.pem does not exist, so no certificate to convert to the 'der' format"
  fi
  if [ -s ${SECURITYROOT}/ssl/ca.der ]
  then
    echo "No ${SECURITYROOT}/ssl/ca.der file found, hence creating a default certificate using the environment variable SSLHOSTNAME (or localhost if missing)"
    if [ "${SSLHOSTNAME}" == "" ]
    then
      SSLHOSTNAME="localhost"
    fi
    $JAVA_HOME/bin/keytool -genkey -alias tomcat -keyalg RSA -storepass changeit -keystore ${SECURITYROOT}/ssl/.certs -noprompt -dname "cn=${SSLHOSTNAME}, ou=mygroup, o=rtdi.io, c=mycountry" -validity 36500
  else
    echo "The file ${SECURITYROOT}/ssl/ca.der was found and is imported into the certificate store"
    $JAVA_HOME/bin/keytool -importcert -alias startssl -storepass changeit -keystore ${SECURITYROOT}/ssl/.certs -noprompt -file ${SECURITYROOT}/ssl/ca.der
  fi
else
  echo "The file ${SECURITYROOT}/ssl/.certs exists and hence is left unchanged"
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

