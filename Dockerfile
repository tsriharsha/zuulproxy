FROM openjdk:8
ENV APP_HOME=/root/dev/myapp/
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY . .
RUN ./gradlew build

FROM openjdk:8-jre-alpine
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /root/dev/myapp/build/libs/zuulproxy-0.0.1-SNAPSHOT.jar .
CMD ["sh","-c","/usr/bin/java -Xmx256m -jar -Dspring.profiles.active=dev /root/zuulproxy-0.0.1-SNAPSHOT.jar"]