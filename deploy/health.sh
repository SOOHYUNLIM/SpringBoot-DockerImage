#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh
source ${ABSDIR}/switch.sh

NEW_PORT=$(findPort)

echo "> Health Check Start!"
echo "> 새로운 서비스 Port: $NEW_PORT"
echo "> curl -s http://localhost:$NEW_PORT/profile"
sleep 10

for RETRY_COUNT in {1..10}
do
 RESPONSE=$(curl -s http://localhost:${NEW_PORT}/profile)
 UP_COUNT=$(echo ${RESPONSE} | grep 'set' | wc -l)

 if [ ${UP_COUNT} -ge 1 ]
 then #$up_count >= 1 ("set" 문자열이 있는지 검증)
   echo "> Health check 성공"
   switchProxy
   break
 else
   echo "> Health check의 응답을 알 수 없거나 혹은 실행 상태가 아닙니다."
   echo "> Health check: ${RESPONSE}"
 fi

 if [ ${RETRY_COUNT} -eq 10 ]
 then
   echo "> Health check 실패. "
   echo "> Nginx에 연결하지 않고 배포를 종료합니다."
   exit 1
 fi

 echo "> Health check 연결 실패. 재시도..."
 sleep 10
done
