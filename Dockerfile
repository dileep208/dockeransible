FROM tomcat:9-jdk8-openjdk
COPY ./target/*.war /usr/local/tomcat/webapps/dockeransible.war
