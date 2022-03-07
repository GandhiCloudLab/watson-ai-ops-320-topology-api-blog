#!/usr/bin/env bash

echo "Process started "

source ./00-config.sh
source ./00-process.sh

echo "1. Creating Links between (SVC --> DEPLOYMENT --> POD) "
createLink_DependsOn_DeploymentPodService $SERVICE_productpage
createLink_DependsOn_DeploymentPodService $SERVICE_details
createLink_DependsOn_DeploymentPodService $SERVICE_reviews
createLink_DependsOn_DeploymentPodService $SERVICE_ratings

echo "1. Creating Links between (SVC --> SVC) "
createLink_DependsOn_Service $SERVICE_productpage $SERVICE_details
createLink_DependsOn_Service $SERVICE_productpage $SERVICE_reviews
createLink_DependsOn_Service $SERVICE_reviews $SERVICE_ratings

echo "Process completed "
