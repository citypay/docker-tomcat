FROM citypay/java:1.8

COPY /apache-tomcat-*.tar.gz /apache-tomcat.tar.gz

# Remove everything from CATALINA_HOME/webapps (ROOT, balancer, jsp-examples, servlet-examples, tomcat-docs, webdav)
# rm -rf webapps/*

# Remove everything from CATALINA_HOME/server/webapps (host-manager, manager). Note that it can be
# useful to keep the manager webapp installed if you need the ability to redeploy without restarting
# Tomcat. If you choose to keep it please read the section on Securing the Manager WebApp.
# rm -rf server

# Remove CATALINA_HOME/conf/Catalina/localhost/host-manager.xml and
# CATALINA_HOME/conf/Catalina/localhost/manager.xml (again, if you are keeping the manager application, do not remove this).
# rm /apache-tomcat/conf/Catalina/localhost/*.xml

# Make sure the default servlet is configured not to serve index pages when a welcome file is not present. In CATALINA_HOME/conf/web.xml
# by default this is now disabled



RUN cd / && tar zxvf /apache-tomcat.tar.gz && \
 rm apache-tomcat.tar.gz && \
 mv apache-tomcat* apache-tomcat && \
 cd /apache-tomcat && \
 rm -rf webapps/* && \
 rm -rf server && \
 rm -f /apache-tomcat/conf/Catalina/localhost/*.xml && \
 rm -rf bin/*.bat && \
 rm conf/tomcat-users.* && \
 rm -rf temp/*


ENV CATALINA_HOME=/apache-tomcat

COPY files/simple-server.xml /apache-tomcat/conf/server.xml
COPY files/conf/ /apache-tomcat/conf/

EXPOSE 8080

CMD ["/apache-tomcat/bin/catalina.sh", "run"]