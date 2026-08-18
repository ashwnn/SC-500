# Day 16 - ACR and AKS security baseline

**Time:** 90-120 minutes  
**Mode:** Cost-burst  
**SC-500:** AKS, ACR, container workload controls

## Business request

The Pathfinder API will move to AKS. Developers must not use registry admin credentials, privileged pods, or unrestricted east-west traffic.

## Build

1. Create a low-cost ACR. Disable the admin user and use Entra RBAC.
2. Import/build one tiny trusted sample image. Review repository permissions, network controls, retention, and Defender image scanning dependencies.
3. Create an AKS Free-tier cluster with one small system node and:
   - Entra integration and Azure RBAC;
   - OIDC issuer and Workload Identity enabled;
   - Azure CNI Overlay powered by Cilium when supported;
   - Defender profile deferred to day 18 if not already enabled.
4. Grant the kubelet/cluster identity only `AcrPull` on the registry.
5. Deploy `frontend` and `api` into a namespace.
6. Label the namespace with restricted Pod Security Admission. Attempt a deliberately privileged pod and prove rejection.
7. Apply default-deny network policies, then allow only frontend-to-API on the application port and required DNS.
8. Verify an unapproved pod cannot reach the API.

## Security discussion

- Kubernetes RBAC controls Kubernetes API actions; Azure RBAC can integrate authorization but does not replace workload network policy.
- ACR admin credentials are shared secrets and bypass per-identity attribution.
- AKS Free tier removes the cluster-management charge, not node, disk, load balancer, IP, or log costs.

## Cost and cleanup

Run `az aks stop` immediately after validation. Delete unnecessary load balancers/public IPs. Keep the stopped cluster and ACR through day 18 only.

## Sources

- [AKS security concepts](https://learn.microsoft.com/azure/aks/concepts-security)
- [Azure CNI powered by Cilium](https://learn.microsoft.com/azure/aks/azure-cni-powered-by-cilium)
- [Pod Security Admission](https://learn.microsoft.com/azure/aks/use-psa)
- [ACR best practices](https://learn.microsoft.com/azure/container-registry/container-registry-best-practices)
- [AKS cost practices](https://learn.microsoft.com/azure/aks/best-practices-cost)

