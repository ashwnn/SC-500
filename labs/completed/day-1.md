# Day 1 - Subscription Safety and Landing Zone Evidence Log

## Session

* **Lab:** Day 1 - Subscription safety and landing zone
* **Date:** August 18, 2026
* **Time:** Approximately 1:00 PM - 3:00 PM PDT
* **Duration:** Approximately 2 hours
* **Mode:** Hands-on
* **Subscription:** Azure Free Trial
* **Promotional credit:** USD $200
* **Billing decision:** Remain on Azure Free Trial with spending protection. No PAYG upgrade.
* **Primary region:** Canada Central
* **Synthetic AI region:** East US 2
* **DeleteAfter:** 2026-09-16

## Cost checkpoint

* **Credit remaining:** Not captured during this session
* **Month-to-date actual:** Not captured
* **Forecast:** Not captured
* **Unexpected meters:** None identified
* **Anomaly alert:** Not configured. The option could not be successfully set up during this session.
* **Action:** Retained the Free Trial subscription and established budget-based monitoring before deploying billable workloads.

### Budgets configured

The following subscription-level budgets were created as planned:

| Budget                | Threshold | Purpose                            |
| --------------------- | --------: | ---------------------------------- |
| `sc500-warning`       |      $100 | Early warning and cost review      |
| `sc500-stop-build`    |      $150 | Stop new paid deployments          |
| `sc500-final-reserve` |      $180 | Preserve final credit for teardown |

These budgets provide notifications and cost visibility. They do not automatically stop or delete Azure resources when a threshold is reached.

## Business control

* **Requirement:** Keep the 30-day SC-500 proof of concept within the USD $200 Azure promotional credit while establishing a controlled Azure landing zone for later security labs.
* **Threat or failure mode:** Uncontrolled resource deployment, unexpected cloud charges, inconsistent resource placement, missing Azure resource providers, and accidental use of non-Canadian regions for business data.
* **Control selected:** Azure Free Trial spending protection, subscription budgets, standardized resource groups and tags, explicit provider registration, regional separation, and scheduled resource expiry.
* **Why this control fits:** The lab needs enough Azure functionality for practical SC-500 exercises without creating an open-ended billing commitment. The Free Trial provides a hard financial boundary unless deliberately upgraded to PAYG, while budgets provide earlier warning before the promotional credit is exhausted.
* **Rejected alternative:** Upgrading immediately to PAYG. This was unnecessary because the subscription currently has sufficient Foundry/model quota for the planned AI exercises.

## Implementation

### Subscription

Azure CLI verification confirmed:

```text
Name                State
------------------  -------
Trial Subscription  Enabled
```

Tenant and subscription identifiers are intentionally omitted from this evidence log.

### Resource providers

The required providers were manually registered through the Azure subscription's **Resource providers** interface.

Verified registered providers include:

```text
Microsoft.Storage
Microsoft.Security
Microsoft.PolicyInsights
Microsoft.Network
Microsoft.KeyVault
Microsoft.Sql
Microsoft.ContainerService
Microsoft.ContainerRegistry
Microsoft.OperationalInsights
microsoft.insights
Microsoft.CognitiveServices
Microsoft.MachineLearningServices
```

Additional Azure platform providers were already registered by the subscription.

### Landing-zone resource groups

The bootstrap process successfully created all planned resource groups:

| Resource group     | Region         | Intended purpose        |
| ------------------ | -------------- | ----------------------- |
| `rg-sc500-core-cc` | Canada Central | Shared/core resources   |
| `rg-sc500-data-cc` | Canada Central | Data services           |
| `rg-sc500-app-cc`  | Canada Central | Application services    |
| `rg-sc500-vm-cc`   | Canada Central | VM/compute exercises    |
| `rg-sc500-aks-cc`  | Canada Central | AKS/container exercises |
| `rg-sc500-sec-cc`  | Canada Central | Security and monitoring |
| `rg-sc500-ai-eus2` | East US 2      | Synthetic AI workloads  |

The resource groups use the project tagging model and have a `DeleteAfter` date of **2026-09-16**.

East US 2 is deliberately separated from the Canadian resource groups. NCES production-design data is intended to remain in approved Canadian regions. East US 2 is reserved for synthetic AI test data when required AI functionality or models are unavailable in Canada.

### Foundry quota assessment

The Free Trial subscription has usable Microsoft Foundry quota, so the full AI lab lane can proceed without upgrading the subscription to PAYG at this stage.

