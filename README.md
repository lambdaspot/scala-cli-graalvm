# docker-graalvm

Ubuntu based docker image using GraalVM as JVM.

## Notice!
**TODO - work in progress - not yet published**

Download from https://hub.docker.com/r/lambdaspot/scala-cli-graalvm/tags

**TODO - new versioning in progress...**
It uses versioning based on: `<javaVersion>-<graalVersion>-<gitSha>`. Merges to master update `<javaVersion>-<graalVersion>` and `<javaVersion>` images.


```bash
docker pull lambdaspot/scala-cli-graalvm:latest
```

This image has preloaded packages for fast startup and execution under the listed Scala versions and GraalVM distribution.

- GraalVM and Native Image: 22.1.0 for JDK 17.
- Scala: 2.12.16, 2.13.8, 3.1.3

## Example usage

Scala 3:
```bash
docker run --rm -v $(pwd)/demo/hello3.scala:/hello3.scala scala-cli-graalvm:latest package --native-image --scala 3.1.3 --graalvm-jvm-id graalvm-java17:22.1.0 /hello3.scala
```
Scala 2
```bash
docker run --rm -v $(pwd)/demo/hello2.scala:/hello2.scala scala-cli-graalvm:latest package --native-image --scala 2.13.8 --graalvm-jvm-id graalvm-java17:22.1.0 /hello2.scala
```

## Options 

TODO: add examples for options like passing the `reflect-config.json`.

## Building

Github Actions are used: https://github.com/lustefaniak/docker-graalvm/actions
