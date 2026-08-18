# SC-500 objective coverage matrix

Checked against the official SC-500 study guide on **2026-08-18**.

Legend:

- **H** - hands-on with the Azure promotional subscription or Defender plan trial
- **T** - hands-on only when the separate tenant trial/license is available
- **S** - guided simulation/design because the service is expensive, separately licensed, region/quota limited, or operationally sticky

## Manage identity, access, and governance - 20-25 percent

| Official objective | Lab | Mode | Evidence |
|---|---:|:---:|---|
| Implement/configure PIM | 03 | T | eligible assignment, activation/approval/expiry |
| Implement Conditional Access | 04 | T | report-only policies, What If, safe pilot |
| Configure MFA and passwordless methods | 02 | T | TAP, Authenticator/passkey, auth strength |
| Configure application identity, enterprise apps, app registrations | 04 | H | registration, service principal, scopes/roles |
| Manage OAuth permission grants and consent | 04 | H/T | consent policy/workflow, grant and revoke |
| Configure managed identities | 10, 13, 17, 25 | H | token-based Key Vault/ACR/Foundry access |
| Deploy Key Vault | 10 | H | RBAC-enabled Standard vault |
| Configure Key Vault settings | 10 | H | soft delete, purge protection, diagnostics |
| Configure Key Vault access | 10 | H | separated data-plane roles |
| Configure Key Vault firewall | 10 | H | private endpoint/DNS and public denial |
| Manage keys, secrets, and certificates | 10 | H | objects, versions, expiry, recovery, rotation |
| Scan for secrets with Defender CSPM | 19 | T | secret finding/query or documented no-finding |
| Implement Defender for Key Vault | 20 | T | plan/sample alert and response |
| Built-in and custom Azure Policy | 05 | H | initiative, custom deny, remediation |
| Evaluate Defender regulatory compliance | 05, 19 | H/T | MCSB and additional standard |
| Defender security standards/recommendations | 05, 19 | H/T | assignment, owner, remediation |
| Implement resource locks | 05 | H | delete failure and lock removal |
| Manage Azure built-in roles | 03 | H | scoped group assignments |
| Manage custom Azure and Entra roles | 03 | H/T/S | custom diagnostics role and directory-role design |
| Evaluate/remediate overprivileged RBAC | 03, 19 | H/T | reduced assignment scope |
| Configure Azure Backup security | 05 | H/S | soft delete, immutability, Resource Guard design |
| Implement controls through IaC | 01, 05 | H | bootstrap and Bicep what-if/deployment |

## Secure storage, databases, and networking - 25-30 percent

| Official objective | Lab | Mode | Evidence |
|---|---:|:---:|---|
| Storage security configuration | 08-09 | H | TLS, transfer, blob access, deletion/version design |
| Storage firewall rules | 08 | H | private path works, public path denied |
| Defender for Storage | 20 | H + metered | resource plan, small capped scan, alert |
| Storage access and access policies | 09 | H | RBAC, user delegation SAS, expiry, Shared Key denial |
| Azure SQL platform security | 11 | H | Entra-only, private access, encryption |
| SQL auditing | 11 | H | successful/failed query records |
| Defender for Databases | 11, 20 | T | plan, VA/settings/sample alert |
| NSGs and ASGs | 07 | H | role-based rules and allowed/denied tests |
| VNet Manager network access policies | 12 | H/S | network group and security admin design/test |
| Azure Virtual WAN security | 12 | S | secured hub and routing-intent decision |
| VPN security | 12 | S | P2S/S2S auth and gateway design |
| Microsoft Entra Private Access | 12 | T/S | connector/app/CA/licensing design |
| Private endpoints for PaaS | 08, 10-11 | H | private IP/DNS and public denial |
| Private Link Service | 12 | S | provider/consumer approval architecture |
| Azure Firewall | 12 | H/S | short burst rules/logs/deletion or validated design |
| Network Watcher effective rules/diagnostics | 07 | H | IP flow, effective rules, troubleshoot, next hop |

## Secure compute - 20-25 percent

### AI

