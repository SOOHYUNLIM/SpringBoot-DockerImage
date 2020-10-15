#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh

NEW_PORT=$(findPort)

echo "> $NEW_PORT 에서 구동 중인 애플리케이션 pid 확인"
NEW_PID=$(lsof -ti tcp:${NEW_PORT})

if [ -z ${NEW_PID} ]
then
 echo "> 현재 구동 중인 애플리케이션이 없으므로 종료하지 않습니다."
else
 echo "> kill -15 $NEW_PID"
 kill -15 ${NEW_PID}
 sleep 5
fi