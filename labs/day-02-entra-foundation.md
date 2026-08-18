# Day 2 - Microsoft Entra identity foundation

**Time:** 90 minutes  
**Mode:** Hands-on with Entra trial-dependent controls  
**SC-500:** authentication methods, MFA, passwordless, role separation

## Business request

NCES needs separate user, developer, operations, and emergency-access identities. Admins must use phishing-resistant authentication where possible, and help desk staff must not become tenant administrators.

## Build

1. Record the tenant license. Start an eligible Entra ID P2 trial only if the portal offers it. Add its expiry to your calendar.
2. Create synthetic users:
   - `alex.counsellor`
   - `dev.pathfinder`
   - `platform.operator`
   - `security.operator`
   - two cloud-only emergency-access accounts with long random credentials stored offline
3. Create groups:
   - `GRP-Pathfinder-Users`
   - `GRP-Pathfinder-Developers`
   - `GRP-Platform-Ops`
   - `GRP-Cloud-SecOps`
4. Keep privileged role groups separate from application-access groups. Do not make a dynamic group for emergency access.
5. In **Protection > Authentication methods**, enable Microsoft Authenticator, Temporary Access Pass, and passkeys/FIDO2 for a small pilot group.
6. Issue a short-lived Temporary Access Pass to `security.operator`. Use it to register Authenticator or a passkey, then verify that the TAP expires.
7. Create one authentication strength that permits phishing-resistant methods only.
8. Review registration and audit logs. Create an alerting decision for any emergency account sign-in.

## Failure tests

- Confirm an ordinary user cannot open a privileged Entra blade.
- Confirm the expired TAP cannot be reused.
- Confirm SMS is not part of the phishing-resistant strength.

## Security decisions

- Emergency accounts are excluded from broad Conditional Access only to prevent total lockout, but their use must create a high-priority alert.
- Authentication method registration is scoped to a pilot before tenant-wide rollout.
- Role assignment happens in day 3 so identity creation and privilege approval are separate actions.

## Cost and cleanup

No Azure consumption. Keep synthetic users/groups through day 30. Before an Entra trial ends, remove lab PIM assignments and policies that depend on the license.

## Evidence

Capture method-policy scope, TAP lifetime, successful passwordless registration, failed expired TAP, group membership, and emergency-account monitoring design. Redact UPN domains.

## Sources

- [Authentication methods](https://learn.microsoft.com/entra/identity/authentication/concept-authentication-methods)
- [Temporary Access Pass](https://learn.microsoft.com/entra/identity/authentication/howto-authentication-temporary-access-pass)
- [Authentication strengths](https://learn.microsoft.com/entra/identity/authentication/concept-authentication-strengths)
- [Emergency access accounts](https://learn.microsoft.com/entra/identity/role-based-access-control/security-emergency-access)

