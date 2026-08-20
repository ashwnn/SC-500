# Day 3 - PIM, Azure RBAC, and Custom Roles Evidence Log

## Session

- **Lab:** Day 3 - PIM, Azure RBAC, and custom roles
- **Date:** August 20, 2026
- **Mode:** RBAC hands-on with Microsoft Entra PIM
- **Tenant:** Dedicated SC-500 lab tenant
- **Primary focus:** Azure RBAC scope, PIM eligible access, custom Azure roles, Microsoft Entra custom roles, and excessive-access remediation
- **Azure consumption:** No material compute/storage resources deployed by this lab

> Tenant, subscription, and object identifiers are intentionally omitted from this public evidence log.

## Business control

- **Requirement:** NCES platform personnel must be able to operate Pathfinder infrastructure without standing subscription-wide Owner or Contributor access.
- **Threat or failure mode:** Excessive standing privilege, privilege persistence, unauthorized RBAC changes, broad compromise blast radius, and conflation of Microsoft Entra directory roles with Azure resource roles.
- **Control selected:** Resource-group-scoped Azure RBAC, PIM eligible assignments, least-privilege custom roles, separation of platform/security/developer responsibilities, and removal of unnecessary root-scope authorization elevation.
- **Why this fits:** Operational access is granted only where required and elevated access can be activated when needed instead of remaining permanently active.
- **Rejected alternative:** Permanent subscription-wide Contributor/Owner assignments for platform operations.

## Initial RBAC review

The Azure subscription-level access review identified the administrative account with:

- Owner at subscription scope.
- Foundry User at subscription scope.
- User Access Administrator inherited from root scope.

The inherited User Access Administrator assignment was associated with the earlier use of **Access management for Azure resources**.

### Remediation

The **Access management for Azure resources** elevation was disabled during Day 3.

This removed the unnecessary standing root-scope Azure authorization elevation identified during Day 1.

## NCES role model

### GRP-Platform-Ops

Platform Operations is responsible for the Azure infrastructure supporting Pathfinder, but does not require permanent subscription-wide privilege.

PIM eligible **Contributor** assignments were configured for:

| Resource group | Access |
|---|---|
| `rg-sc500-core-cc` | Contributor - eligible |
| `rg-sc500-app-cc` | Contributor - eligible |
| `rg-sc500-vm-cc` | Contributor - eligible |
| `rg-sc500-aks-cc` | Contributor - eligible |
| `rg-sc500-data-cc` | No Contributor assignment |
| `rg-sc500-sec-cc` | No Contributor assignment |
| `rg-sc500-ai-eus2` | No Contributor assignment |

This limits the Platform Operations blast radius to infrastructure they are expected to operate.

### GRP-Pathfinder-Developers

| Resource group | Access |
|---|---|
| `rg-sc500-data-cc` | Reader - active |
| `rg-sc500-app-cc` | Contributor - eligible |

Developers can inspect data-service resource metadata and can request deployment privilege for application resources without receiving broad subscription access.

### GRP-Cloud-SecOps

Cloud Security Operations was configured with PIM eligible **Security Reader** assignments across the current lab resource groups.

The implementation used explicit resource-group assignments rather than one subscription-scope Security Reader assignment.

This is more restrictive for existing resources but requires a new assignment whenever a new resource group is introduced.

## Azure custom role

A custom Azure RBAC role named:

`NCES Network Diagnostics Operator`

was created.

Purpose:

- Read Azure network configuration.
- Read supporting VM/VMSS metadata needed for troubleshooting.
- Run Network Watcher verification and troubleshooting operations.
- Avoid permissions that modify NSGs or other network resources.

Representative permissions include:

```text
Microsoft.Network/*/read
Microsoft.Compute/virtualMachines/read
Microsoft.Compute/virtualMachineScaleSets/read
Microsoft.Resources/subscriptions/resourceGroups/read
Microsoft.Network/networkWatchers/connectivityCheck/action
Microsoft.Network/networkWatchers/queryTroubleshootResult/action
Microsoft.Network/networkWatchers/troubleshoot/action
Microsoft.Network/networkWatchers/ipFlowVerify/action
Microsoft.Network/networkWatchers/nextHop/action
Microsoft.Network/networkWatchers/securityGroupView/action
Microsoft.Network/networkWatchers/topology/action
```

No `Microsoft.Network/*/write` or NSG write permission is included.

The role definition is assignable within the lab subscription and was configured for `GRP-Cloud-SecOps` at `rg-sc500-core-cc` using PIM eligible access.

The sanitized role definition is saved separately as:

`day-03-nces-network-diagnostics-operator.json`

## PIM implementation

Azure PIM eligibility schedule instances confirmed the following design:

- Platform Ops Contributor is eligible rather than permanently active on selected infrastructure resource groups.
- Pathfinder Developers Contributor is eligible on the application resource group.
- Cloud SecOps Security Reader is eligible on the current resource groups.
- Cloud SecOps network diagnostics access is eligible on the core resource group.

The Azure CLI `az role assignment list` command did not enumerate these eligible assignments because PIM eligible role schedules are represented through the Microsoft.Authorization role eligibility schedule APIs rather than ordinary active role assignments.

The assignments were verified through:

```text
Microsoft.Authorization/roleEligibilityScheduleInstances
```

### Pending PIM lifecycle verification

Before declaring the PIM control fully validated, complete one end-to-end activation test:

1. Request an eligible Contributor role.
2. Satisfy MFA.
3. Enter a justification.
4. Obtain approval from `security.operator`.
5. Confirm Contributor becomes active.
6. Perform one allowed management-plane operation.
7. Allow the assignment to expire or manually deactivate it.
8. Confirm the privileged operation is denied afterward.
9. Record the approval/activation event.

