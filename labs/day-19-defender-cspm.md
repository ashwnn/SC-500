# Day 19 - Defender CSPM, compliance, multicloud, and EASM

**Time:** 90-120 minutes  
**Mode:** Defender CSPM trial; multicloud simulation unless accounts already exist  
**SC-500:** risks, standards, recommendations, attack paths, multicloud, EASM, overprivileged access

## Business request

The CISO wants prioritized exposure, not a flat list of misconfigurations. Findings must map to an owner and standard, and security must understand the path from internet exposure to sensitive data.

## Tasks

1. Compare Foundational CSPM with Defender CSPM. Confirm advanced plan trial and agentless components.
2. Review Secure Score, inventory, recommendations, governance rules, and Microsoft cloud security benchmark.
3. Add one relevant regulatory standard and document which controls are NCES contractual choices rather than claims about law.
4. In Cloud Security Explorer, query for:
   - internet-exposed resources;
   - public PaaS endpoints;
   - high-privilege identities;
   - secrets or sensitive-data findings when available.
5. Inspect attack paths. If none appear, explain prerequisites and do not manufacture unsafe exposure merely to create one.
6. Assign one recommendation to an owner with due date, remediate it, and record score/status lag.
7. Review overprivileged access findings and reduce one role scope where safe.
8. Walk AWS and GCP connector creation, including permission templates, Defender plans, and data-collection scope. Connect only an account you own and can safely clean up; otherwise finish a multicloud decision record.
9. Optional: create a Defender EASM resource, seed only a domain you own, inspect billable assets, then delete before trial expiry. Never scan a third-party domain without authorization.

## Evidence

Before/after recommendation, security standard view, one Cloud Security Explorer query, attack-path explanation, governance assignment, RBAC remediation, and multicloud/EASM cleanup plan.

## Sources

- [CSPM plans](https://learn.microsoft.com/azure/defender-for-cloud/concept-cloud-security-posture-management)
- [Attack paths](https://learn.microsoft.com/azure/defender-for-cloud/how-to-manage-attack-path)
- [Regulatory compliance](https://learn.microsoft.com/azure/defender-for-cloud/regulatory-compliance-dashboard)
- [Connect AWS](https://learn.microsoft.com/azure/defender-for-cloud/quickstart-onboard-aws)
- [Defender EASM](https://learn.microsoft.com/azure/external-attack-surface-management/overview)

