# Day 15 - Defender for Servers, MDVM, Arc, and Machine Configuration

**Time:** 90-120 minutes  
**Mode:** Defender trial hands-on; Arc can use a local disposable VM or simulation  
**SC-500:** Defender for Servers, EDR, MDVM, agentless scanning, Arc, Machine Configuration

## Business request

NCES operates Azure and on-premises servers. Security needs one posture/threat view without assuming every server is cloud native.

## Defender for Servers

1. Confirm Defender for Servers P2 trial status and covered resources.
2. On the day 14 VM, inspect:
   - Defender for Endpoint provisioning and health;
   - Microsoft Defender Vulnerability Management findings;
   - agentless VM scanning status;
   - JIT and File Integrity Monitoring configuration;
   - relevant recommendations and extensions.
3. Use Microsoft's supported harmless alert-validation or sample-alert method. Do not deploy malware.
4. Compare Plan 1 and Plan 2 in a decision record. Tie the choice to EDR, agentless scanning, vulnerability, FIM, and JIT requirements.

## Hybrid lane

1. If you own a disposable local/nested VM, use Azure Arc-enabled servers onboarding and a scoped service principal/onboarding script.
2. Verify the connected-machine resource, extension management, and Defender coverage.
3. Assign one Azure Machine Configuration definition to the Azure or Arc server and inspect compliance.
4. If no safe disposable host exists, walk the Arc generation flow, document required outbound endpoints/permissions, and stop before executing it.

## Failure and investigation

- Identify an intentionally safe configuration weakness such as a missing update.
- Trace recommendation -> affected resource -> remediation owner -> expected telemetry.
- Confirm agentless scanning and agent-based EDR solve different problems.

## Cost and cleanup

Export evidence, then delete the VM resource group including NIC/disks. Disconnect/delete the Arc lab machine and remove its onboarding credentials. Do not leave trial-time server assignments running.

## Sources

- [Defender for Servers](https://learn.microsoft.com/azure/defender-for-cloud/defender-for-servers-overview)
- [Choose a Servers plan](https://learn.microsoft.com/azure/defender-for-cloud/plan-defender-for-servers-select-plan)
- [Agentless scanning](https://learn.microsoft.com/azure/defender-for-cloud/concept-agentless-data-collection)
- [Arc-enabled servers](https://learn.microsoft.com/azure/azure-arc/servers/overview)
- [Machine Configuration](https://learn.microsoft.com/azure/governance/machine-configuration/overview)

