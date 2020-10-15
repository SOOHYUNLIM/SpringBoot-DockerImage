#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh

echo "> 배포 시작......!!!"
DEPLOY_PATH=/home/ec2-user/build
BUILD_JAR=$(ls $DEPLOY_PATH/*.jar)

JAR_NAME=$(basename $BUILD_JAR)
echo "> build 파일명: $JAR_NAME"

NEW_PROFILE=$(findNewProfile)

echo "> 새 어플리케이션 배포: $DEPLOY_PATH/$JAR_NAME / profile=$NEW_PROFILE"

#STDOUT Error 해결 방법: > /dev/null 2> /dev/null < /dev/null 추가 필요
nohup java -jar -Dspring.profiles.active=$NEW_PROFILE $DEPLOY_PATH/$JAR_NAME > /dev/null 2> /dev/null < /dev/null &