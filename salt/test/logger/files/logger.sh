#!/usr/bin/env bash

LOGS_FOLDER='/var/log'
LOGS_COUNT_FILE='/root/counts.log'

NOW=$(date "+%Y-%d-%m %H:%M:%S")

for log_file in $(find  ${LOGS_FOLDER} -type f -name "*.log"); do 
  echo "${NOW}|$(wc -l ${log_file} | awk '{print $2"|"$1}')" >> ${LOGS_COUNT_FILE}
done
