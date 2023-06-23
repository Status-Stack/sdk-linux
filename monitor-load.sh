#!/usr/bin/env bash

. ./local.config

if [[ "$OSTYPE" == "darwin"* ]]; then
  lav=$(uptime | awk -F "load averages: " '{print $2}' | awk -F " " '{print $1}')
else
  lav=$(uptime | awk -F "load average: " '{print $2}' | awk -F "," '{print $1}')
fi

/usr/bin/curl --request POST \
     --url "${API_ENDPOINT}"\
     --header "X-StatusStack-Auth: ${API_KEY}"\
     --header 'Content-type: application/json; charset=UTF-8'\
     --header 'User-Agent: Status Stack - Linux SDK'\
     --data "{\"tag\":\"load-averages\",\"data\":${lav},\"priority\":0}"