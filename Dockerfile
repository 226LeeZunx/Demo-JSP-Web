# Bước 1: Dùng Maven để tự động đóng gói file .war
FROM maven:3.8-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Bước 2: Nạp file .war vào máy chủ Tomcat để chạy
FROM tomcat:9.0-jdk11-openjdk-slim
RUN rm -rf /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/ROOT.war
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
