# Day 29 - Sentinel collection, detection, and automation

**Time:** 90-120 minutes  
**Mode:** Hands-on with small native data; Syslog/CEF/WEF can be designed if no collectors exist  
**SC-500:** Syslog/CEF, Windows events/WEF, DCRs, analytics and automation

## Business request

NCES needs a low-noise detection for privileged Azure changes and a repeatable incident workflow. Hybrid log collection must be designed without flooding the POC.

## Data collection stations

1. Build or inspect an AMA Data Collection Rule for a lab VM.
2. For Linux, configure a narrow Syslog facility/severity set. Review the CEF via AMA connector and forwarder requirements.
3. For Windows, configure only selected Security event IDs through Windows Security Events via AMA. Draw the WEF source-initiated subscription, collector, AMA, DCR, and workspace flow.
4. If the day 15 VM is deleted, use configuration validation and sample/custom logs. Do not recreate expensive hosts solely for volume.

## Detection

Create a scheduled analytics rule around Azure Activity role assignment creation:

```kusto
AzureActivity
| where OperationNameValue =~ "MICROSOFT.AUTHORIZATION/ROLEASSIGNMENTS/WRITE"
| project TimeGenerated, Caller, CallerIpAddress, ResourceGroup, ActivityStatusValue, CorrelationId
```

Map account/IP/resource entities where fields exist. Create and remove a temporary Reader assignment to trigger a benign event. Tune frequency, lookback, grouping, suppression, and incident settings.

## Automation

1. Create an automation rule that tags and assigns the incident, sets severity based on scope, and adds analyst tasks.
2. Create a minimal Logic App playbook with managed identity only if its connectors/consumption fit the budget. Scope Sentinel permissions to the playbook resource group/workspace.
3. Otherwise, design the playbook actions and execute the native automation rule hands-on.
4. Investigate the incident, record entities/timeline, then close it with a correct benign-test classification.

## Purview Audit correlation

If licensed, query Microsoft Purview Audit in Defender XDR for the day 27 agent/SharePoint change and record how it would correlate with Sentinel identity/resource activity.

## Evidence

DCR scope, Syslog/CEF/WEF diagrams, KQL, rule settings, generated benign incident, automation result, managed-identity permissions, and closure classification.

## Sources

- [CEF and Syslog via AMA](https://learn.microsoft.com/azure/sentinel/connect-cef-syslog-ama)
- [Windows Security Events via AMA](https://learn.microsoft.com/azure/sentinel/data-connectors/windows-security-events-via-ama)
- [Create analytics rules](https://learn.microsoft.com/azure/sentinel/create-analytics-rules)
- [Automation rules](https://learn.microsoft.com/azure/sentinel/automate-incident-handling-with-automation-rules)