| Official objective | Lab | Mode | Evidence |
|---|---:|:---:|---|
| Identify SharePoint data overexposure | 27 | T/S | synthetic oversharing graph and remediation |
| Identify Copilot/AI app risks with Purview DSPM | 27 | T/S | risk assessment/DLP design |
| Configure real-time protection for Copilot Studio agents | 27 | T/S | audit-first policy and event model |
| Conditional Access for Entra Agent ID | 27 | T/S | report-only policy/licensing record |
| Analyze Agent ID blast radius in Defender XDR | 27 | T/S | identity-permission-data path |
| Manage Agent ID access | 27 | H/T | blueprint, identities, roles, disable action |
| Deploy AI Gateway in APIM for Foundry | 25 | H/S | managed identity, limits, logs, failure codes |
| Enable Defender for AI Services | 26 | T | plan/trial/protection coverage |
| Configure Foundry agent guardrails | 22 | H/preview | Prompt Shields, filters, task/PII controls |
| Monitor Data and AI security dashboard | 26 | T | assets, recommendations, alerts, paths |
| Manage agents in Microsoft 365 admin center | 27 | T/S | registry export, owner/block decision |

### Servers and VMs

| Official objective | Lab | Mode | Evidence |
|---|---:|:---:|---|
| Disk encryption | 14 | H | encryption option decision/current state |
| Azure Bastion | 14 | H/S | private connection and immediate paid-SKU deletion |
| JIT VM access | 14 | T | temporary access rule and expiry |
| Extend controls using Azure Arc | 15 | H/S | connected disposable host or onboarding design |
| Onboard servers to Defender | 15 | T | coverage and extension health |
| Configure vulnerability scanning and EDR | 15 | T | MDVM/MDE evidence |
| Agentless VM scanning | 15 | T | component status/finding |
| Secure boot, vTPM, integrity, security type | 14 | H | Trusted Launch status |
| Azure Machine Configuration | 15 | H/S | assignment/compliance result |

### Application platform services

| Official objective | Lab | Mode | Evidence |
|---|---:|:---:|---|
| Defender container misconfiguration/runtime risks | 18 | T | image/posture/runtime/sample finding |
| AKS security | 16-18 | H/T | Entra/RBAC, network policy, PSA, workload identity |
| ACR security | 16, 18 | H/T | admin off, AcrPull, scan coverage |
| ACI and Container Apps security | 13 | H/S | identity/ingress/secrets comparison/test |
| Azure Functions security | 13 | H | auth, identity, network, logs |
| Logic Apps security | 13, 29 | H | protected trigger/identity/playbook scope |
| App Service security | 13 | H | Authentication, TLS, identity, access restriction |
| Web Application Firewall | 13 | H/S | detection/prevention test or costed design |
| API Management backend protection | 25 | H/S | JWT, rate/quota, content, backend identity |

## Manage and monitor security posture - 20-25 percent

| Official objective | Lab | Mode | Evidence |
|---|---:|:---:|---|
| Identify risks using Defender CSPM | 19 | T | risk/attack path/Explorer query |
| Evaluate frameworks in Defender | 05, 19 | H/T | MCSB/additional standard |
| Enable Defender workload plans | 20, 26 | T | plan matrix and components |
| Connect AWS/GCP environments | 19 | H/S | owned account connector or permission design |
| Configure MDVM for Azure VMs | 15 | T | VA status/remediation |
| Discover assets/vulnerabilities with Defender EASM | 19 | T/S | authorized domain inventory and deletion |
| Create/connect Sentinel workspace | 28 | H | workspace in Defender portal |
| Assign Sentinel roles | 28 | H | Reader/Responder/Contributor/Playbook scopes |
| Use Content hub solutions | 28 | H | installed solution inventory |
| Configure Microsoft data connectors | 28 | H/T | Azure Activity, Defender, optional XDR |
| Configure Syslog and CEF | 29 | H/S | DCR/forwarder configuration or design |
| Windows Security Events and WEF | 29 | H/S | DCR and WEF flow |
| Custom log tables | 28 | H | custom table and five records |
| Automation rules and playbooks | 29 | H | benign incident automation/managed identity |
| Sentinel data-store retention | 28 | H/S | Analytics settings plus optional lake job |
| Query Purview Audit in Defender XDR | 29 | T/S | agent/SharePoint audit correlation |
| Configure Security Copilot workspaces | 30 | T/optional paid/S | workspace/capacity runbook |
| Manage Security Copilot permissions/roles | 30 | T/S | least-privilege role matrix |
| Enable/configure plugins | 30 | T/S | required plugin set and validation |
| Enable/configure Microsoft and Security Store agents | 30 | T/S | reviewed agent and low-risk enablement design |

## Known gaps that are intentionally simulated

The plan covers every listed objective, but it does not pretend that Azure credit includes every entitlement. The main simulation lanes are Microsoft 365/Agent 365/Purview features, Entra Private Access, multicloud connectors without owned accounts, persistent gateways, and Security Copilot without included SCUs. Evidence must say **simulated** when a control was not deployed.

