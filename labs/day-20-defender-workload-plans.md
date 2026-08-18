# Day 20 - Defender workload protection plans

**Time:** 90-120 minutes  
**Mode:** Defender plan trials; Storage malware scanning is metered  
**SC-500:** Defender plans for Storage, Key Vault, databases, servers, containers, Resource Manager, DNS, and AI

## Business request

NCES needs a deliberate workload-protection matrix. Subscription-wide toggles cannot be enabled without knowing protected resources, add-ons, evidence handling, and cost.

## Plan inventory

In **Defender for Cloud > Environment settings > subscription > Defender plans**:

1. Record each plan's status, remaining trial, covered resource count, components/add-ons, and current estimate.
2. Map these workloads:
   - Servers;
   - App Service;
   - Databases/SQL;
   - Storage;
   - Key Vault;
   - Resource Manager;
   - DNS;
   - Containers/registries;
   - APIs;
   - AI Services.
3. Enable only plans needed for resources that exist. Keep a teardown list.

## Defender for Storage real test

1. Enable the current plan at **resource scope** for the lab account.
2. Enable malware scanning with the smallest practical monthly cap. It is billed from day one even during the Defender trial.
3. Upload only Microsoft's supported EICAR test file/method to the dedicated container.
4. Inspect blob tags/result, alert, and remediation behavior. Delete the test object.
5. Disable malware scanning immediately after validation.

## Other workload tests

- Generate **sample alerts** for Key Vault, SQL, Resource Manager, and DNS where the Defender portal supports them.
- Trace each alert to evidence, affected resource, attack stage, recommended response, and Sentinel connector path.
- Confirm Defender for AI Services is enabled only when the Foundry resource exists in days 21-26.
- Review sensitive-data discovery dependencies separately from runtime threat protection.

## Required explanation

Foundational CSPM, Defender CSPM, and workload protection are three different purchases/capability layers. A strong Secure Score does not mean runtime threat protection is enabled, and a Defender plan does not automatically remove the vulnerable configuration.

## Cost and cleanup

Disable the Storage malware add-on now. Keep other plan trials only when they feed days 21-29 and the calculator remains safe. Day 30 disables all paid plans.

## Sources

- [Defender trial behavior](https://learn.microsoft.com/azure/defender-for-cloud/free-trial)
- [Defender plan overview](https://learn.microsoft.com/azure/defender-for-cloud/defender-for-cloud-introduction)
- [Defender for Storage test](https://learn.microsoft.com/azure/defender-for-cloud/defender-for-storage-test)
- [Validate Defender alerts](https://learn.microsoft.com/azure/defender-for-cloud/alert-validation)

