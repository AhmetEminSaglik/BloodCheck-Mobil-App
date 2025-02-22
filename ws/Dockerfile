FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/ws-bloodcheck-1.0.jar /app/bloodcheck.jar
COPY src/main/resources/service-key.json /app/src/main/resources/service-key.json
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "bloodcheck.jar"]

# mvn clean install -DskipTests; docker build -t ahmeteminsaglik/ws-bloodcheck:2.0 .; docker push ahmeteminsaglik/ws-bloodcheck:2.0