Also confirm the tested role's PIM policy uses:

- maximum activation duration: 1 hour;
- MFA required;
- justification required;
- approval required;
- `security.operator` as approver;
- notifications enabled.

## Microsoft Entra role model comparison

The lab compared:

- Microsoft Entra **Privileged Role Administrator**
- Azure **User Access Administrator**

Conclusion recorded during the exercise:

These roles administer different authorization systems.

Privileged Role Administrator manages privileged Microsoft Entra directory-role and PIM administration.

User Access Administrator manages Azure Resource Manager RBAC authorization at Azure scopes.

Both deal with privileged access, but they are not interchangeable.

## Microsoft Entra custom role exercise

The Microsoft Entra custom-role experience was reviewed in:

`Microsoft Entra admin center -> Entra ID -> Roles & admins`

A narrow test Microsoft Entra custom role was created from supported directory permissions, assigned temporarily to a synthetic identity, verified, and then removed.

This demonstrated the difference between:

```text
Microsoft Entra custom role
-> microsoft.directory/* permissions
-> directory authorization
```

and:

```text
Azure custom role
-> Microsoft.Network/* and other resource-provider operations
-> Azure Resource Manager authorization
```

## Verification

| Test | Expected | Actual | Status |
|---|---|---|---|
| Subscription RBAC inventory | Owner/Contributor/UAA scope understood | Completed | Pass |
| Platform Ops standing privilege | No subscription-wide permanent Contributor | Eligible RG-scoped Contributor used | Pass |
| Developer data scope | Read-only access to data RG | Reader configured | Pass |
| Developer app scope | Deployment access without permanent standing privilege | Eligible Contributor configured | Pass |
| Network diagnostics role | Read/diagnose without network write | Custom role created with no network write actions | Pass |
| Root UAA elevation | Remove unnecessary standing root authorization | Access management elevation disabled | Pass |
| Entra custom role | Create, assign, inspect, remove | Completed | Pass |
| PIM end-to-end activation | MFA + justification + approval + expiry/deactivation | Pending final lifecycle evidence | Pending |
| NSG denied-write test | Diagnostics role cannot modify NSG | Deferred until Day 7 resources exist | Deferred |
| Key Vault metadata/data test | Developer can see resource metadata but not secret data | Deferred until Day 10 resources exist | Deferred |

## Findings

### Finding 1 - Root-scope authorization elevation

- **Observation:** User Access Administrator was inherited from root scope after Access management for Azure resources had been enabled.
- **Risk:** Highly privileged Azure authorization capability remained available beyond the original troubleshooting need.
- **Remediation:** Disabled Access management for Azure resources.
- **Result:** Unnecessary standing root-scope elevation removed.

### Finding 2 - PIM eligibility is not returned as normal active RBAC

- **Observation:** `az role assignment list` returned no Platform Ops or Cloud SecOps PIM eligible assignments.
- **Root cause:** Eligible assignments are represented through role eligibility schedule instances rather than active role assignments.
- **Lesson:** Inspect the PIM scheduling API/state when validating eligible Azure RBAC assignments.

### Finding 3 - Security Reader scope design differs from original lab

- **Original lab:** Security Reader at subscription scope.
- **Implemented design:** Eligible Security Reader assignments on each current resource group.
- **Security benefit:** No automatic visibility into unrelated/future resource groups.
- **Operational cost:** New resource groups require explicit SecOps assignment.
- **Decision:** Retain as an intentional least-privilege variation for the lab.

## Deferred verification

Two original Day 3 verification tests depend on resources scheduled for later labs:

- NSG write-denial validation is deferred until the network/NSG labs.
- Key Vault metadata versus secret data-plane access is deferred until the Key Vault lab.

These are deferred dependencies, not Day 3 configuration failures.

## Teardown / persistent state

### Removed

- Root-scope User Access Administrator elevation obtained through Access management for Azure resources.
- Temporary Microsoft Entra custom-role assignment and test role.

### Retained for later labs

- NCES identity groups.
- PIM eligible Azure RBAC assignments.
- `NCES Network Diagnostics Operator` Azure custom role.
- Existing landing-zone resource groups.

## Exam recall

1. **Azure RBAC scope and privilege duration are separate decisions.** A role can be narrowly scoped and still be standing privilege, or it can be PIM eligible and activated only when needed.
2. **Microsoft Entra directory roles and Azure RBAC roles are separate authorization systems.** Similar administrative objectives do not make their roles interchangeable.
3. **Azure custom roles and Microsoft Entra custom roles use different permission models.** Azure roles use resource-provider actions such as `Microsoft.Network/*`; Entra custom roles use supported directory permissions such as `microsoft.directory/*`.

### Confusing distinction

**Active Azure RBAC assignment vs PIM eligible assignment**

An eligible assignment is not necessarily returned as a normal active role assignment. PIM schedule APIs must be inspected when validating eligibility.

### Scenario question

An NCES platform engineer needs temporary Contributor access to modify an AKS resource but should have no standing subscription-wide administrative privilege.

**Which design best fits?**

Grant Contributor as a PIM eligible assignment at the AKS resource-group scope, require activation controls, and allow the privilege to expire automatically after the approved maintenance window.

## Day 3 status

**Ready to close after one final PIM lifecycle validation.**

The configuration and authorization model are complete. The remaining hands-on closeout item is to prove one eligible assignment through activation, approval, use, and loss of privilege after expiry/deactivation.

NSG and Key Vault tests remain intentionally deferred to the later labs that create those resources.
