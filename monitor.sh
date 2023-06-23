#!/usr/bin/env bash

. ./local.config

help() {
  echo ""
  echo "Usage: sh ./monitor.sh [-l]"
  echo ""
  echo "       -l          Load average"
  echo ""
}

send_request() {
  /usr/bin/curl --request POST \
     --url "${1}" \
     --header "X-StatusStack-Auth: ${2}" \
     --header 'Content-type: application/json; charset=UTF-8' \
     --header 'User-Agent: Status Stack - Linux SDK' \
     --data "{\"tag\":\"${3}\",\"data\":\"${4}\",\"priority\":0}"
}

send_load_average() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    value=$(uptime | awk -F "load averages: " '{print $2}' | awk -F " " '{gsub(",", "."); print $1}')
  else
    value=$(uptime | awk -F "load average: " '{print $2}' | awk -F "," '{print $1}')
  fi

  echo "Load average data send"
  send_request "${1}" "${2}" "load-averages" "${value}"
}

while getopts ":l" args; do
  case "${args}" in
    l) send_load_average "${API_ENDPOINT}" "${API_KEY}" ;;
    \?) echo "Invalid option -$OPTARG" >&2; help; exit 1 ;;
  esac
done