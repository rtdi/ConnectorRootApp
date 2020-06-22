# ConnectorRootApp
A simple Tomcat base layer providing links to all configured apps, adds security, SSL and other convenience functions.

<img src="https://github.com/rtdi/ConnectorRootApp/raw/master/docs/media/rootapp.png" width="50%">

## Usage

To start the image quickly download it via docker pull

    docker pull rtdi/connectorrootapp

and start it using the command

    docker run -d --name rootapp -p 80:8080 -p 443:8443   rtdi/connectorrootapp

and then open the root page using the correct hostname, e.g. [http://localhost/](http://localhost/)

This assumes all defaults, meaning https will not be operational, just http. The login is set to rtdi / rtdi!io and all made settings will be made within the container.

The better way however is to provide parameters for the SSL hostname, the webserver password and a permanent directory for the settings.
In this example the
- hostname running the docker image is 'example.domain.com'
- webserver user is 'rtdi' and the password is 'changeit'
- host's directory to store all settings is '/home/dir'
- container is removed from docker when it is shut down due to the --rm flag

    docker run -d --name rootapp -p 80:8080 -p 443:8443 \
    --rm -e SSLHOSTNAME=example.domain.com -e TOMCATPWD=changeit \
    -v /home/dir:/usr/local/tomcat/conf/security    rtdi/connectorrootapp

The production way is to prive the directory and modify/create the files correctly. Maybe even provide a better suited server.xml for the tomcat process.

    docker run -d --name rootapp -p 80:8080 -p 443:8443 --rm -v /home/dir:/usr/local/tomcat/conf/security     rtdi/connectorrootapp

The directory structure is 

<img src="https://github.com/rtdi/ConnectorRootApp/raw/master/docs/media/tomcat_security_dir.png" width="25%">

