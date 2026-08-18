# Day 5 - Policy, compliance, backup security, and IaC

**Time:** 90-120 minutes  
**Mode:** Hands-on  
**SC-500:** built-in/custom Policy, standards, locks, backup controls, IaC

## Business request

Manual review cannot keep 200 future subscriptions compliant. NCES needs preventive controls deployed as code, but deny policies must not break existing workloads without an audit period.

## Build

1. Create a custom initiative `NCES POC Security Baseline` containing built-ins for:
   - allowed locations: Canada Central, Canada East, and East US 2 only for tagged synthetic AI resources;
   - required tags;
   - secure transfer for Storage;
   - public network access audit for Storage, Key Vault, and SQL;
   - Key Vault soft delete and purge protection;
   - diagnostic settings where deployIfNotExists is supported.
2. Assign it in audit mode. Review compliance and remediation permissions.
3. Write one custom policy that denies a public IP unless `ExceptionApproved=true` and an expiry tag exists. Keep it scoped to a test resource group.
4. Attempt a denied public-IP deployment, then deploy with an approved lab exception and expiry.
5. Apply a `CanNotDelete` lock to the security resource group. Prove resource update works but deletion fails. Remove the lock after evidence.
6. Review Microsoft cloud security benchmark in Defender for Cloud regulatory compliance.
7. In Azure Backup, review soft delete, immutability, Resource Guard/multi-user authorization, and protected operations. Deploy a vault only if its SKU view shows negligible lab cost; otherwise record a configuration design.
8. Export the initiative/custom policy and recreate one low-cost resource through Bicep. Run `what-if` before deployment.

## Required explanation

- `audit` observes, `deny` prevents, `modify` changes requests/resources, and `deployIfNotExists` creates related configuration through a managed identity.
- A resource lock protects the management plane. It does not prevent authorized data-plane deletion inside a storage account.
- IaC is not automatically secure; Policy evaluates the deployed result and pipeline permissions still matter.

## Evidence

Policy JSON, assignment scope, denied deployment, remediation task, lock failure, benchmark view, Bicep what-if, and one exception decision record.

## Sources

- [Azure Policy](https://learn.microsoft.com/azure/governance/policy/overview)
- [Policy effects](https://learn.microsoft.com/azure/governance/policy/concepts/effect-basics)
- [Resource locks](https://learn.microsoft.com/azure/azure-resource-manager/management/lock-resources)
- [Azure Backup security](https://learn.microsoft.com/azure/backup/security-overview)

