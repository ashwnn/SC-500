# Day 3 - PIM, Azure RBAC, and custom roles

**Time:** 90-120 minutes  
**Mode:** RBAC hands-on; PIM trial-dependent  
**SC-500:** PIM, built-in/custom Azure and Entra roles, overprivileged access

## Business request

The platform team needs to operate resources without standing subscription Owner. Security staff need time-bound approval for role assignments, while application developers only require deployment access in the app resource group.

## Tasks

1. At subscription scope, inventory Owner, Contributor, and User Access Administrator assignments, including inherited access.
2. Assign:
   - `GRP-Cloud-SecOps`: Security Reader at subscription scope
   - `GRP-Platform-Ops`: Contributor at selected lab resource groups, not subscription
   - `GRP-Pathfinder-Developers`: Reader on `rg-sc500-data-cc`, Contributor on `rg-sc500-app-cc`
3. Create a custom role named `NCES Network Diagnostics Operator` that can read network resources and run Network Watcher verification/troubleshooting actions but cannot write NSGs.
4. Assign it to `GRP-Cloud-SecOps` at `rg-sc500-core-cc`.
5. If PIM is licensed, make a Contributor assignment eligible for `platform.operator` on one resource group:
   - maximum activation one hour;
   - MFA and justification required;
   - approval required by `security.operator`;
   - notifications enabled.
6. Activate, approve, verify access, then let the assignment expire and prove write access ends.
7. Compare the Microsoft Entra **Privileged Role Administrator** role with Azure **User Access Administrator**. Record why they are not interchangeable.
8. Inspect the custom Microsoft Entra role creation experience. Create a narrow test role from supported directory permissions only if your tenant license permits it, then assign and remove it. Otherwise export a proposed definition and label it simulated.
9. Remove one deliberately excessive Reader/Contributor assignment and record the before/after scope.

## Verification

Use **Check access** on a resource and test as `dev.pathfinder`:

- can view the Key Vault resource metadata;
- cannot read a secret without a Key Vault data-plane role;
- cannot modify an NSG through the custom diagnostics role.

## Critical exit warning

Microsoft documents that license expiry can remove eligible assignments and can turn active time-bound assignments into active permanent assignments. Do not leave trial PIM assignments unattended. Day 30 explicitly removes them.

## Evidence

Save the custom role JSON, scoped role matrix, activation settings, approval event, expired-access failure, and remediation of excessive scope.

## Sources

- [Azure RBAC](https://learn.microsoft.com/azure/role-based-access-control/overview)
- [Custom roles](https://learn.microsoft.com/azure/role-based-access-control/custom-roles)
- [PIM for Azure resources](https://learn.microsoft.com/entra/id-governance/privileged-identity-management/pim-resource-roles-assign-roles)
- [Entra Governance licensing behavior](https://learn.microsoft.com/entra/id-governance/licensing-fundamentals)
