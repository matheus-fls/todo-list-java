FROM ubuntu:latest as build

RUN apt update
RUN apt install openjdk-17-jdk -y

COPY . .

RUN apt install maven -y
RUN mvn clean install

FROM openjdk:17-jdk-slim

EXPOSE 8080

COPY --from=build /target/todolist-1.0.0.jar app.jar

ENTRYPOINT [ "java", "-jar", "app.jar" ]
