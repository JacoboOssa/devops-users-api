# Use the official Maven image with OpenJDK 8 to build the application
FROM maven:3.8.5-openjdk-8 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests

# Package stageefef
FROM openjdk:8-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar users-api.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]