#!/bin/bash

echo "> 배포 시작......"
DEPLOY_PATH=/home/ec2-user/build
BUILD_JAR=$(ls $DEPLOY_PATH/*.jar)

JAR_NAME=$(basename $BUILD_JAR)
echo "> build 파일명: $JAR_NAME"


CURRENT_PROFILE=$(curl -s http://localhost/profile)
echo "> 현재 구동중인 Service 확인: $CURRENT_PROFILE"

if [ $CURRENT_PROFILE == blue ]
then
  IDLE_PROFILE=set2
  IDLE_PORT=8082
elif [ $CURRENT_PROFILE == grean ]
then
  IDLE_PROFILE=set1
  IDLE_PORT=8081
else
  echo "> 일치하는 Profile이 없습니다. Profile: $CURRENT_PROFILE"
  echo "> blue을 할당합니다. IDLE_PROFILE: blue"
  IDLE_PROFILE=blue
  IDLE_PORT=8081
fi

IDLE_APPLICATION=$IDLE_PROFILE-$JAR_NAME
CURRENT_PID=$(pgrep -f $IDLE_APPLICATION)
echo "> 현재 실행중인 애플리케이션 pid 확인"

if [ -z $CURRENT_PID ]
then
  echo "> 현재 구동중인 애플리케이션이 없습니다."
else
  echo "> $CURRENT_PID ...종료!"
  kill -15 $CURRENT_PID
  sleep 5
fi

echo "> 새 어플리케이션 배포($IDLE_PROFILE): $DEPLOY_PATH/$JAR_NAME"

#STDOUT Error 해결 방법: > /dev/null 2> /dev/null < /dev/null 추가 필요
nohup java -jar -Dspring.profiles.active=$IDLE_PROFILE $DEPLOY_PATH/$JAR_NAME > /dev/null 2> /dev/null < /dev/null &

echo "> $IDLE_PROFILE 10초 후 Health check 시작"
echo "> curl -s http://localhost:$IDLE_PORT/health "
sleep 10

for retry_count in {1..10}
do
  response=$(curl -s http://localhost:$IDLE_PORT/health)
  up_count=$(echo $response | grep 'UP' | wc -l)

  if [ $up_count -ge 1 ]
  then # $up_count >= 1 ("UP" 문자열이 있는지 검증)
      echo "> Health check 성공"
      break
  else
      echo "> Health check의 응답을 알 수 없거나 혹은 status가 UP이 아닙니다."
      echo "> Health check: ${response}"
  fi

  if [ $retry_count -eq 10 ]
  then
    echo "> Health check 실패. "
    echo "> Nginx에 연결하지 않고 배포를 종료합니다."
    exit 1
  fi

  echo "> Health check 연결 실패. 재시도..."
  sleep 10
done