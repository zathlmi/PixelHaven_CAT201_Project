# Use an official Tomcat image as the base
FROM tomcat:10-jdk17-openjdk-slim

# Remove the default Tomcat webapps to keep it clean
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your built WAR file into Tomcat's webapps folder as ROOT.war
# This makes your app available at the main URL (e.g., https://your-app.onrender.com/)
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Set the port Render expects (default is 10000, but we can override it)
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]