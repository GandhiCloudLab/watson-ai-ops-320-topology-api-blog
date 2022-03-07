#!/usr/bin/env bash

source ./00-config.sh
source ./00-process.sh

echo "1. To get  getResourceIdByUniqueId"

getResourceIdByUniqueId "$SERVICE_productpage-svc-id"
getResourceIdByUniqueId "$SERVICE_details-svc-id"
getResourceIdByUniqueId "$SERVICE_reviews-svc-id"
getResourceIdByUniqueId "$SERVICE_ratings-svc-id"
