# Day 1 - Subscription safety and landing zone

**Time:** 90-120 minutes  
**Mode:** Hands-on  
**SC-500:** governance, Azure Policy, RBAC foundations, IaC, Defender planning

## Business request

The NCES board approved a USD $200 proof of concept but did not approve open-ended cloud spending. Before deployment, build the subscription guardrails, naming model, regions, and evidence process.

## Outcomes

- verify the promotional offer, spending limit, credit, tenant, subscription, and quota;
- create tagged resource groups and budgets;
- register required providers;
- decide whether the AI lane is deployable without upgrading;
- capture the baseline Defender posture and costs.

## Tasks

1. In **Cost Management + Billing**, record the offer, credit remaining, end date, and spending-limit state. Do not record full IDs in public evidence.
2. Create the three budgets from [cost control](../docs/cost-control.md). Add email alerts you will actually see.
3. In **Subscriptions > Resource providers**, register:
   - `Microsoft.Security`
   - `Microsoft.PolicyInsights`
   - `Microsoft.Network`
   - `Microsoft.Storage`
   - `Microsoft.KeyVault`
   - `Microsoft.Sql`
   - `Microsoft.ContainerService`
   - `Microsoft.ContainerRegistry`
   - `Microsoft.OperationalInsights`
   - `Microsoft.Insights`
   - `Microsoft.CognitiveServices`
   - `Microsoft.MachineLearningServices`
4. Open Cloud Shell Bash, export `AZURE_SUBSCRIPTION_ID`, review [`bootstrap.sh`](../scripts/bootstrap.sh), and run it.
5. In **Microsoft Foundry > Management center > Quota**, check East US 2 model quota. Record whether a small pay-per-token model can be deployed.
6. If quota is zero because the subscription is Free Trial, choose one:
   - **Safe default:** keep spending protection and use the no-quota fallback in days 21-26.
   - **Full AI lane:** upgrade the same subscription to pay-as-you-go. Microsoft says the unused $200 remains until the original expiry, but spending protection is removed and day 30 teardown becomes mandatory.
7. In Defender for Cloud, capture Secure Score, Environment settings, and current plan/trial status. Do not enable every plan yet.
8. Create an evidence log for day 1 and add an explicit `DeleteAfter` date to your resource-group tags.

## Verification

```bash
az account show --query "{name:name,state:state,tenant:tenantId}" --output table
az provider list --query "[?registrationState=='Registered'].namespace" --output tsv
az group list --tag project=sc500-30d --query "[].{name:name,location:location,tags:tags}" --output table
```

Pass when all expected groups exist, budgets are visible, cost alerts have recipients, required providers are registered, and the Foundry quota decision is recorded.

## Cost and cleanup

Resource groups, budgets, provider registrations, and tags have no material consumption charge. Keep the groups. Remove any accidental service deployment.

## Explain before moving on

- Why is a budget not a hard cap?
- What protection is lost when moving from Free Trial to pay-as-you-go?
- Why is East US 2 acceptable only for synthetic AI data in this scenario?

## Sources

- [Azure free account](https://azure.microsoft.com/pricing/purchase-options/azure-account)
- [Upgrade Azure subscription](https://learn.microsoft.com/azure/cost-management-billing/manage/upgrade-azure-subscription)
- [Azure spending limit](https://learn.microsoft.com/azure/cost-management-billing/manage/spending-limit)
- [Azure subscription limits](https://learn.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits)

