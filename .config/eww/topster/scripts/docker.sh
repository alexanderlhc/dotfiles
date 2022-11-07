#!/usr/bin/env bash

rows=$(docker system df)
images=$(echo "$rows" | grep Images | awk '{print $4}')
containers=$(docker ps -q | wc -l)
volumes=$(echo "$rows" | grep Volumes | awk '{print $5}')
echo "{\"images\": \"${images}\", \"containers\": \"${containers}\", \"volumes\": \"${volumes}\"}"
