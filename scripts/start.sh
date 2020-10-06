#!/bin/bash
echo "> Start Spring Boot Service Deploy..."

cd /home/ec2-user/build/build/libs

java -jar demo-0.0.1-SNAPSHOT.jar
