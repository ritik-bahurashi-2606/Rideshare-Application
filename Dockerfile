# Build the Spring Boot application with the same Java version used by the project.
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml ./pom.xml
COPY src ./src
RUN mvn -B -DskipTests package

# Keep the runtime image small; templates and static assets are packaged in the jar.
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/rideshare-backend.jar /app/app.jar
EXPOSE 8181
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
