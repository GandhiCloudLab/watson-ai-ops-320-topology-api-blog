#!/usr/bin/env bash

source ./00-config.sh
source ./00-process.sh

echo "Creating Entities/Nodes for SVC, DEPLOYMENT and POD"

createDeploymentPodService "$SERVICE_productpage"
createDeploymentPodService "$SERVICE_details"
createDeploymentPodService "$SERVICE_reviews"
createDeploymentPodService "$SERVICE_ratings"



