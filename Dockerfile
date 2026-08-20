# Giai đoạn 1: Build mã nguồn bằng Maven với Java 17
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copy cấu hình và mã nguồn để đóng gói file .war
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Giai đoạn 2: Chạy ứng dụng trên máy chủ Tomcat 11
FROM tomcat:11.0-jdk17-temurin

# Xóa trang mặc định và nạp file .war vừa build vào làm trang gốc (ROOT)
RUN rm -rf /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/ROOT.war
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
