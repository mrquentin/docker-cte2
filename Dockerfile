FROM openjdk:17-buster

ARG PROJECT_VERSION="0.5.2b"
ARG PROJECT_ID=936875

LABEL version=$CTE2_VERSION

RUN apt-get update && apt-get install -y curl unzip && \
 adduser --uid 99 --gid 100 --home /data --disabled-password minecraft

COPY launch.sh /launch.sh
RUN chmod +x /launch.sh

USER minecraft

ENV PROJECT_VERSION=$PROJECT_VERSION
ENV PROJECT_ID=$PROJECT_ID

VOLUME /data
WORKDIR /data

EXPOSE 25565/tcp

CMD ["/launch.sh"]