# Licensing and lab modes

Verified on **2026-08-18** against Microsoft primary documentation.

## Why three modes exist

The Azure USD $200 promotional credit covers Azure consumption. It does not automatically grant Microsoft 365 E5/E7, Microsoft Purview Suite, Microsoft Agent 365, Copilot Studio, or unlimited Security Copilot capacity. A realistic SC-500 lab must identify those boundaries instead of claiming every portal is included.

## Modes

### Hands-on

The Azure free account or a Defender for Cloud plan trial is sufficient. You deploy, test, collect evidence, and clean up the control.

### Trial-dependent

The task is hands-on only if the associated tenant is eligible and exposes the trial. Trial availability can differ by tenant and geography. The lab includes an alternate guided path and never requires purchasing a license.

### Guided simulation

You work from the current Microsoft portal flow and documentation, create the policy/decision artifact, and explain expected verification. You must label the evidence **simulated**, not deployed.

## Entitlement matrix

| Capability | Current boundary | Lab treatment |
|---|---|---|
| Azure free account | New customers get USD $200 for up to 30 days and spending protection until they explicitly move to pay-as-you-go. | Core lab subscription |
| Defender for Cloud plans | Each newly activated plan receives a 30-day trial or until a plan-specific usage cap is reached. | Enable deliberately after the day 1 baseline |
| Defender for Storage malware scanning | Not included in the general 30-day Defender trial and bills from day one. | Resource-level enablement with a low monthly scan cap and tiny files |
| Defender for AI Services | 30-day trial, capped at 75 billion scanned tokens before billing begins. | Enable for the synthetic Foundry resource |
| Conditional Access | Microsoft Entra ID P1 or P2, or an eligible trial. Risk-based policy needs P2. | Trial-dependent with report-only policies |
| PIM | Microsoft Entra ID P2 or Microsoft Entra ID Governance licensing for governed users. | Trial-dependent; RBAC exercise remains hands-on |
| Purview DSPM | Microsoft 365 E5 or Microsoft Purview Suite. An eligible Purview trial can provide 25 licenses for 90 days. | Trial-dependent/simulation |
| Conditional Access for agents | Entra ID P1/P2 plus Microsoft Agent 365 per user; network controls also require Entra Internet Access. | Guided simulation unless licensed |
| Copilot Studio agent real-time protection | Requires the relevant Copilot Studio and Microsoft security entitlements and an agent with traffic. | Guided simulation or existing trial tenant |
| Security Copilot | Microsoft 365 E5/E7 inclusion is tenant-rollout dependent; otherwise at least one provisioned SCU is required. Provisioned capacity is billed hourly. | Simulate by default; optional one-hour capstone |
| AI Gateway created from Foundry | Microsoft documents a free allowance of up to 100,000 requests when eligible and created as a Foundry AI Gateway; integration remains preview. | Hands-on if exposed, otherwise APIM policy design |
| AI Red Teaming Agent | Availability and supported targets/regions are limited; some paths remain preview. | East US 2 synthetic workload, with a manual fallback |
| Entra Kerberos cloud-only identities for Azure Files | Supported by current documentation but with regional and preview limitations. | Attempt only in a documented supported region and record the result |

## Activation order

1. Start the Azure free account on day 1.
2. Confirm available Entra and Microsoft 365 trials before changing anything.
3. Start Entra P2/P1 only when day 2 begins.
4. Enable individual Defender plans immediately before their relevant labs, not all at signup.
5. Start any Purview trial close to day 27.
6. Provision Security Copilot only during day 30, if you deliberately choose the paid one-hour lane.

Defender plan trials cannot be paused or extended. Security Copilot capacity continues billing while provisioned, even when you are not prompting it.

## Source links

- [Azure free account](https://azure.microsoft.com/pricing/purchase-options/azure-account)
- [Defender for Cloud free-trial behavior](https://learn.microsoft.com/azure/defender-for-cloud/free-trial)
- [Defender for Storage FAQ](https://learn.microsoft.com/azure/defender-for-cloud/faq-defender-for-storage)
- [Defender for AI Services](https://learn.microsoft.com/azure/defender-for-cloud/ai-threat-protection)
- [Conditional Access deployment prerequisites](https://learn.microsoft.com/entra/identity/conditional-access/plan-conditional-access)
- [Conditional Access for agents](https://learn.microsoft.com/entra/identity/conditional-access/agent-id)
- [Purview DSPM prerequisites](https://learn.microsoft.com/purview/data-security-posture-management-get-started)
- [Purview Suite trial](https://learn.microsoft.com/purview/purview-trial)
- [Security Copilot onboarding](https://learn.microsoft.com/copilot/security/manual-onboarding)
- [Security Copilot SCU billing](https://learn.microsoft.com/copilot/security/security-compute-units-capacity)
- [Foundry AI Gateway configuration](https://learn.microsoft.com/azure/foundry/configuration/enable-ai-api-management-gateway-portal)
- [AI Red Teaming Agent](https://learn.microsoft.com/azure/foundry/concepts/ai-red-teaming-agent)
- [Entra Kerberos for Azure Files](https://learn.microsoft.com/azure/storage/files/storage-files-identity-auth-hybrid-identities-enable)

