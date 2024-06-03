# Use the official Maven image as the base image
FROM maven:3.8.3-openjdk-17-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files to the container
COPY pom.xml .

# Download dependencies and build the application
RUN mvn dependency:go-offline

# Copy the application source code to the container
COPY src ./src

# Build the application
RUN mvn clean package

# Use AdoptOpenJDK as the base image for the final image
FROM adoptopenjdk/openjdk17:alpine

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build stage to the container
COPY --from=build /app/target/my-app.jar ./my-app.jar

# Command to run the application
CMD ["java", "-jar", "my-app.jar"]

