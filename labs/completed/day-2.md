# Day 2 - Microsoft Entra Identity Foundation Evidence Log

## Session

* **Lab:** Day 2 - Microsoft Entra identity foundation
* **Date:** August 19, 2026
* **Mode:** Hands-on with Entra trial-dependent controls
* **Tenant:** Dedicated SC-500 lab tenant
* **Primary focus:** Authentication methods, MFA, phishing-resistant authentication, role separation, and emergency access
* **Azure consumption:** None

## Cost checkpoint

* **Azure resources deployed:** None
* **Material Azure consumption:** None
* **Unexpected meters:** None expected from the Day 2 identity configuration
* **Action:** Retain the synthetic identities and groups for subsequent labs

Day 2 was primarily a Microsoft Entra configuration exercise and did not deploy billable Azure infrastructure.

## Business control

* **Requirement:** NCES requires separate user, developer, platform operations, security operations, administrative, and emergency-access identities. Administrative authentication should support phishing-resistant methods where practical.
* **Threat or failure mode:** Shared administrative identities, excessive privilege, weak MFA enrollment, loss of tenant access caused by Conditional Access misconfiguration, and unmonitored use of emergency credentials.
* **Control selected:** Separate cloud identities and security groups, Microsoft Entra authentication-method policies, Temporary Access Pass bootstrap, phishing-resistant authentication strength, dedicated emergency-access accounts, and audit/sign-in monitoring.
* **Why this control fits:** Identity controls are established before privileged role assignment. This separates normal identity creation from later PIM and RBAC decisions and reduces the chance that ordinary business accounts accidentally receive administrative privilege.
* **Rejected alternative:** Using normal business identities as permanent administrators. NCES instead separates administrative and workload identities from ordinary user accounts.

## Implementation

### Tenant-native administrative identity

A dedicated cloud-only administrative identity was created:

```text
James McGill (Global Admin)
```

This account provides a tenant-native administrative identity for Microsoft Entra administration instead of relying exclusively on the original consumer-linked Azure account.

The administrative UPN and tenant domain are intentionally omitted from this public evidence log.

### Synthetic identities

The following synthetic NCES identities were created:

| Identity            | Purpose                                        |
| ------------------- | ---------------------------------------------- |
| `alex.counsellor`   | Pathfinder business user / counsellor          |
| `dev.pathfinder`    | Pathfinder developer                           |
| `platform.operator` | Platform operations                            |
| `security.operator` | Security operations and authentication testing |
| Emergency account 1 | Cloud-only emergency administrative access     |
| Emergency account 2 | Cloud-only emergency administrative access     |

No real users or client identities are represented in the tenant.

### Security groups

The following assigned-membership security groups were created:

| Group                       | Intended purpose                 | Primary lab member |
| --------------------------- | -------------------------------- | ------------------ |
| `GRP-Pathfinder-Users`      | Pathfinder application users     | Alex Counsellor    |
| `GRP-Pathfinder-Developers` | Pathfinder development personnel | Dev Pathfinder     |
| `GRP-Platform-Ops`          | Platform operations access       | Platform Operator  |
| `GRP-Cloud-SecOps`          | Cloud security operations access | Security Operator  |

These are application/workload access groups rather than privileged-role groups.

Privileged Entra role assignment is deliberately deferred to Day 3 so that application access and administrative privilege remain separate control planes.

Emergency-access identities are not dynamically assigned. Their membership and privileges must remain deterministic and directly controlled.

## Authentication methods

The Microsoft Entra **Authentication methods** policy was reviewed.

The tenant already had the three methods required by the lab enabled for **All users**:

| Authentication method   | Existing target | State   |
| ----------------------- | --------------- | ------- |
| Passkey (FIDO2)         | All users       | Enabled |
| Microsoft Authenticator | All users       | Enabled |
| Temporary Access Pass   | All users       | Enabled |

Additional observed tenant configuration included:

* Software OATH tokens enabled for all users
* Email OTP enabled for all users
* SMS disabled
* Voice call disabled
* Certificate-based authentication disabled
* Hardware OATH tokens disabled

