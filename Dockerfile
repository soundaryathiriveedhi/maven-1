FROM tomcat:8.0.20-jre8
# Dummy text to test 
COPY /var/lib/jenkins/workspace/mvn-web-app/webapp/target/webapp*.war /usr/local/tomcat/webapps/webapp.war
