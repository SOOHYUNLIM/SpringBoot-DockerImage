#!/bin/bash

echo "> 배포 시작......!!!"
DEPLOY_PATH=/home/ec2-user/build
BUILD_JAR=$(ls $DEPLOY_PATH/*.jar)

JAR_NAME=$(basename $BUILD_JAR)
echo "> build 파일명: $JAR_NAME"

IDLE_PROFILE=$(find_idle_profile)

echo "> 새 어플리케이션 배포: $DEPLOY_PATH/$JAR_NAME / profile=$IDLE_PROFILE"

#STDOUT Error 해결 방법: > /dev/null 2> /dev/null < /dev/null 추가 필요
nohup java -jar -Dspring.profiles.active=$IDLE_PROFILE $DEPLOY_PATH/$JAR_NAME > /dev/null 2> /dev/null < /dev/null &