### Lab variance - authentication-method pilot

The lab expected Microsoft Authenticator, Temporary Access Pass, and FIDO2/passkeys to be enabled only for a small pilot group.

The existing tenant baseline already enabled all three for **All users**.

The existing configuration was retained rather than changing the tenant solely to recreate the expected starting condition.

In a production rollout, NCES would normally pilot new authentication methods with a limited security group before expanding availability tenant-wide.

## Temporary Access Pass bootstrap

A short-lived Temporary Access Pass was created for:

```text
security.operator
```

Security Operator used the TAP to access the Microsoft account security-information registration experience and successfully register Microsoft Authenticator.

The TAP itself is not recorded in this evidence log.

The workflow validated was:

```text
Administrator creates TAP
        |
        v
Security Operator authenticates using TAP
        |
        v
Security information registration
        |
        v
Microsoft Authenticator registered
        |
        v
TAP expires
```

### Expiration test

After expiration, the original Temporary Access Pass was tested again.

**Result:** The expired TAP could not be reused.

This confirms that TAP provides temporary bootstrap access rather than creating a reusable long-lived credential.

## Authentication strength

A phishing-resistant authentication strength was configured/reviewed.

The strength was confirmed to exclude SMS authentication.

This establishes the distinction between:

```text
MFA
```

and:

```text
Phishing-resistant MFA
```

An authentication method can provide MFA without necessarily satisfying a phishing-resistant authentication strength.

This distinction is important for later Conditional Access configuration.

## Registration and audit review

Microsoft Entra authentication registration and audit records were reviewed after the Security Operator enrollment.

The logs contained the expected authentication-method activity, including the administrative TAP operation and user security-information registration events.

Relevant fields reviewed included:

* Activity
* Result
* Date and time
* Initiated by
* Target
* Service
* Result reason
* Correlation information

The exercise demonstrated the difference between:

```text
Authentication Methods Policy
        |
        | defines what users are allowed to register/use
        v
Authentication Methods Registration
        |
        | records what a specific identity actually registered
        v
Audit Logs
        |
        | records who performed the operation and when
        v
Investigation / accountability
```

## Emergency-access monitoring decision

NCES requires two independent cloud-only emergency-access identities to preserve tenant access if normal administrative authentication or Conditional Access fails.

Emergency-account activity should be extremely rare.

### Monitoring decision

Any sign-in attempt involving either emergency-access identity will be treated as a high-priority security event.

The intended production detection is:

```text
Emergency account sign-in
        |
        v
Successful OR unsuccessful attempt
        |
        v
Critical security alert
        |
        v
Immediate investigation
```

### Detection design

Future monitoring will:

* identify the emergency identities using immutable Entra Object IDs rather than display names;
* monitor successful and unsuccessful sign-ins;
* treat any occurrence as Critical / Sev 0;
* notify security operations immediately;
* preserve associated Entra sign-in and audit records;
* validate whether the event was an authorized emergency or test;
* review all actions performed by the emergency identity;
* treat unauthorized use as privileged-account compromise.

Implementation of the scheduled-query/Sentinel alert is deferred until the monitoring portion of the 30-day lab, when the NCES Log Analytics and Sentinel environment is created.

### Conditional Access design

Emergency identities will eventually be excluded from broad Conditional Access enforcement only where required to prevent total administrative lockout.

The exclusion is a recovery control, not a trusted-user exception.

Any use of an excluded emergency identity must therefore be detected and investigated.

Conditional Access implementation itself is deferred to Day 4.

## Management-plane controls

* Separate tenant-native administrative identity established.
* Normal business identities separated from administrative identities.
* Application-access groups separated from privileged-role groups.
* Authentication-method policy reviewed.
* Temporary Access Pass successfully used as a temporary onboarding mechanism.
* Phishing-resistant authentication strength established/reviewed.
* Emergency-access identities maintained separately.
* Entra audit logs reviewed for authentication-method changes.

No Day 3 PIM role assignments were created during this lab.

## Data-plane controls

No Azure workload data plane was configured during Day 2.

