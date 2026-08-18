#!/usr/bin/env bash
set -euo pipefail

# Explicit allowlist only. Review the list before running.
# Defender subscription plans, Security Copilot capacity, Microsoft 365 trials,
# and Sentinel data-lake onboarding require separate portal checks.

: "${AZURE_SUBSCRIPTION_ID:?Set AZURE_SUBSCRIPTION_ID first}"
: "${CONFIRM_SC500_DELETE:?Set CONFIRM_SC500_DELETE=DELETE-SC500-LAB to continue}"

if [[ "$CONFIRM_SC500_DELETE" != "DELETE-SC500-LAB" ]]; then
  echo "Confirmation string did not match. Nothing was deleted."
  exit 1
fi

az account set --subscription "$AZURE_SUBSCRIPTION_ID"

groups=(
  rg-sc500-core-cc
  rg-sc500-data-cc
  rg-sc500-app-cc
  rg-sc500-vm-cc
  rg-sc500-aks-cc
  rg-sc500-ai-eus2
  rg-sc500-sec-cc
)

for group_name in "${groups[@]}"; do
  exists=$(az group exists --name "$group_name")
  if [[ "$exists" == "true" ]]; then
    project_tag=$(az group show --name "$group_name" --query "tags.project" --output tsv)
    if [[ "$project_tag" != "sc500-30d" ]]; then
      echo "Refusing to delete $group_name because its project tag is not sc500-30d."
      exit 1
    fi
  fi
done

for group_name in "${groups[@]}"; do
  if [[ $(az group exists --name "$group_name") == "true" ]]; then
    az group delete --name "$group_name" --yes --no-wait
  fi
done

echo "Deletion requests submitted. Complete every manual checkpoint in day 30."

