# Day 18 - Defender for Containers

**Time:** 90-120 minutes, plus later signal review  
**Mode:** Defender trial + cost-burst  
**SC-500:** container misconfiguration, vulnerabilities, Defender sensor/runtime, AKS/ACR protection

## Business request

NCES needs registry-to-runtime visibility and contextual risk, not only a CI image scan.

## Tasks

1. Enable Defender for Containers for the subscription and record trial status/cost estimate.
2. Start AKS and verify Defender sensor/extension health and agentless Kubernetes posture.
3. Confirm ACR image assessment coverage and review current scan cadence/triggers.
4. Use only Microsoft's official mock vulnerable image/chart or documented container alert simulation on this dedicated cluster.
5. Inspect:
   - registry/image vulnerabilities;
   - Kubernetes posture findings;
   - runtime/control-plane alerts;
   - relevant Cloud Security Explorer relationships;
   - attack paths when they appear.
6. Remediate one namespace or workload issue and record the time until posture updates.
7. Compare admission prevention, posture detection, registry vulnerability assessment, and runtime threat detection.

## Safety

Do not upload real malware, exploit another system, expose the cluster intentionally to the internet, or use a production registry. Defender signals can take hours. Evidence may be completed the next day.

## Cost and cleanup

Export manifests and evidence. Delete the AKS and ACR resource group, then confirm nodes, managed disks, load balancers, public IPs, identities, and role assignments are gone. Deleting the cluster does not disable the Defender plan; leave it for day 20 review or disable if forecast requires.

## Sources

- [Defender for Containers](https://learn.microsoft.com/azure/defender-for-cloud/defender-for-containers-introduction)
- [Verify deployment](https://learn.microsoft.com/azure/defender-for-cloud/defender-for-containers-verify-deployment)
- [Container alerts](https://learn.microsoft.com/azure/defender-for-cloud/alerts-containers)
- [Official mock attack path](https://learn.microsoft.com/azure/defender-for-cloud/how-to-test-attack-path-and-security-explorer-with-vulnerable-container-image)

