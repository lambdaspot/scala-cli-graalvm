# scala-cli-graalvm

Ubuntu based docker image using GraalVM as JVM for Scala.<br>

Supported are the two latest Java LTS versions.<br>
It has preloaded packages for fast startup and execution under selected Scala versions and GraalVM distribution.

## Notice!
**TODO - work in progress - not yet published**

Download from https://hub.docker.com/r/lambdaspot/scala-cli-graalvm/tags

It uses versioning based on: `<releaseVersion>-<javaVersion>`.

e.g.: `0.1.0-17` (`latest`) or `0.1.0-11`.

```bash
docker pull lambdaspot/scala-cli-graalvm:latest
docker pull lambdaspot/scala-cli-graalvm:0.1.0-17
docker pull lambdaspot/scala-cli-graalvm:0.1.0-11
```

It has preloaded packages for fast startup and execution under the listed Scala versions and GraalVM distribution.

| scala-cli-graalvm | Scala-CLI | GraalVM | Scala 2.12 | Scala 2.13 | Scala 3 |
|-------------------|-----------|---------|------------|------------|---------|
| 0.1.0             | 0.1.16    | 22.3.0  | 2.12.17    | 2.13.10    | 3.2.0   |
| 0.0.9             | 0.1.11    | 22.1.0  | 2.12.16    | 2.13.8     | 3.1.3   |


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
