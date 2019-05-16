#!/usr/bin/env bash

VERSION=`curl -i https://tomcat.apache.org/download-90.cgi\?Preferred\=https%3A%2F%2Fwww-eu.apache.org%2Fdist%2F | grep  "<h3 id=\"9" | sed "s/^.*id=\"\([0-9.]*\).*/\1/"`
#curl -O https://www-eu.apache.org/dist/tomcat/tomcat-9/v$VERSION/bin/apache-tomcat-$VERSION.tar.gz
#curl -O https://www.apache.org/dist/tomcat/tomcat-9/v$VERSION/bin/apache-tomcat-$VERSION.tar.gz.sha512

echo $VERSION
shasum -c apache-tomcat-$VERSION.tar.gz.sha512

docker build -t citypay/tomcat:$VERSION .

# gpg --verify .asc .tar.gz

