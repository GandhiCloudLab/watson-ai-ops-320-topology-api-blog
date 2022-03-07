#!/usr/bin/env bash

RESULT_VALUE=test

createNode() {
    PARAM_ENTITY_TYPE=$1
    PARAM_NAME=$2
    PARAM_MATCH_TOKEN=$3
    PARAM_UNIQUE_ID=$4
    PARAM_TAG_APP=$5

    JSON_DATA=" \"app\": \"$DATA_APP\",\"dataCenter\": \"$TOPO_DATA_CENTER\" , \"entityTypes\": [\"$PARAM_ENTITY_TYPE\"],  \"matchTokens\": [\"$PARAM_MATCH_TOKEN-v1\"],  \"name\": \"$PARAM_NAME\", \"namespace\": \"$DATA_NAMESPACE\", \"uniqueId\": \"$PARAM_UNIQUE_ID\",  \"availableReplicas\": 1,\"createdReplicas\": 1, \"desiredReplicas\": 1, \"readyReplicas\": 1,\"tags\": [\"app:$PARAM_TAG_APP\",\"namespace:$DATA_NAMESPACE\"],\"vertexType\": \"resource\" "

    curl -X POST --insecure -u $TOPO_USER:$TOPO_PWD --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-TenantID: $TOPO_TENENT_ID"  --header "JobId: $JOB_ID" -d "{$JSON_DATA}" "$TOPO_API_URL/resources"
}

createDeploymentPodService() {
    MICRO_SERVICE_NAME=$1

    echo "Node creation for : $MICRO_SERVICE_NAME"
    createNode "deployment" "$MICRO_SERVICE_NAME-deployment" "$MICRO_SERVICE_NAME-deployment" "$MICRO_SERVICE_NAME-deployment-id" "ilender"
    createNode "pod" "$MICRO_SERVICE_NAME-pod" "$MICRO_SERVICE_NAME-pod" "$MICRO_SERVICE_NAME-pod-id" "ilender"
    createNode "service" "$MICRO_SERVICE_NAME-svc" "$MICRO_SERVICE_NAME-svc" "$MICRO_SERVICE_NAME-svc-id" "ilender"
}

### Sample script
# curl -X POST --insecure -u $N2OI_REST_USR:$TOPO_PWD --header 'Content-Type: application/json' --header 'Accept: application/json' --header 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' -d '{}' 'https://noi-topology.dev-aiops.gsi-waiops-aaaaaaa.us-south.containers.appdomain.cloud/1.0/topology/resources/VtpocyZ0T06bXgX6CJZKZA/references/out/connectedTo/AYTrCkalSYaXcqesvpAm7w'

## method
createLink() {
    FROM_UNIQUE_ID=$1
    TO_UNIQUE_ID=$2
    CONNECT_TYPE=$3

    getResourceIdByUniqueId $FROM_UNIQUE_ID
    FROM_ID=$RESULT_VALUE

    getResourceIdByUniqueId $TO_UNIQUE_ID
    TO_ID=$RESULT_VALUE

    echo "URL ---> $TOPO_API_URL/resources/$FROM_ID/references/out/$CONNECT_TYPE/$TO_ID"

    curl -X POST --insecure -u $TOPO_USER:$TOPO_PWD --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-TenantID: ${TOPO_TENENT_ID}" -d '{}' "$TOPO_API_URL/resources/$FROM_ID/references/out/$CONNECT_TYPE/$TO_ID"
}


## method
getResourceIdByUniqueId() {
    UNIQUEID=$1
    echo "URL ---> $TOPO_API_URL/resources?_filter=uniqueId%3/$UNIQUEID"
    RESULT_VALUE=$(curl -X GET --insecure -u $TOPO_USER:$TOPO_PWD --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-TenantID: ${TOPO_TENENT_ID}" -d '{}' "$TOPO_API_URL/resources?_filter=uniqueId:$UNIQUEID" |  jq -r '._items[]._id')
    echo "getResourceIdByUniqueId ---> $UNIQUEID ==> $RESULT_VALUE"
}


## method
deleteLink() {
    FROM_ID=$1
    TO_ID=$2
    CONNECT_TYPE=$3

    curl -X DELETE --insecure -u $TOPO_USER:$TOPO_PWD --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-TenantID: ${TOPO_TENENT_ID}" -d "{}" "$TOPO_API_URL/resources/$FROM_ID/references/out/$CONNECT_TYPE/$TO_ID"
}

deleteLink_DependsOn() {
    FROM_ID=$1
    TO_ID=$2
    LINK_TYPE="dependsOn"
    echo "$FROM_ID ----> $TO_ID"
    deleteLink $FROM_ID $TO_ID $LINK_TYPE
}

createLink_DependsOn() {
    FROM_ID=$1
    TO_ID=$2

    echo "$FROM_ID ----> $TO_ID"
    createLink $FROM_ID $TO_ID 'DependsOn'
}

createLink_DependsOn_Service() {
    FROM_ID=$1-svc-id
    TO_ID=$2-svc-id

    echo "$FROM_ID ----> $TO_ID"
    createLink $FROM_ID $TO_ID 'DependsOn'
}


createLink_DependsOn_DeploymentPodService() {
    ENTITY_NAME_PREFIX=$1

    ENTITY_DEPLOYMENT=${ENTITY_NAME_PREFIX}-deployment-id
    ENTITY_POD=${ENTITY_NAME_PREFIX}-pod-id
    ENTITY_SVC=${ENTITY_NAME_PREFIX}-svc-id

    createLink_DependsOn ${ENTITY_DEPLOYMENT} ${ENTITY_POD} 'DependsOn'
    createLink_DependsOn ${ENTITY_SVC} ${ENTITY_POD} 'DependsOn'
}

deleteDeploymentPodService() {
    MICRO_SERVICE_NAME=$1

    echo "Node creation for : $MICRO_SERVICE_NAME"
    deleteeNode "deployment" "$MICRO_SERVICE_NAME-deployment" "$MICRO_SERVICE_NAME-deployment" "$MICRO_SERVICE_NAME-deployment-id" "ilender"
    deleteeNode "pod" "$MICRO_SERVICE_NAME-pod" "$MICRO_SERVICE_NAME-pod" "$MICRO_SERVICE_NAME-pod-id" "ilender"
    deleteeNode "service" "$MICRO_SERVICE_NAME-svc" "$MICRO_SERVICE_NAME-svc" "$MICRO_SERVICE_NAME-svc-id" "ilender"
}

### Sample script
# curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' --header 'X-TenantID: cfd95b7e-3bc7-4006-a4a8-a73a79c71255' --header 'Authorization: Basic bm9pLXRvcG9sb2d5LWRldi1haW9welcvb3M9' -d '{
#   "matchTokens": [
#     "productpage-v1","VtpocyZ0T06bXgX6CJZKZA" , "gandhi", "aaa"
#   ]
# }' 'https://noi-topology.dev-aiops.gsi-waiops-aaaaaaaa-0000.us-south.containers.appdomain.cloud/1.0/topology/resources/VtpocyZ0T06bXgX6CJZKZA'

## method
updateMatchToken() {
    UNIQUE_ID=$1
    ID=$2

    curl -X POST --insecure -u $TOPO_USER:$TOPO_PWD --header 'Content-Type: application/json' --header 'Accept: application/json' --header "X-TenantID: ${TOPO_TENENT_ID}" -d "{ \"matchTokens\": [\"$UNIQUE_ID\", \"$ID\"]}" "$TOPO_API_URL/resources/$ID"
}