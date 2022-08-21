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

ARG GRAAL_URL=https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAAL_VERSION}/graalvm-ce-java${JVM_VERSION}-linux-amd64-${GRAAL_VERSION}.tar.gz
ARG NATIVE_IMAGE_URL=https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAAL_VERSION}/native-image-installable-svm-java${JVM_VERSION}-linux-amd64-${GRAAL_VERSION}.jar
ARG SCALA_CLI=https://github.com/VirtusLab/scala-cli/releases/download/v{$SCALA_CLI_VERSION}/scala-cli-x86_64-pc-linux-static.gz

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

RUN apt-get update \
    && apt-get install -y --no-install-recommends tzdata curl ca-certificates fontconfig locales binutils procps bash libudev1 fonts-dejavu-core\
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

COPY slim-java* /usr/local/bin/

# Install GraalVM and Native Image
RUN set -eux; \
    export DEBIAN_FRONTEND=noninteractive; \
    curl --retry 3 -Lfso /tmp/graalvm.tar.gz ${GRAAL_URL}; \
    curl --retry 3 -Lfso /tmp/native-image.jar ${NATIVE_IMAGE_URL}; \
    mkdir -p /opt/java/graalvm; \
    cd /opt/java/graalvm; \
    tar -xf /tmp/graalvm.tar.gz --strip-components=1; \
    export PATH="/opt/java/graalvm/bin:$PATH"; \
    /opt/java/graalvm/bin/gu -L install /tmp/native-image.jar; \
    /usr/local/bin/slim-java.sh /opt/java/graalvm; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /tmp/graalvm.tar.gz; \
    rm -rf /tmp/native-image.jar;

# Install scala-cli
RUN \
  curl --retry 3 -Lfso /tmp/scala-cli.gz ${SCALA_CLI}; \
  gunzip /tmp/scala-cli.gz; \
  chmod +x /tmp/scala-cli; \
  mv /tmp/scala-cli /usr/bin/

# Preload scala-cli
RUN \
  scala-cli compile - --scala ${SCALA_2_12_VERSION} && \
  scala-cli compile - --scala ${SCALA_2_13_VERSION} && \
  scala-cli compile - --scala ${SCALA_3_VERSION}

ENV JAVA_HOME=/opt/java/graalvm \
    PATH="/opt/java/graalvm/bin:$PATH"

CMD java -version; scala-cli about
