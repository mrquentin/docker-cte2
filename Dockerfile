FROM openjdk:17-buster

ARG PROJECT_VERSION="0.5.2b"

LABEL version=$PROJECT_VERSION

RUN apt-get update && apt-get install -y curl unzip jq && \
 adduser --uid 99 --gid 100 --home /data --disabled-password minecraft

COPY launch.sh /launch.sh
COPY server-file-info.json /server-file-info.json
RUN chmod +x /launch.sh

USER minecraft

ENV PROJECT_VERSION=$PROJECT_VERSION

VOLUME /data
WORKDIR /data

EXPOSE 25565/tcp

CMD ["/launch.sh"]