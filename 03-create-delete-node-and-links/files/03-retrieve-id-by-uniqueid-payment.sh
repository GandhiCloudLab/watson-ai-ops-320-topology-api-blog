#!/bin/bash

source ./00-config.sh

UNIQUEID=payment-svc-id

curl -X GET --insecure -u $TOPO_USER:$TOPO_PWD --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-TenantID: ${TOPO_TENENT_ID}" -d '{}' "${TOPO_API_URL}/resources?_filter=uniqueId:$UNIQUEID"

