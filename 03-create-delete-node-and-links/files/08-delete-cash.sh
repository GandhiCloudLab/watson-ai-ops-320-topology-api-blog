#!/bin/bash

source ./00-config.sh

ID=p2JcPz5mRXCOAnwSOkZW2g

curl -X DELETE --insecure -u $TOPO_USER:$TOPO_PWD --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-TenantID: ${TOPO_TENENT_ID}" -d "{}" "$TOPO_API_URL/resources/$ID"
