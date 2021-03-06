FROM alpine:3.13

RUN apk --update add --no-cache maven openjdk11

COPY target/calculator-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
