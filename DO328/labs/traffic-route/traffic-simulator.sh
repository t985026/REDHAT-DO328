#!/bin/bash

gateway_url=`oc get route istio-ingressgateway -n istio-system -o template --template '{{ "http://" }}{{ .spec.host }}{{ "/headers" }}'`

while true
do
  curl -s ${gateway_url}
  curl -H "end-user: redhatter" -s ${gateway_url}
  sleep 1
done
