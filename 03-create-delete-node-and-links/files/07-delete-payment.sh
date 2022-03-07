#!/bin/bash

source ./00-config.sh

ID=ko7loRnAQN-yqOq7P0D2HQ

curl -X DELETE --insecure -u $TOPO_USER:$TOPO_PWD --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-TenantID: ${TOPO_TENENT_ID}" -d "{}" "$TOPO_API_URL/resources/$ID"
