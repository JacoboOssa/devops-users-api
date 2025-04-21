# Use the official Maven image with OpenJDK 8 to build the application
FROM maven:3.8.6-openjdk-8 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml and the source code
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Use the official OpenJDK 8 image to run the application
FROM openjdk:8-jre-slim

# Set the working directory
WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /app/target/users-api-0.0.1-SNAPSHOT.jar users-api.jar

# Set environment variables
ENV JWT_SECRET=PRFT
ENV SERVER_PORT=8083

# Expose the port the app runs on
EXPOSE 8083

# Run the application
ENTRYPOINT ["java", "-jar", "users-api.jar"]