FROM openjdk:8-jdk-alpine
WORKDIR /MyApp
COPY ./target/*.jar /app.jar
CMD ["java", "-jar", "app.jar"]