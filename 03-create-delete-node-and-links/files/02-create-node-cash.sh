#!/bin/bash

source ./00-config.sh

PARAM_ENTITY_TYPE=service
PARAM_NAME=cash-svc
PARAM_MATCH_TOKEN=cash-svc
PARAM_UNIQUE_ID=cash-svc-id
PARAM_TAG_APP=bookinfo

JSON_DATA=" \"app\": \"$DATA_APP\",\"dataCenter\": \"$TOPO_DATA_CENTER\" , \"entityTypes\": [\"$PARAM_ENTITY_TYPE\"],  \"matchTokens\": [\"$PARAM_MATCH_TOKEN-v1\"],  \"name\": \"$PARAM_NAME\", \"namespace\": \"$DATA_NAMESPACE\", \"uniqueId\": \"$PARAM_UNIQUE_ID\",  \"availableReplicas\": 1,\"createdReplicas\": 1, \"desiredReplicas\": 1, \"readyReplicas\": 1,\"tags\": [\"app:$PARAM_TAG_APP\",\"namespace:$DATA_NAMESPACE\"],\"vertexType\": \"resource\" "

curl -X POST --insecure -u $TOPO_USER:$TOPO_PWD --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-TenantID: $TOPO_TENENT_ID"  --header "JobId: $JOB_ID" -d "{$JSON_DATA}" "$TOPO_API_URL/resources"

