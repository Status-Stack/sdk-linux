#!/usr/bin/env bash

. ./local.config

send_request() {
  /usr/bin/curl --request POST \
     --url "${1}" \
     --header "X-StatusStack-Auth: ${2}" \
     --header 'Content-type: application/json; charset=UTF-8' \
     --header 'User-Agent: Status Stack - Linux SDK' \
     --data "{\"tag\":\"${3}\",\"data\":\"${4}\",\"priority\":0}"
}

if [[ "$OSTYPE" == "darwin"* ]]; then
  value=$(uptime | awk -F "load averages: " '{print $2}' | awk -F " " '{print $1}')
else
  value=$(uptime | awk -F "load average: " '{print $2}' | awk -F "," '{print $1}')
fi

send_request "${API_ENDPOINT}" "${API_KEY}" "load-averages" "${value}"