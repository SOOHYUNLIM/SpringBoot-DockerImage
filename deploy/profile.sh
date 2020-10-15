#!/usr/bin/env bash

# 새로 만들 Profile 찾기
function findNewProfile() {
 RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/profile)
 CURRENT_PROFILE=default

 if [ $RESPONSE_CODE -ge 400 ] # 400 보다 크면(즉, 40x/50x 에러 모두 포함)
 then
     CURRENT_PROFILE=set2
 else
     CURRENT_PROFILE=$(curl -s http://localhost/profile)
 fi

 if [ $CURRENT_PROFILE == set1 ]
 then
     NEW_PROFILE=set2
 else
     NEW_PROFILE=set1
 fi

 echo "${NEW_PROFILE}"
}

# 쉬고 있는 profile의 port 찾기
function findPort() {
   NEW_PROFILE=$(findNewProfile)

   if [ ${NEW_PROFILE} == set1 ]
   then
       echo "8081"
   else
       echo "8082"
   fi
}