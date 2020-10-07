#!/bin/bash


TEST_JAR=$(ls *.jar)
nohup java -jar $TEST_JAR &
#
#DEPLOY_PATH=/home/ec2-user/build
#BUILD_JAR=$(ls $DEPLOY_PATH/*.jar)
#
#JAR_NAME=$(basename $BUILD_JAR)
#echo "> build 파일명: $JAR_NAME"
#
#CURRENT_PID=$(pgrep -f $JAR_NAME)
#echo "> 현재 실행중인 애플리케이션 pid 확인"
#
#if [ -z $CURRENT_PID ]
#then
#  echo "> 현재 구동중인 애플리케이션이 없습니다."
#else
#  echo "> $CURRENT_PID ...종료!"
#  kill -15 $CURRENT_PID
#  sleep 5
#fi
#
#echo "> 새 어플리케이션 배포: $DEPLOY_PATH/$JAR_NAME"
#nohup java -jar $DEPLOY_PATH/$JAR_NAME &