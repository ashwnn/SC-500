#!/usr/bin/env bash
set -euo pipefail

# Run in Azure Cloud Shell Bash after reviewing every value.
# This script creates only low-cost organizational resources. It does not enable
# Defender plans, deploy compute, or create globally named services.

: "${AZURE_SUBSCRIPTION_ID:?Set AZURE_SUBSCRIPTION_ID first}"

PRIMARY_LOCATION="canadacentral"
AI_LOCATION="eastus2"
PROJECT_TAG="sc500-30d"
OWNER_TAG="student"

az account set --subscription "$AZURE_SUBSCRIPTION_ID"

for group_name in \
  rg-sc500-core-cc \
  rg-sc500-data-cc \
  rg-sc500-app-cc \
  rg-sc500-vm-cc \
  rg-sc500-aks-cc \
  rg-sc500-sec-cc
do
  az group create \
    --name "$group_name" \
    --location "$PRIMARY_LOCATION" \
    --tags project="$PROJECT_TAG" owner="$OWNER_TAG" environment=lab >/dev/null
done

az group create \
  --name rg-sc500-ai-eus2 \
  --location "$AI_LOCATION" \
  --tags project="$PROJECT_TAG" owner="$OWNER_TAG" environment=synthetic-lab data-classification=synthetic-only >/dev/null

az group list \
  --tag project="$PROJECT_TAG" \
  --query "[].{name:name,location:location,state:properties.provisioningState}" \
  --output table

echo "Bootstrap complete. Create budgets in Cost Management before deploying services."

