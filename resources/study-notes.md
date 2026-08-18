# SC-500 study notes

## Exam shape

The official blueprint checked on 2026-08-18 has four domains:

| Domain | Weight |
|---|---:|
| Manage identity, access, and governance | 20-25% |
| Secure storage, databases, and networking | 25-30% |
| Secure compute | 20-25% |
| Manage and monitor security posture | 20-25% |

The exam expects practical Azure and hybrid administration across compute, network, and storage, strong Entra ID familiarity, and familiarity with Microsoft 365 administration. Most questions target generally available features, but commonly used preview features may appear.

## Mental model

For every scenario, identify five boundaries before choosing a service:

1. **Identity** - human, application, managed identity, agent identity, or external identity?
2. **Plane** - management plane, data plane, control plane, runtime traffic, or monitoring plane?
3. **Network** - public endpoint, service endpoint, private endpoint, Private Link Service, or gateway?
4. **Protection type** - posture assessment, threat detection, prevention/guardrail, vulnerability management, or incident response?
5. **Entitlement and cost** - free foundation, plan trial, metered add-on, Microsoft 365 license, or provisioned capacity?

## Frequently confused distinctions

| A | B | Exam-relevant difference |
|---|---|---|
| Azure RBAC role | Microsoft Entra role | Azure resources vs tenant/directory administration |
| Management-plane Contributor | Storage Blob Data Contributor | Resource configuration vs blob contents |
| Key Vault RBAC | Key Vault access policy | Modern Azure RBAC authorization vs legacy vault-specific policy model |
| Service endpoint | Private endpoint | Public service endpoint constrained to VNet identity vs a private IP in your VNet |
| Private endpoint | Private Link Service | Consume a PaaS/private service vs publish your own service privately |
| NSG | Azure Firewall | Distributed L3/L4 allow/deny vs centralized stateful network/application filtering and threat intelligence |
| ASG | NSG | Workload grouping label vs rule enforcement object |
| Foundational CSPM | Defender CSPM | Free assessment/Secure Score vs attack paths, agentless and data-aware advanced posture |
| Defender workload plan | CSPM | Runtime threat protection for a workload vs misconfiguration and exposure management |
| Defender for AI Services | Foundry guardrails | Runtime threat detection vs inline prevention/control at model or agent interaction points |
| Foundry evaluation | AI Red Teaming Agent | Measure known quality/safety criteria on a dataset vs generate adversarial probes and attack strategies |
| Purview DSPM | Defender Data and AI dashboard | Microsoft 365/data governance and AI-use risks vs Azure cloud data/AI posture and workload protection |
| Agent ID | Managed identity | Identity and governance for AI agents vs workload authentication to Azure resources |
| Sentinel Analytics tier | Sentinel data lake tier | Real-time detections/hunting vs low-cost long-term retention and asynchronous jobs |
| Security Copilot | Microsoft 365 Copilot | Security operations reasoning/agents vs productivity assistance |

## Portal drift to expect

- Azure AI Foundry is now Microsoft Foundry. Some pages still show old names.
- Foundry roles were renamed; role IDs remained the same.
- Agent Registry/Collections in the Entra portal were retired. Comprehensive agent inventory is in Microsoft 365/Agent 365.
- Agent-level posture moved toward Agent 365 in July 2026, while Defender CSPM still discovers Foundry accounts and projects.
- Sentinel administration increasingly occurs in the Microsoft Defender portal, although Azure resources and Log Analytics remain part of the implementation.
- Defender recommendation groupings and counts can change as Microsoft moves toward individual findings.

## How to study each completed lab

After the hands-on work, answer these without looking:

1. What business risk did the control reduce?
2. Which identity needed which role at which scope?
3. What test proved allowed behavior?
4. What test proved denied behavior?
5. What signal proves the control is operating?
6. Which related service would be wrong, and why?
7. What is the cost or license boundary?
8. How is the control safely removed or recovered?

Then write one scenario question that changes a single constraint such as data residency, scale, identity type, latency, or budget.

