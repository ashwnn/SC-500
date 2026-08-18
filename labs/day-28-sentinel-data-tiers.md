# Day 28 - Sentinel onboarding, connectors, and data tiers

**Time:** 90-120 minutes  
**Mode:** Hands-on; Sentinel data lake onboarding is optional due to offboarding constraints  
**SC-500:** workspace, roles, Content hub, Microsoft connectors, custom table, retention

## Business request

NCES wants 90 days of fast access for critical detections, 13 months for verbose investigation data, and seven years for selected audit evidence without paying hot-tier prices for everything.

## Build

1. Create a Canada Central Log Analytics workspace in `rg-sc500-sec-cc` and onboard Microsoft Sentinel in the Microsoft Defender portal.
2. Record the current 31-day Sentinel trial terms and set a low workspace daily cap, such as 0.5 GB.
3. Assign Reader, Responder, Contributor, and Playbook Operator only to the identities that need them and at correct workspace/resource-group scopes.
4. Install relevant Content Hub solutions, then inventory their data connectors, analytics rules, workbooks, hunting queries, and playbooks.
5. Connect Azure Activity and Defender for Cloud. Connect Defender XDR only if the tenant is licensed and the data is synthetic/lab.
6. Create a small custom table/DCR and ingest five synthetic application-security records through the Logs Ingestion API or portal-supported sample method.
7. Compare table plans/tiering available in the current portal:
   - Analytics for real-time rules and high-performance hunting;
   - Basic/Auxiliary or Data Lake for lower-cost high-volume retention with feature limits;
   - analytics retention vs total/lake retention.
8. Create the NCES retention plan:
   - critical security tables: 90 days Analytics;
   - verbose network/app table: 13 months lake-only or total retention;
   - selected audit evidence: seven years total retention.

## Sentinel data lake decision gate

Microsoft currently states data-lake onboarding cannot be self-offboarded; disabling requires a Defender support request. It can also attach same-region Defender-connected workspaces, does not support CMK-protected data, and tier changes can take 90-120 minutes.

Choose one:

- **Disposable tenant/subscription and accepted support process:** onboard, set one tiny verbose table to the lake, run a lake KQL job, and open/document the offboarding support request during day 30.
- **Default safe lane:** do not onboard. Complete the table/tier/retention configuration plan and Analytics retention hands-on, labeling lake operations simulated.

## Evidence

Workspace/roles, connector health, five custom records, table plan comparison, retention policy, ingestion/cost view, and data-lake decision.

## Sources

- [Sentinel billing](https://learn.microsoft.com/azure/sentinel/billing)
- [Data tiers and retention](https://learn.microsoft.com/azure/sentinel/manage-data-overview)
- [Configure table tiers](https://learn.microsoft.com/azure/sentinel/manage-table-tiers-retention)
- [Data lake onboarding](https://learn.microsoft.com/azure/sentinel/datalake/sentinel-lake-onboarding)
- [Logs Ingestion API](https://learn.microsoft.com/azure/azure-monitor/logs/logs-ingestion-api-overview)