No Storage, SQL, Key Vault, application, AKS, or Foundry data-plane permissions were assigned as part of this exercise.

## Network controls

No Azure network controls were deployed during Day 2.

Network segmentation and private access are implemented in later labs.

## Monitoring destination

Current evidence was reviewed directly through Microsoft Entra registration, audit, and sign-in monitoring surfaces.

The planned production-style emergency-access detection will later be implemented using centralized Entra telemetry and the NCES monitoring environment.

## Verification

| Test                               | Expected                                                                                                  | Actual                                            | Pass/fail          | Evidence reference                    |
| ---------------------------------- | --------------------------------------------------------------------------------------------------------- | ------------------------------------------------- | ------------------ | ------------------------------------- |
| Synthetic identity separation      | Distinct identities exist for user, developer, operations, security, administration, and emergency access | Required synthetic identities created             | Pass               | Entra user inventory                  |
| Group separation                   | Application-access groups use assigned membership and remain separate from privileged roles               | Four workload/security groups created             | Pass               | Entra group inventory                 |
| Authentication-method availability | Authenticator, TAP, and FIDO2 available                                                                   | All three already enabled for All users           | Pass with variance | Authentication methods policy         |
| TAP issuance                       | Security Operator can receive a short-lived TAP                                                           | TAP successfully issued                           | Pass               | Authentication-method administration  |
| Authentication registration        | Security Operator can bootstrap MFA registration using TAP                                                | Microsoft Authenticator successfully registered   | Pass               | Authentication methods / My Account   |
| TAP expiration                     | Expired TAP must not authenticate                                                                         | Reuse after expiration failed                     | Pass               | Failed TAP test                       |
| Phishing-resistant strength        | SMS must not satisfy the authentication strength                                                          | SMS excluded                                      | Pass               | Authentication strength configuration |
| Ordinary-user privilege test       | Normal business user cannot access/use a privileged Entra administrative blade                            | Privileged access unavailable to ordinary user    | Pass               | Entra access test                     |
| Audit visibility                   | Authentication registration and administrative changes appear in logs                                     | Required details visible in Entra Audit Logs      | Pass               | Entra Audit Logs                      |
| Emergency monitoring               | A clear detection and response decision exists                                                            | Any emergency-account sign-in defined as Critical | Pass - design      | Monitoring decision                   |

## Findings

### Finding 1 - Authentication-method baseline broader than expected

* **Observation:** Microsoft Authenticator, Temporary Access Pass, and Passkey (FIDO2) were already enabled for All users.
* **Expected lab state:** The Day 2 procedure expected these methods to be introduced to a small pilot group.
* **Impact:** The lab could not demonstrate the transition from disabled or limited availability to pilot-group availability without changing an existing working tenant configuration.
* **Decision:** Retain the existing configuration and document the variance.
* **Production lesson:** Authentication-method rollout scope should be deliberate. A pilot group allows registration behavior and support impact to be validated before broad rollout.

### Finding 2 - Consumer-linked account could not administer Microsoft 365 licensing surface

* **Observation:** The account originally used with the Azure Free Trial was rejected by the Microsoft 365 administrative experience as a consumer identity without business presence.
* **Impact:** The account could administer Azure resources but could not be relied upon as the tenant-native administrative identity for every Microsoft Entra/Microsoft 365 administrative surface.
* **Remediation:** Created the cloud-only `James McGill (Global Admin)` identity in the lab tenant and used the tenant-native administrative context for subsequent administration.
* **Lesson:** Azure subscription ownership and Microsoft Entra tenant administration are separate authorization contexts.

### Finding 3 - Temporary credentials are visible security events

* **Observation:** TAP creation and authentication-method registration generated auditable Entra events.
* **Impact:** Authentication-method changes can represent both legitimate onboarding and account-takeover activity.
* **Security consequence:** Privileged-account registration changes and TAP creation should be monitored as security-sensitive administrative actions.

### Finding 4 - Emergency access requires compensating monitoring

