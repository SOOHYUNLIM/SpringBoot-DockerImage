#!/bin/bash

# 새로 만들 Profile 찾기
function find_idle_profile(){
 RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/profile)

 if [ ${RESPONSE_CODE} -ge 400 ] # 400 보다 크면(즉, 40x/50x 에러 모두 포함)
 then
     CUREENT_PROFILE=set2
 else
     CUREENT_PROFILE=$(curl -s http://localhost/profile)
 fi

 if [ $(CUREENT_PROFILE) == set1 ]
 then
     IDLE_PROFILE=set2
 else
     IDLE_PROFILE=set1
 fi

 echo "${IDLE_PROFILE}"
}

# 쉬고 있는 profile의 port 찾기
function find_idel_port() {
   IDLE_PROFILE=$(find_idle_profile)

   if [ ${IDLE_PROFILE} == set1 ]
   then
       echo "8081"
   else
       echo "8082"
   fi
}