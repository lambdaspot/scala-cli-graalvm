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
## Example usage

```bash
docker run --rm -v $(pwd)/demo/test.scala:/hello3.scala lambdaspot/scala-cli-graalvm:latest scala-cli --scala 3 /hello3.scala
docker run --rm -v $(pwd)/demo/test.scala:/hello2.scala lambdaspot/scala-cli-graalvm:latest scala-cli --scala 2.13 /hello2.scala
```

## Building

Github Actions are used: https://github.com/lustefaniak/docker-graalvm/actions
