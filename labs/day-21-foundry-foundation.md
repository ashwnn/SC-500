# Day 21 - Microsoft Foundry secure foundation

**Time:** 90-120 minutes  
**Mode:** Hands-on when quota exists; no-quota fallback provided  
**SC-500:** secure AI foundation, identities, access, network and cost controls

## Business request

NCES is piloting `Pathfinder Case Summary Agent`. Operational client data stays in Canada. Specialized safety testing uses an East US 2 purple project with 20 synthetic case records because that region supports the broadest common evaluation/red-team feature set.

## Build

1. In `rg-sc500-ai-eus2`, create a current Microsoft Foundry account/project named for `case-agent-purple`.
2. Record the processing region, resource endpoints, public-network state, managed identity, diagnostic destinations, quota, and available model deployment types.
3. Use the current least-privilege role names:
   - Foundry Account Owner for the security/platform owner only;
   - Foundry Project Manager for project administration;
   - Foundry User for the developer/runtime user.
4. Deploy the smallest suitable **pay-per-token** model the portal actually offers. Do not hard-code a family that may be unavailable or retired. Never choose provisioned throughput for this lab.
5. Create a 20-record JSONL/CSV dataset containing only fictional case notes, policy context, expected answers, and prohibited-action cases.
6. Create a prompt agent with no destructive tools. Its instructions must:
   - answer only employment-service policy questions;
   - never return full identifiers;
   - say when context is insufficient;
   - refuse deletion, payment, or account-management actions.
7. Test normal, out-of-scope, ambiguous, and missing-context requests. Capture baseline failures for days 22-24.
8. Review private networking. Do not add AI Search, Cosmos DB, hosted-agent containers, or private dependencies solely for a diagram. Record the production private-link design separately.

## No-quota fallback

If model deployment is blocked:

- capture the quota/error and subscription type;
- build the project, RBAC, dataset, agent/system prompt, and deployment decision record;
- use a fixed local callback/sample outputs for evaluation/red-team workflow where supported;
- do not claim live inference.

## Verification

- Developer can use only the project, not reconfigure the Foundry account.
- No API key appears in code/evidence.
- Dataset contains no real data.
- Cost analysis shows only metered calls you intentionally generated.

## Sources

- [Foundry GA overview](https://learn.microsoft.com/azure/foundry/concepts/general-availability)
- [Foundry RBAC](https://learn.microsoft.com/azure/foundry/concepts/rbac-foundry)
- [Foundry quota](https://learn.microsoft.com/azure/foundry/openai/quotas-limits)
- [Evaluation regions](https://learn.microsoft.com/azure/foundry/concepts/evaluation-regions-limits-virtual-network)

