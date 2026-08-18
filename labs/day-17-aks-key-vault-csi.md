# Day 17 - AKS Workload Identity and Key Vault CSI

**Time:** 90-120 minutes  
**Mode:** Cost-burst  
**SC-500:** managed identity, AKS security, Key Vault integration

## Business request

The API pod needs one Key Vault secret. NCES prohibits client secrets in Kubernetes manifests, environment variables, images, and CI/CD variables.

## Build

1. Start the AKS cluster and enable the Key Vault Secrets Store CSI add-on if it was not created with it.
2. Create a user-assigned managed identity for the API.
3. Create Kubernetes service account `pathfinder-api`.
4. Create a federated identity credential connecting the service account issuer/subject to the managed identity.
5. Grant only **Key Vault Secrets User** to that identity at the vault or narrow supported scope.
6. Create a `SecretProviderClass` that mounts the synthetic day 10 secret as a read-only volume.
7. Configure the pod for Workload Identity and service account. Do not include a client secret.
8. Prove the file is mounted without printing its value.
9. Rotate the Key Vault secret and observe the mounted version update according to the add-on rotation interval.
10. Remove the data-plane role and prove retrieval/refresh fails; restore the assignment.

## Tradeoff exercise

Compare:

- CSI-mounted file;
- synchronization to a native Kubernetes Secret;
- direct SDK call using Workload Identity.

Native Secret synchronization improves application compatibility but persists the value in Kubernetes/etcd. Choose the CSI file or direct token-based retrieval for NCES unless compatibility forces the tradeoff.

## Cost and cleanup

Stop AKS. Keep identity, federation, and CSI objects for day 18 evidence, then remove with the cluster.

## Sources

- [AKS Workload Identity](https://learn.microsoft.com/azure/aks/workload-identity-deploy-cluster)
- [Key Vault CSI driver](https://learn.microsoft.com/azure/aks/csi-secrets-store-driver)
- [CSI identity access](https://learn.microsoft.com/azure/aks/csi-secrets-store-identity-access)