Representative available OpenAI quota includes:

| Model/capability         |                                            Available quota |
| ------------------------ | ---------------------------------------------------------: |
| `gpt-35-turbo`           |                                                   200k TPM |
| `gpt-4`                  |                                                    50k TPM |
| `gpt-4-turbo`            |                                                    50k TPM |
| `gpt-4o`                 |                                                    50k TPM |
| `gpt-4o-mini`            |                                                   200k TPM |
| `gpt-5-mini`             |                                                   500k TPM |
| `o4-mini`                |                                                   100k TPM |
| `text-embedding-3-small` | 350k TPM Standard, up to 1000k TPM on other available SKUs |
| `sora`                   |                                                     60 RPM |

Representative Azure AI Services quota includes:

| Model/capability               | Available quota |
| ------------------------------ | --------------: |
| MaaS                           |             600 |
| DeepSeek-R1 variants           |         20k TPM |
| Phi-4 variants                 |         20k TPM |
| Llama-4-Scout-17B-16E-Instruct |         20k TPM |
| Cohere-Command-A               |         20k TPM |
| `gpt-oss-120b`                 |       5000k TPM |
| Grok 3 / Grok 3 Mini           |         50k TPM |
| Grok 4 Fast variants           |         50k TPM |
| Kimi-K2-Thinking               |         20k TPM |

Some newer model families currently show zero quota, including selected Grok 4.20 and DeepSeek V4 variants. This does not block the planned lab because multiple suitable models have usable quota.

Managed compute quota also exists for A100, H100, H200, and MI300-class resources. No managed GPU compute was deployed during Day 1.

**Decision:** Remain on Azure Free Trial and use the available quota. Do not upgrade to PAYG unless a later lab has a concrete technical requirement that cannot be met under the Free Trial.

## Management-plane controls

* Required Azure resource providers registered.
* Subscription remains under Free Trial spending protection.
* Three Cost Management budgets configured.
* Resource groups separated by workload.
* Resource lifecycle tracked through `DeleteAfter=2026-09-16`.
* Production-design resources use Canada Central by default.
* East US 2 is explicitly isolated for synthetic AI testing.
* `Access management for Azure resources` was enabled during troubleshooting to obtain required Azure resource access.

## Data-plane controls

No application data plane was deployed during Day 1.

No Storage, SQL, Key Vault, AI application, or other workload credentials were created or captured in this evidence log.

## Network controls

No workload network controls were deployed during Day 1.

Network segmentation, NSGs, ASGs, Private Link, Private DNS, and other network-security controls are implemented in later labs.

## Monitoring destination

Azure Cost Management and Microsoft Defender for Cloud were reviewed as the initial management and posture surfaces.

No Sentinel or Log Analytics monitoring pipeline has been deployed yet.

## Defender for Cloud baseline

Microsoft Defender for Cloud was opened and reviewed, but detailed Secure Score and Defender-plan state were not captured during this session.

No bulk enablement of Defender workload protection plans was performed.

**Evidence gap:** Capture the Defender for Cloud baseline before later labs materially change the subscription's security posture. This should include:

* Secure Score;
* current Defender plans;
* trial state;
* Environment settings;
* initial recommendations.

## Verification

| Test                | Expected                                                           | Actual                                                       | Pass/fail    | Evidence reference           |
| ------------------- | ------------------------------------------------------------------ | ------------------------------------------------------------ | ------------ | ---------------------------- |
| Subscription state  | Azure subscription enabled                                         | `Trial Subscription - Enabled`                               | Pass         | Azure CLI `az account show`  |
| Required providers  | All Day 1 providers registered                                     | All required providers returned as Registered                | Pass         | Azure CLI `az provider list` |
| Landing-zone groups | Seven tagged resource groups created                               | Six Canada Central groups and one East US 2 AI group present | Pass         | Azure CLI `az group list`    |
| Cost controls       | Three planned budgets exist                                        | All three budgets configured                                 | Pass         | Cost Management              |
| Foundry usability   | At least one suitable AI model has quota                           | Significant OpenAI and Azure AI Services quota available     | Pass         | Foundry quota view           |
| Spending protection | Remain on Free Trial                                               | Subscription not upgraded to PAYG                            | Pass         | Subscription/billing view    |
| Anomaly detection   | Cost anomaly alert configured                                      | Unable to configure during session                           | Not complete | Cost Management              |
| Defender baseline   | Baseline posture recorded                                          | Portal reviewed but detailed values not captured             | Partial      | Defender for Cloud           |
| Recovery/rollback   | Landing-zone resources can be removed without affecting production | Lab-only resource groups with expiry tagging                 | Pass         | Resource group inventory     |

