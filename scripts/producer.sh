#!/usr/bin/env bash

# Kafka "producer" script that sends names as messages to test cluster functionality.
# Requires: https://github.com/edenhill/kcat

while :
do
  kcat -b kafka-demo-bootstrap.mysite.com:443 -t upstream_be -X enable.ssl.certificate.verification=false -X security.protocol=ssl -P -l names.txt
  sleep 1s
done
