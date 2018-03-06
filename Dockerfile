FROM tomcat:alpine
RUN wget http://192.168.30.234:8081/nexus/content/repositories/snapshots/task7/task7-2.3.4.war && \
    cp task7-2.3.4.war /usr/local/tomcat/webapp
CMD catalina start