## Findings

### Finding 1 - Azure portal and Foundry UI drift

* **Observation:** Microsoft Foundry is now presented through the newer `ai.azure.com` experience and the portal layout differs from some of the documented lab navigation.
* **Impact:** Exact menu names and paths can change even when the underlying security concepts and resources remain the same.
* **Remediation:** Locate controls by their current product/resource names rather than relying exclusively on static portal navigation.
* **Lesson:** For SC-500, understand what a control does and which Azure resource implements it, not only where a button currently appears.

### Finding 2 - Azure resource access elevation was initially disabled

* **Observation:** `Access management for Azure resources` had not initially been enabled, which prevented visibility/access to some Azure resource-management functions.
* **Root cause:** The Global Administrator account did not have elevated Azure resource-management access.
* **Remediation:** Enabled `Access management for Azure resources`.
* **Residual risk:** This grants highly privileged Azure resource-management access and should not remain enabled as standing privilege after it is no longer required.
* **Follow-up:** Revisit this during the RBAC/PIM labs and remove unnecessary standing elevated access after the required role model has been established.

### Finding 3 - Cost anomaly alert unavailable

* **Observation:** The planned cost anomaly alert could not be configured.
* **Impact:** Automatic anomaly detection is not currently part of the lab's cost-warning controls.
* **Compensating control:** Subscription budgets are configured and Cost Management will be reviewed throughout the 30-day lab.
* **Follow-up:** Retry anomaly detection if the subscription or Cost Management interface exposes the required option later.

### Finding 4 - Defender baseline evidence incomplete

* **Observation:** Defender for Cloud was reviewed but Secure Score and detailed plan/trial state were not recorded.
* **Impact:** There is no complete Day 1 numerical baseline for comparison with later Defender configuration.
* **Remediation:** Capture the baseline before enabling Defender CSPM or workload protection plans.

## Teardown

* **Resources stopped/deleted:** None. Day 1 resource groups are required by subsequent labs.
* **Defender plan/add-on disabled:** N/A. No new paid Defender plans intentionally enabled.
* **Capacity/endpoint removed:** N/A.
* **Cost view rechecked:** No unexpected meters identified; detailed MTD/forecast values were not captured.
* **Persistent dependencies for next lab:** Seven landing-zone resource groups, registered providers, subscription budgets, project tags, and current Free Trial subscription.

## Exam recall

### Three facts I can explain

1. **Azure budgets are not hard spending caps.**
   A budget monitors cost and triggers notifications at configured thresholds. It does not automatically stop Azure resources merely because the budget has been exceeded.

2. **Free Trial and PAYG have materially different financial risk.**
   Remaining on the Azure Free Trial preserves spending protection. Upgrading to PAYG allows resources to continue consuming billable services against the configured billing account after promotional credit is exhausted or expires.

3. **Region selection is a security and governance decision, not just a deployment convenience.**
   NCES requires production client data to remain in approved Canadian regions. East US 2 is therefore restricted to synthetic AI test data when required AI capabilities are unavailable in Canada.

### One confusing distinction

**Budget vs spending limit**

A Cost Management budget is an alerting and reporting mechanism. The Azure Free Trial spending limit is the control that prevents the subscription from simply continuing to accumulate PAYG charges after the promotional allowance is exhausted unless the subscription is deliberately upgraded.

### Scenario question

NCES has consumed $151 of its $200 promotional Azure credit. The `sc500-stop-build` budget has generated its alert, but several Azure resources continue running.

**Why were the resources not automatically stopped?**

Because Azure Cost Management budgets generate alerts but do not enforce a spending cap or shut down resources. The $150 threshold represents an operational decision to stop new deployments and clean up resources manually. Financial enforcement is provided separately by the Free Trial spending protection unless the subscription is upgraded to PAYG.

## Day 1 status

**Complete with two evidence follow-ups:**

1. Capture the Defender for Cloud Secure Score and current Defender plan/trial baseline before modifying Defender configuration.
2. Revisit and remove the temporary `Access management for Azure resources` elevation once the required Azure RBAC/PIM model is established.

The subscription landing zone itself is operational: required providers are registered, resource groups are deployed in the intended regions, budget controls are active, Free Trial spending protection is retained, and sufficient Foundry quota exists to continue into the AI portion of the 30-day lab.
