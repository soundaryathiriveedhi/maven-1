FROM tomcat:8.0.20-jre8
# Dummy text to test 
COPY webapp/target/webapp*.war /usr/local/tomcat/webapps/webapp.war
