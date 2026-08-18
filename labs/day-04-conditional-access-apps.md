# Day 4 - Conditional Access, application identity, and consent

**Time:** 90-120 minutes  
**Mode:** Trial-dependent for Conditional Access; app work hands-on  
**SC-500:** Conditional Access, app registrations, enterprise apps, OAuth grants and consent

## Business request

NCES wants strong controls for administrators and cannot allow users to grant high-risk OAuth permissions. Pathfinder needs an application identity, but its developers must not create a long-lived client secret.

## Conditional Access

Create these in **Report-only** first and exclude both monitored emergency accounts:

1. `CA-Admins-PhishingResistant` - target privileged roles, require the phishing-resistant authentication strength.
2. `CA-All-BlockLegacyAuth` - target all users, block legacy authentication clients.
3. `CA-Lab-RiskySignIn` - if P2 exists, require MFA for medium/high sign-in risk.

Use **What If** for a normal user, admin, emergency user, and legacy client. Review report-only sign-in results before enabling only the safe admin pilot policy.

## Application and consent

1. Register `Pathfinder-Case-API` as single tenant.
2. Define one delegated scope, `Case.Read`, and one application role, `Case.Process`.
3. Inspect the corresponding enterprise application/service principal.
4. Do not create a client secret. Record federated credential or managed identity as the production choice.
5. Configure user consent to block unverified/high-impact permissions. If available, create an admin-consent workflow with `security.operator` as reviewer.
6. Create a harmless test enterprise app permission request, review it, grant only the minimum permission, then revoke the grant.
7. Inspect audit logs for app creation, consent, grant, and revocation.

## Failure tests

- A developer cannot grant tenant-wide admin consent.
- A report-only policy predicts the legacy client will be blocked.
- The revoked OAuth grant is absent from permissions.

## Evidence and decision

Export policy summaries, What If results, the app's scopes/roles, consent settings, and a decision record comparing client secret, certificate, federated identity, and managed identity.

## Sources

- [Plan Conditional Access](https://learn.microsoft.com/entra/identity/conditional-access/plan-conditional-access)
- [Conditional Access authentication strengths](https://learn.microsoft.com/entra/identity/conditional-access/concept-authentication-strengths)
- [App registrations and service principals](https://learn.microsoft.com/entra/identity-platform/app-objects-and-service-principals)
- [Consent framework](https://learn.microsoft.com/entra/identity/enterprise-apps/user-admin-consent-overview)