* **Observation:** Emergency-access identities may need exemptions from controls that could otherwise lock administrators out of the tenant.
* **Risk:** An exempt account can bypass protections applied to ordinary administrators.
* **Compensating control:** Treat every emergency-account sign-in as a Critical security event and investigate every occurrence.
* **Follow-up:** Implement centralized detection when the lab monitoring environment is created.

### Finding 5 - Lab credential hygiene

Synthetic identities were configured for ease of repeated lab use. No passwords or authentication secrets are recorded in this evidence log.

A production environment must not reuse credentials across identities. In particular, emergency-access and privileged administrative accounts require independent credentials and protected recovery procedures.

If any emergency or administrative identity still shares a lab password with another account, rotate it to a unique credential before relying on that account as a genuine emergency-access control.

## Failure tests

### Ordinary user privileged access

An ordinary synthetic user attempted to access a privileged Microsoft Entra administrative function.

**Result:** Administrative access was unavailable.

**Status:** Pass.

### Expired Temporary Access Pass

The previously issued TAP was reused after expiration.

**Result:** Authentication failed.

**Status:** Pass.

### SMS and phishing-resistant authentication

The phishing-resistant authentication strength was reviewed.

**Result:** SMS was not an accepted authentication method.

**Status:** Pass.

## Teardown

* **Users deleted:** None.
* **Groups deleted:** None.
* **Authentication configuration removed:** None.
* **Azure resources removed:** N/A.
* **Paid capacity removed:** N/A.
* **Persistent dependencies:** Synthetic users, security groups, tenant-native administrative account, emergency-access identities, registered authentication methods, and authentication-strength configuration are retained for later labs.

Day 2 identities and groups are intentionally kept through Day 30.

## Exam recall

### Three facts I can explain

1. **Authentication-method policy and authentication registration are different controls.**

   The authentication-method policy determines which users are permitted to register and use a method. Registration records which methods a particular identity has actually configured.

2. **Temporary Access Pass is a bootstrap credential, not a permanent authentication method.**

   TAP can provide temporary access so a user can register stronger authentication. Its limited lifetime reduces the risk associated with issuing an onboarding credential.

3. **MFA does not automatically mean phishing-resistant MFA.**

   Authentication strengths can require specific methods. SMS and ordinary authentication methods may satisfy some MFA requirements without satisfying a phishing-resistant authentication-strength requirement.

### One confusing distinction

**Authentication-method availability vs Conditional Access enforcement**

Enabling an authentication method allows an identity to register and use it.

Conditional Access decides whether a particular authentication requirement must be satisfied before access to a resource is granted.

For example, enabling FIDO2 does not by itself force an administrator to authenticate using FIDO2. A later Conditional Access policy can require a phishing-resistant authentication strength for the administrative scenario.

### Scenario question

NCES enables Microsoft Authenticator, Temporary Access Pass, and FIDO2 for its users. Security Operator successfully registers Microsoft Authenticator.

NCES then creates a Conditional Access policy that requires the **Phishing-resistant MFA** authentication strength for privileged administrative access.

**Can Security Operator necessarily satisfy that policy simply because Microsoft Authenticator is registered?**

No.

Registration of an MFA-capable authentication method does not automatically mean that the method satisfies the authentication strength required by Conditional Access. The sign-in must use a method accepted by the configured phishing-resistant authentication strength.

## Day 2 status

**Complete.**

The NCES Microsoft Entra identity foundation is operational:

* synthetic business and operations identities are separated;
* workload-access groups are established;
* tenant-native administration is available;
* emergency-access identities are separated from normal administration;
* Authentication Methods policy has been reviewed;
* TAP was successfully used to bootstrap Security Operator authentication registration;
* expired TAP reuse was blocked;
* phishing-resistant authentication requirements were reviewed and SMS was excluded;
* ordinary users were confirmed unable to perform privileged administration;
* registration and audit events were reviewed;
* emergency-account sign-in monitoring requirements were documented.

Role activation and privileged assignment are deliberately deferred to **Day 3 - PIM, RBAC, and custom roles**.

Conditional Access enforcement is deliberately deferred to **Day 4 - Conditional Access, apps, and consent**.
