#!/bin/bash

source ./00-config.sh

CONNECT_TYPE=dependsOn
FROM_ID=ko7loRnAQN-yqOq7P0D2HQ
TO_ID=p2JcPz5mRXCOAnwSOkZW2g

curl -X POST --insecure -u $TOPO_USER:$TOPO_PWD --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-TenantID: ${TOPO_TENENT_ID}" -d '{}' "$TOPO_API_URL/resources/$FROM_ID/references/out/$CONNECT_TYPE/$TO_ID"