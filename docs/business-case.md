# NCES business case

## Company

Northstar Community Employment Services is a fictional nonprofit with five offices in British Columbia, 180 employees, 70 contractors, and about 22,000 active clients. It helps job seekers prepare resumes, communicate with employers, and access government-funded employment programs.

The legacy case-management system uses local file servers, shared administrator accounts, public SQL endpoints, and a manually reviewed nightly security log export. NCES has approved a 12-week proof of concept for **Pathfinder**, an Azure-hosted replacement.

## Pathfinder workload

Pathfinder has four logical components:

- a public partner portal;
- an internal case-management application;
- a document service for resumes, assessments, and case attachments;
- an AI agent that summarizes synthetic case notes and suggests resources from an approved knowledge base.

The 30-day lab implements the security controls around these components. It does not build a complete business application.

## Business requirements

| ID | Requirement | Security consequence |
|---|---|---|
| BR-01 | Production client data must remain in approved Canadian regions under a funding-contract condition. | Canada Central is primary and Canada East is the production DR design. East US 2 may be used only for synthetic AI test data when a feature is unavailable in Canada. |
| BR-02 | No Storage, SQL, Key Vault, or production Foundry data endpoint may be directly reachable from the public internet. | Use private endpoints, Private DNS, selected networks, and explicit public-network denial. |
| BR-03 | Administrators must use passwordless MFA and time-bound privilege. | Use authentication strengths, Conditional Access, PIM, separate admin accounts, and emergency access exclusions. |
| BR-04 | Applications and pods must not store credentials in configuration or images. | Use managed identities, AKS workload identity, and Key Vault CSI. |
| BR-05 | Contractor access ends automatically and cannot grant OAuth consent. | Use group-based access, access lifecycle decisions, consent restrictions, and periodic review design. |
| BR-06 | Security-relevant logs need 90 days of fast investigation access. Verbose network data needs 13 months at lower cost. Contract audit evidence is retained for seven years. | Use Sentinel Analytics tier for high-value tables and Data Lake total retention for long-lived data. |
| BR-07 | AI output must not expose sensitive data, follow instructions hidden in uploaded documents, or produce ungrounded employment-policy claims. | Use content filters, Prompt Shields, groundedness evaluation, Purview DSPM, Defender for AI Services, and AI red teaming. |
| BR-08 | Security must be centrally measurable and mapped to a recognized baseline. | Use Azure Policy, Microsoft cloud security benchmark, Defender for Cloud Secure Score, recommendations, attack paths, and regulatory compliance. |
| BR-09 | A compromised application identity must have a small blast radius. | Use one identity per workload, least-privilege data-plane roles, network isolation, short-lived tokens, and attack-path review. |
| BR-10 | The proof of concept cannot exceed the free USD $200 promotional credit. | Use free/trial tiers, short burst deployments, daily cost review, small synthetic datasets, and immediate cleanup. |

## Nonfunctional targets

- Production design availability target: 99.9 percent for the public portal.
- Recovery point objective: one hour for case data.
- Recovery time objective: four hours for the core service.
- Maximum proof-of-concept ingestion: 500 MB across Sentinel and diagnostics.
- Maximum synthetic AI dataset: 100 records with no real personal data.
- No standing Owner, User Access Administrator, Global Administrator, or privileged workload permissions after setup.
- All exceptions require an owner, expiry date, and documented compensating control.

## Budget decision

The fictional production target is C$5,000 per month for platform services, with no more than C$1,200 per month allocated to incremental security services before volume-dependent logging and scanning. This is not a quote. The lab uses the Azure portal cost calculator and the Defender for Cloud cost calculator to produce a current estimate from actual resources.

The POC favors:

- platform services over always-on VMs;
- consumption or free tiers where they meet the test objective;
- foundational CSPM for continuous free assessment plus a 30-day Defender CSPM evaluation;
- Microsoft-managed encryption by default and customer-managed keys only where a business requirement justifies lifecycle overhead;
- native workload identity over stored secrets;
- Sentinel data lake retention for high-volume, lower-value data rather than keeping everything in the Analytics tier.

## Roles you perform

You will switch between these perspectives:

- **Cloud security engineer** - implements identity, network, data, compute, and posture controls.
- **Platform engineer** - deploys Bicep, networking, AKS, App Service, and monitoring foundations.
- **AI security engineer** - configures guardrails, evaluations, red teaming, gateway policies, and threat protection.
- **SOC analyst** - validates Defender and Sentinel signals and investigates the capstone incident.
- **Security architect** - records exceptions, cost decisions, data residency tradeoffs, and residual risk.

## Definition of done

At the end of day 30, NCES expects:

- a defensible architecture and control map;
- working evidence for the controls that the lab entitlement supports;
- a documented licensing gap for controls that require separate Microsoft 365 entitlements;
- a prioritized remediation backlog from Defender, Sentinel, and AI red teaming;
- proof that all paid lab capacity and resource groups were removed or intentionally retained.

