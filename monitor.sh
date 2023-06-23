#!/usr/bin/env bash

. ./local.config

#
# Command usage info
#
help() {
  echo ""
  echo "Usage: sh ./monitor.sh [-ls]"
  echo ""
  echo "       -l          Load average"
  echo "       -s          Space usage"
  echo ""
}

#
# Send StatusStack request
#
send_request() {
  /usr/bin/curl --request POST \
     --url "${1}" \
     --header "X-StatusStack-Auth: ${2}" \
     --header 'Content-type: application/json; charset=UTF-8' \
     --header 'User-Agent: Status Stack - Linux SDK' \
     --data "{\"tag\":\"${3}\",\"data\":\"${4}\",\"priority\":0}"
}

#
# Send load average data
#
send_load_average() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    value=$(uptime | awk -F "load averages: " '{print $2}' | awk -F " " '{gsub(",", "."); print $1}')
  else
    value=$(uptime | awk -F "load average: " '{print $2}' | awk -F "," '{print $1}')
  fi

  echo ""
  echo "Load average data send"
  send_request "${1}" "${2}" "load-averages" "${value}"
}

#
# Send usage disk space
#
send_usage_space() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    value=$(df | awk -v filter="${3//\//\/}" '$0~filter{gsub("%", ""); print $5}')
  else
    value=$(df -h --output=pcent ${3} | tail -n +2 | awk '{gsub("%", ""); print $1}')
  fi

  echo ""
  echo "Space usage info send"
  send_request "${1}" "${2}" "usage-space" "${value}"
}

#
# Metrics switcher
#
while getopts ":ls:" args; do
  case "${args}" in
    l) send_load_average "${API_ENDPOINT}" "${API_KEY}" ;;
    s) send_usage_space "${API_ENDPOINT}" "${API_KEY}" "${OPTARG}" ;;
    \?) echo "Invalid option -$OPTARG" >&2; help; exit 1 ;;
  esac
done