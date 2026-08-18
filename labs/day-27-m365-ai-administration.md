# Day 27 - Purview DSPM, Copilot Studio, and Entra Agent ID

**Time:** 90-120 minutes  
**Mode:** Trial-dependent or guided simulation  
**SC-500:** SharePoint exposure, DSPM, real-time agent protection, Agent ID CA/access/blast radius, M365 agent management

## Entitlement checkpoint

Azure credit does not grant Microsoft 365 E5, Purview Suite, Agent 365, Copilot Studio, or agent Conditional Access. Record exact licenses. Use only trials offered to your tenant. Label nonexecuted steps simulated.

## Station 1 - SharePoint and Purview DSPM

If an eligible tenant/trial exists:

1. Create a SharePoint lab site with synthetic case documents and one intentionally overshared file.
2. Enable/review Purview Audit.
3. In current Microsoft Purview DSPM, review the SharePoint data-risk assessment, AI app/activity risks, and recommendations after data processing time.
4. Create an audit-mode DLP policy for fictional client identifiers used with AI apps.
5. Remediate oversharing and observe posture change.

Without licensing, create the data inventory, sharing graph, DLP rule, expected events, and remediation plan from current docs.

## Station 2 - Agent ID

1. Assign Agent ID Developer and Agent ID Administrator to separate synthetic admins where the base feature is available.
2. Create a `Pathfinder Case Summary` blueprint with technical owner, business sponsor, audience, and description.
3. Create two agent identities, compare blueprint vs identity permissions, inspect audit/sign-in filters, then disable one identity.
4. Prefer federated credentials over client secrets.
5. If Agent 365 plus Entra P1/P2 is licensed, create a **report-only** Conditional Access policy for agent identities. Otherwise write the policy design and licensing gap.
6. In Defender XDR, use current agent inventory/activity tables such as `AgentsInfo` and `BehaviorInfo` where present to trace identity, permissions, data, and affected resources. Document blast radius.

## Station 3 - Agent administration and real-time protection

1. In Microsoft 365 admin center **Agents > Registry**, export inventory and identify an ownerless/unmanaged or excessive-permission lab agent.
2. Assign owner/sponsor, review publisher/channel/data sources, and block only the synthetic unmanaged agent.
3. In current Defender XDR/Agent 365 experience, configure an audit-first real-time policy for a Copilot Studio lab agent, then review how blocking would be staged.
4. Open the tenant-wide **Security Dashboard for AI** and compare it with Defender for Cloud's Data and AI dashboard.

## Current product note

The old Agent Registry/Collections blades in Entra were retired in 2026. Comprehensive registry/admin work is now in Microsoft 365/Agent 365, while Entra focuses on agent identities. Do not follow stale screenshots that query `AIAgentsInfo` when current documentation uses `AgentsInfo`.

## Sources

- [Purview DSPM prerequisites](https://learn.microsoft.com/purview/data-security-posture-management-get-started)
- [Agent identities](https://learn.microsoft.com/entra/agent-id/what-are-agent-identities)
- [Conditional Access for agents](https://learn.microsoft.com/entra/identity/conditional-access/agent-id)
- [Agent Registry](https://learn.microsoft.com/microsoft-365/admin/manage/agent-registry)
- [Real-time agent protection](https://learn.microsoft.com/defender-xdr/security-for-ai/ai-agent-real-time-protection)
- [Security Dashboard for AI](https://learn.microsoft.com/security/security-for-ai/security-dashboard-for-ai)

