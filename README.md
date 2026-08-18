# SC-500 30-Day Cloud and AI Security Lab

This repository is a from-scratch, 30-day implementation project for **Exam SC-500: Implementing End-to-End Security Controls for Cloud and AI Workloads**. Each lab is designed for 60-120 minutes and contributes to one realistic company environment instead of creating disconnected demo resources.

The plan was checked against the [official SC-500 study guide](https://learn.microsoft.com/credentials/certifications/resources/study-guides/sc-500) on **2026-08-18**. Microsoft can change preview features, product names, portal paths, regional availability, quotas, and licensing. Each lab links to the primary documentation used to verify it.

## Project scenario

You are the cloud security engineer for **Northstar Community Employment Services (NCES)**, a fictional British Columbia nonprofit. NCES is replacing a legacy case-management system with a cloud platform called **Pathfinder**. Pathfinder stores resumes and case notes, exposes a partner portal, and uses an AI agent to summarize case notes and suggest employment resources.

The proof of concept must:

- fit within the Azure free account's USD $200 credit for the first 30 days;
- keep production-design data in Canada, while using synthetic data for AI features that require another region;
- implement least privilege, passwordless administration, private PaaS access, workload identities, and centralized monitoring;
- protect Azure Storage, Key Vault, SQL, servers, containers, and AI services with current Defender for Cloud plans;
- demonstrate Foundry guardrails, evaluations, AI red teaming, AI Gateway, Defender for AI Services, and the Data and AI security dashboard;
- demonstrate or simulate Microsoft 365 features whose licenses are not included in the Azure credit.

Read [the complete business case](docs/business-case.md) and [target architecture](docs/architecture.md) before starting.

## Before day 1

You need:

- a new Azure free account with the USD $200/30-day promotional credit;
- an account that is Owner on the lab subscription and Global Administrator in the associated test tenant;
- Azure Cloud Shell with Bash, or local Azure CLI and PowerShell 7;
- Git for evidence and Infrastructure as Code exercises;
- a FIDO2 security key or Microsoft Authenticator for passwordless work, if available;
- only synthetic identities and data. Never put real client information in this lab.

Optional trials are documented in [licensing and lab modes](docs/licensing-and-lab-modes.md). Do not buy a Microsoft 365 or Security Copilot license just to finish this project.

## Operating rules

1. Complete the labs in order. Some resources are reused for several days.
2. Run the cost check at the beginning and end of every session.
3. Stop or delete burst-cost resources at the exact checkpoint in the lab.
4. Save the requested evidence without secrets, access tokens, connection strings, or tenant identifiers.
5. Use the **hands-on**, **trial-dependent**, or **guided simulation** lane stated in each lab.
6. If a portal label differs, search for the service named in the lab and confirm behavior in the linked Microsoft documentation.
7. Finish day 30 even if you stop early. It disables Defender plans, deletes resources, and verifies that no paid capacity remains.

Azure's free account has spending protection unless you explicitly upgrade. Budgets are alerts, not hard spending caps. See [cost control and teardown](docs/cost-control.md).

## 30-day schedule

| Day | Lab | Primary outcome | Mode |
|---:|---|---|---|
| 01 | [Subscription safety and landing zone](labs/day-01-subscription-safety.md) | Budget, providers, naming, resource groups, evidence baseline | Hands-on |
| 02 | [Entra identity foundation](labs/day-02-entra-foundation.md) | Users, groups, authentication methods, break-glass design | Hands-on + trial |
| 03 | [PIM, RBAC, and custom roles](labs/day-03-pim-rbac.md) | Eligible admin access and least-privilege Azure roles | Trial-dependent |
| 04 | [Conditional Access, apps, and consent](labs/day-04-conditional-access-apps.md) | MFA/passwordless policy, app registration, consent governance | Trial-dependent |
| 05 | [Policy, compliance, backup, and IaC](labs/day-05-governance-iac.md) | Policy initiative, remediation, locks, backup controls, Bicep | Hands-on |
| 06 | [Hub-spoke network foundation](labs/day-06-network-foundation.md) | Segmented virtual networks and flow design | Hands-on |
| 07 | [NSGs, ASGs, and Network Watcher](labs/day-07-nsg-asg-network-watcher.md) | Effective rules and reachability diagnostics | Hands-on |
| 08 | [Private endpoints and Private DNS](labs/day-08-private-endpoints-dns.md) | Private Storage access with correct DNS resolution | Hands-on |
| 09 | [Storage authorization and Entra Kerberos](labs/day-09-storage-auth-kerberos.md) | RBAC, SAS, shared-key denial, Azure Files identity | Hands-on + preview |
| 10 | [Key Vault lifecycle and workload identity](labs/day-10-key-vault.md) | Keys, secrets, certificates, rotation, firewall, managed identity | Hands-on |
| 11 | [Azure SQL security](labs/day-11-sql-security.md) | Entra admin, auditing, TDE, Always Encrypted design, Defender | Hands-on |
| 12 | [Enterprise network controls](labs/day-12-enterprise-network-controls.md) | Firewall, VPN, Virtual WAN, VNet Manager, Private Link comparison | Cost-burst + simulation |
| 13 | [Secure application platform services](labs/day-13-app-platform.md) | App Service/Functions/Logic Apps authentication and networking | Hands-on |
| 14 | [Secure VM, Bastion, encryption, and JIT](labs/day-14-secure-vm.md) | Trusted launch VM with controlled administrative access | Cost-burst |
| 15 | [Defender for Servers, MDVM, Arc, and Machine Configuration](labs/day-15-defender-servers.md) | Server protection and hybrid-control decisions | Hands-on + simulation |
| 16 | [ACR and AKS security baseline](labs/day-16-aks-acr-baseline.md) | Private images, Kubernetes RBAC, network and policy baseline | Cost-burst |
| 17 | [AKS workload identity and Key Vault CSI](labs/day-17-aks-key-vault-csi.md) | Pod access to Key Vault without embedded credentials | Cost-burst |
| 18 | [Defender for Containers](labs/day-18-defender-containers.md) | Posture, sensor, vulnerability, and runtime coverage | Trial + cost-burst |
| 19 | [Defender CSPM and regulatory compliance](labs/day-19-defender-cspm.md) | Attack paths, agentless scanning, secret findings, standards | Trial |
| 20 | [Defender workload protection plans](labs/day-20-defender-workload-plans.md) | Storage, Key Vault, SQL, Resource Manager, DNS, and AI protection | Trial + metered add-on |
| 21 | [Microsoft Foundry secure foundation](labs/day-21-foundry-foundation.md) | Foundry project, model, RBAC, managed identity, network design | Hands-on |
| 22 | [Content filters, Prompt Shields, and groundedness](labs/day-22-ai-guardrails.md) | Prevent direct and indirect prompt attacks | Hands-on |
| 23 | [Foundry evaluations](labs/day-23-foundry-evaluations.md) | Quality and risk/safety evaluation evidence | Hands-on |
| 24 | [AI Red Teaming Agent](labs/day-24-ai-red-teaming.md) | Automated adversarial scan and remediation backlog | Hands-on + preview |
| 25 | [AI Gateway with API Management](labs/day-25-ai-gateway.md) | Central auth, quota, token limiting, logging, and backend policy | Hands-on + preview |
| 26 | [Defender for AI Services and AI security dashboard](labs/day-26-defender-ai-dashboard.md) | AI posture, attack paths, alerts, and workload protection | Trial |
| 27 | [Purview DSPM, Copilot Studio, and Entra Agent ID](labs/day-27-m365-ai-administration.md) | Data overexposure and agent identity governance | Trial-dependent/simulation |
| 28 | [Sentinel onboarding, connectors, and data tiers](labs/day-28-sentinel-data-tiers.md) | Analytics vs data lake retention and custom ingestion | Hands-on |
| 29 | [Sentinel detections and automation](labs/day-29-sentinel-detections.md) | Content Hub, KQL, analytics, Syslog/CEF/WEF, playbook | Hands-on + simulation |
| 30 | [Security Copilot capstone and teardown](labs/day-30-capstone-teardown.md) | End-to-end incident, Copilot administration, evidence, zero-cost exit | Optional paid hour + simulation |

## Repository map

```text
.
├── README.md
├── docs/
│   ├── architecture.md
│   ├── business-case.md
│   ├── cost-control.md
│   ├── coverage-matrix.md
│   └── licensing-and-lab-modes.md
├── labs/
│   └── day-01 ... day-30
├── resources/
│   ├── current-links.md
│   └── study-notes.md
├── scripts/
│   ├── bootstrap.sh
│   └── teardown.sh
└── templates/
    ├── decision-record.md
    └── evidence-log.md
```

## Completion standard

A lab is complete only when you can:

- explain the business control it implements;
- prove the control works with a success test and a failure test;
- state its data-plane and management-plane authorization paths;
- identify its cost and licensing boundary;
- save sanitized evidence;
- explain how you would operate or monitor it in production.

Use [the coverage matrix](docs/coverage-matrix.md) to track the official objectives and [the evidence template](templates/evidence-log.md) to build a portfolio-safe record.

## Current-source policy

Microsoft primary documentation is authoritative for this project. PDFs that previously lived in `Labs/` and `Resources/` have been moved to `archive/legacy-pdfs/` because they are static snapshots and can age silently. The live [resources index](resources/current-links.md) is the maintained source list.
