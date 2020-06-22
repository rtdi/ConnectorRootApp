# ConnectorRootApp
A simple Tomcat base layer providing links to all configured apps, adds security, SSL and other convenience functions.


## Default Usage

By starting any docker image based on this (and unless overwritten) the following assumptions are made
- SSL is turned on but the keys are empty
- The tomcat default user auth is used and its only user login is rtdi / rtdi!io


## Usage

Although the image contains a security hardened default tomcat setup, some things like a proper SSL certificate cannot be provided automatically.
All these settings are located in /usr/local/tomcat/conf/security and hence it is advised to mount this directory with a host directory containing the actual files.
The directory structure is 

<img src="https://github.com/rtdi/ConnectorRootApp/raw/master/docs/media/tomcat_security_dir.png" width="50%">

For convenience reasons a little shell script /usr/local/tomcat/create_cert.sh can be used as hint on how to use openssl on the host to create the two SSL key files.
