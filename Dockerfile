FROM openjdk:8

LABEL maintainer="Atomist <docker@atomist.com>"
 
ENV DUMB_INIT_VERSION 1.2.2
ENV BLUEBIRD_WARNINGS 0
ENV NODE_ENV development
ENV ATOMIST_ENV production
ENV NPM_CONFIG_LOGLEVEL warn
ENV SUPPRESS_NO_CONFIG_WARNING true
ENV ATOMIST_CONFIG_PATH /opt/sdm/sdm-config.json
ENV DOCKER_BUILDER kaniko

# COPY --from=gcr.io/kaniko-project/executor:v0.9.0 /kaniko /kaniko

RUN curl -s -L -O https://github.com/Yelp/dumb-init/releases/download/v$DUMB_INIT_VERSION/dumb-init_${DUMB_INIT_VERSION}_amd64.deb     && dpkg -i dumb-init_${DUMB_INIT_VERSION}_amd64.deb     && rm -f dumb-init_${DUMB_INIT_VERSION}_amd64.deb

RUN mkdir -p /app

WORKDIR /app

EXPOSE 8080

CMD ["-jar", "cd-ms-20.jar"]

ENTRYPOINT ["dumb-init", "java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Xmx256m", "-Djava.security.egd=file:/dev/urandom"]

COPY target/cd-ms-20.jar cd-ms-20.jar
