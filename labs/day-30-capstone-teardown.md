# Day 30 - Security Copilot capstone and zero-cost teardown

**Time:** Two focused 60-minute blocks  
**Mode:** Capstone hands-on; Security Copilot optional paid hour or guided simulation  
**SC-500:** Security Copilot workspaces/roles/plugins/agents, end-to-end response, teardown

## Capstone incident

Use only synthetic/sample signals:

> A new role assignment grants a Pathfinder workload identity excessive access. The identity calls the Foundry endpoint outside the AI Gateway path after an indirect prompt attack is detected. A case document is publicly exposed, and Defender produces an AI/Storage sample alert.

## Investigation

1. Build a timeline from Azure Activity, APIM logs, Foundry/Defender evidence, Storage access, Entra sign-ins/audit, and Sentinel incident entities.
2. Determine:
   - initial exposure;
   - identity and permissions;
   - data/resource blast radius;
   - preventive controls that failed or were bypassed;
   - confirmed facts vs inference.
3. Contain the synthetic incident:
   - remove excessive role assignment;
   - disable compromised lab identity/agent;
   - require AI Gateway path;
   - fix sharing/public access;
   - update guardrail/detection;
   - preserve sanitized evidence.
4. Rerun the relevant denied-path tests.

## Security Copilot lane

### Included/previously licensed

Create/configure one workspace, assign least-privilege Owner/Contributor/security-product roles, enable only required Microsoft plugins, inspect available Microsoft and Security Store agents, and run prepared prompts over the synthetic incident.

### Optional one-hour paid lane

1. Check the live price and capacity region.
2. Provision exactly one SCU, overage zero.
3. Run prepared prompts within the same billing hour:
   - summarize the incident with citations to supplied signals;
   - generate and explain a KQL query;
   - map containment to affected identities/resources;
   - challenge one Copilot conclusion against raw evidence.
4. Offboard and delete capacity before the hour ends. Verify the Azure capacity resource is gone.

### Default simulation

Use current onboarding, workspace, role, plugin, agent, usage, and offboarding pages to create an administration runbook. Do not provision capacity.

Security Copilot is not evidence by itself. Validate generated claims and queries against source telemetry.

## Mandatory teardown

1. Export sanitized evidence, KQL, policy definitions, guardrail/evaluation/red-team reports, cost view, and decision records.
2. Remove resource locks and lab Policy assignments that could block deletion.
3. Remove PIM eligible and active time-bound assignments before any trial expires.
4. Disable every paid Defender plan and add-on in Environment settings. Confirm Storage malware scanning is off.
5. Delete Security Copilot capacity/workspaces if created.
6. If Sentinel data lake was onboarded, submit the documented Defender support request to offboard. Record the case. Delete Sentinel/workspace only after understanding that dependency.
7. Delete APIM AI Gateway, model deployments, Foundry/AML resources, agent identities/blueprints, and any Purview PAYG link.
8. Run [`teardown.sh`](../scripts/teardown.sh) after setting the exact confirmation string.
9. Verify no VM, disk, snapshot, public IP, NIC, gateway, Firewall, Bastion, AKS node, ACR, private endpoint, SQL database, APIM, model deployment, Log Analytics workspace, or orphaned identity remains.
10. Review Cost Management by service and resource group. Save proof and recheck after cost data catches up.

## Final deliverable

Write a two-page security engineering summary containing architecture, implemented controls, three most important findings, licensing gaps, cost result, residual risks, and what would change for production.

## Sources

- [Security Copilot onboarding](https://learn.microsoft.com/copilot/security/get-started-security-copilot)
- [Authentication and roles](https://learn.microsoft.com/copilot/security/authentication)
- [Manage plugins](https://learn.microsoft.com/copilot/security/manage-plugins)
- [SCU capacity billing](https://learn.microsoft.com/copilot/security/security-compute-units-capacity)
- [Manage usage and offboard](https://learn.microsoft.com/copilot/security/manage-usage)
- [Defender plan trial status](https://learn.microsoft.com/azure/defender-for-cloud/free-trial)

