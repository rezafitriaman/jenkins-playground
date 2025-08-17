#!/usr/bin/env bash

echo "******************"
echo "** Building jar **"
echo "******************"

docker run --rm -v $PWD/java-app:/app -v $PWD/.m2/:/root/.m2/ -w /app maven:3.9.9-ibm-semeru-21-noble "$@"
