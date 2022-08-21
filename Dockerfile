FROM ubuntu:20.04

# https://github.com/graalvm/graalvm-ce-builds/releases
ARG GRAAL_VERSION=22.1.0
ARG JVM_VERSION=17
# https://github.com/VirtusLab/scala-cli/releases
ARG SCALA_CLI_VERSION=0.1.11
# https://www.scala-lang.org/download/all.html
ARG SCALA_2_12_VERSION=2.12.16
ARG SCALA_2_13_VERSION=2.13.8
ARG SCALA_3_VERSION=3.1.3

ARG SCALA_CLI=https://github.com/VirtusLab/scala-cli/releases/download/v{$SCALA_CLI_VERSION}/scala-cli-x86_64-pc-linux-static.gz

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc zlib1g-dev tzdata curl ca-certificates fontconfig locales binutils procps bash libudev1 fonts-dejavu-core \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# Create a file to trigger builds preloading
RUN echo '@main def hello() = println("Hello!")' > /tmp/helloScala3.scala

# Install scala-cli
RUN \
  curl --retry 3 -Lfso /tmp/scala-cli.gz ${SCALA_CLI} \
  && gunzip /tmp/scala-cli.gz \
  && chmod +x /tmp/scala-cli \
  && mv /tmp/scala-cli /usr/bin/

# Preload scala-cli
RUN \
  scala-cli compile - --scala ${SCALA_2_12_VERSION} \
  && scala-cli compile - --scala ${SCALA_2_13_VERSION} \
  && scala-cli compile - --scala ${SCALA_3_VERSION}

# Preload GraalVM and Native Image
RUN \
  scala-cli package --native-image --graalvm-jvm-id graalvm-java${JVM_VERSION}:${GRAAL_VERSION} /tmp/helloScala3.scala -o /tmp/hello \
  && rm /tmp/helloScala3.scala \
  && rm /tmp/hello

# TODO: the entrypoint shall stick to preloaded graalvm version: "--graalvm-jvm-id graalvm-java17:22.2.0"
#  it shall have options --scala-version = 2.12, 2.13 and 3 that takes the preloaded version
ENTRYPOINT [ "scala-cli" ]