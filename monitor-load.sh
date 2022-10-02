#!/usr/bin/env bash

lav=$(uptime | awk -F "load average: " '{print $2}' | awk -F "," '{print $1}')

/usr/bin/curl --request POST \
     --url "${1}"\
     --header "X-StatusStack-Auth: ${2}"\
     --header 'Content-type: application/json; charset=UTF-8'\
     --header 'User-Agent: Status Stack - Linux SDK'\
     --data "{\"tag\":\"load-averages\",\"data\":${lav},\"priority\":0}"