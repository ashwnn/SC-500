# Cost control and teardown

## Hard rule

Stay on the Azure free account with spending protection by default. Microsoft states that the free account will not charge the card unless you choose to move to pay-as-you-go. Resources are disabled when the credit or 30-day period ends if you do not upgrade.

The only planned exception is the optional full Foundry lane if the Free Trial subscription receives zero model quota. Upgrading the same subscription preserves remaining promotional credit through its original 30-day window, but removes spending protection and permits post-credit charges. Choose that lane only after budgets are active and you accept the mandatory day 30 teardown. The no-quota fallback covers the objectives without upgrading.

## The USD $200 lab envelope

This is a planning allocation, not a Microsoft price quote:

| Bucket | Maximum POC allocation |
|---|---:|
| Persistent PaaS, storage, SQL, diagnostics, and small AI inference | $35 |
| VM and AKS burst labs | $35 |
| Firewall, gateway, WAF, and other network burst labs | $35 |
| Sentinel and Log Analytics ingestion/query | $20 |
| Defender metered items not covered by trials | $5 |
| Optional one-hour Security Copilot SCU | $4 |
| Unallocated safety reserve | $66 |
| **Total** | **$200** |

Actual charges vary by region, SKU, exchange display, usage, and feature availability. Use the portal estimates before every deployment. If a quoted hourly estimate would push the forecast above the bucket, complete the simulation lane.

## Day 1 controls

Create three Azure Cost Management budgets at subscription scope:

- `sc500-warning` at $100 with 50, 75, and 90 percent alerts;
- `sc500-stop-build` at $150 with a 100 percent alert;
- `sc500-final-reserve` at $180 with a 100 percent alert.

A budget does not stop resources. The names describe your manual response:

- at $100, review forecast and delete idle resources;
- at $150, stop all new deployments and complete remaining cost-burst labs by simulation;
- at $180, run the day 30 teardown immediately.

Also create an anomaly alert and review **Cost analysis > Daily costs** at the start of each lab.

## Persistent vs burst resources

### Keep until day 30

- resource groups, tags, policies, and role assignments;
- low-volume Storage, Key Vault, SQL serverless database, App Service/Functions where free or consumption-based;
- Log Analytics/Sentinel workspace with tightly controlled ingestion;
- Foundry resources only if the daily forecast remains safe.

### Delete in the same session

- Azure Firewall and paid VPN/Virtual WAN gateways;
- paid Bastion deployments when a free developer option is unavailable;
- AKS node pools and other container compute after day 18;
- VM after day 15;
- WAF/Application Gateway test deployment;
- any unexpected duplicate private endpoint, public IP, managed disk, snapshot, or Log Analytics workspace.

## Defender trial safety

Enabling a Defender plan at subscription scope can cover every current and future resource of that type. Before enabling:

1. Open **Defender for Cloud > Environment settings > subscription > Defender plans**.
2. Open the cost calculator and record covered resources.
3. Confirm the plan's remaining free-trial time.
4. For Storage malware scanning, use resource-level enablement and set a low monthly scan cap.
5. Disable plans on day 30 before deleting the remaining resources.

Foundational CSPM is free. Defender CSPM and workload protection plans are separate.

## Sentinel safety

- Keep total ingestion under 500 MB for the POC.
- Do not connect a noisy production tenant, firewall, or endpoint fleet.
- Use sample/custom records and Azure Activity.
- Set a low daily cap in the Log Analytics workspace.
- Keep only tables used by the lab in the Analytics tier.
- Data lake storage and scans can incur cost even though it is cheaper than hot analytics.

## Security Copilot warning

As of 2026-08-18, the public Microsoft price is USD $4 per provisioned SCU/hour and USD $6 per overage SCU/hour. Provisioned capacity is charged in hourly blocks with a one-hour minimum and continues while provisioned. If you select the paid capstone lane:

1. provision exactly one SCU;
2. set overage to zero;
3. finish prepared prompts inside the same billing hour;
4. offboard and delete capacity immediately;
5. verify the Azure resource is gone and cost analysis shows no continuing meter.

## Daily cost checkpoint

Record this in your evidence log:

```text
Date/time:
Credit remaining:
Month-to-date actual cost:
Forecast:
Top three services:
Unexpected resources/meters:
Action taken:
```

## Day 30 zero-cost exit

The repository includes [`scripts/teardown.sh`](../scripts/teardown.sh) for resource-group deletion. It intentionally does not delete arbitrary groups or change Defender subscription plans automatically.

After running it:

- disable all paid Defender plans in Environment settings;
- delete Security Copilot capacity/workspaces if created;
- remove Microsoft Sentinel from the workspace, then delete the workspace/resource group;
- check for public IPs, disks, snapshots, private endpoints, NICs, registries, APIM, gateways, and AI deployments;
- check Cost Management for resources grouped by service and resource group;
- end optional Microsoft 365 trials from their own admin portals if you do not want them;
- save sanitized proof that no lab resource remains.

## Official references

- [Azure free account and spending protection](https://azure.microsoft.com/pricing/purchase-options/azure-account)
- [Create and manage Azure budgets](https://learn.microsoft.com/azure/cost-management-billing/costs/tutorial-acm-create-budgets)
- [Defender for Cloud cost calculator](https://learn.microsoft.com/azure/defender-for-cloud/cost-calculator)
- [Defender for Cloud pricing](https://azure.microsoft.com/pricing/details/defender-for-cloud/)
- [Microsoft Sentinel billing](https://learn.microsoft.com/azure/sentinel/billing)
- [Security Copilot pricing](https://www.microsoft.com/security/pricing/microsoft-security-copilot)
