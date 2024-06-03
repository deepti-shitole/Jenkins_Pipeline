# Use the official Maven image as the base image
FROM maven:3.8.3-openjdk-17-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files to the container
COPY pom.xml .

# Download dependencies and build the application
RUN mvn dependency:go-offline

# Copy the application source code to the container
COPY ./src ./src

# Build the application
RUN mvn clean package

# Command to run the application
CMD ["java", "-jar", "target/my-app.jar"]
