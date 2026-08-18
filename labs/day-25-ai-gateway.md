# Day 25 - AI Gateway with Azure API Management

**Time:** 90-120 minutes  
**Mode:** Hands-on when Foundry-created Basic v2 offer is available; integration is preview  
**SC-500:** configure/deploy AI Gateway and backend API security

## Business request

Applications must not call model endpoints directly. NCES needs central Entra authentication, quotas, token limits, content controls, backend identity, and logs.

## Build

1. In Foundry **Manage > AI Gateway**, add a gateway and create/associate the eligible APIM Basic v2 instance through the Foundry workflow.
2. Confirm the live pricing blade. Microsoft currently documents up to 100,000 free requests when Basic v2 is created as a Foundry AI Gateway, but eligibility and preview terms can change.
3. Use APIM's system-assigned managed identity for the Foundry backend. Grant only the required inference data-plane role.
4. Import/associate the model deployment.
5. Configure deliberately low controls:
   - tokens-per-minute limit;
   - total token quota;
   - validate JWT/Entra caller identity;
   - request-size limit;
   - Azure AI Content Safety policy where supported;
   - diagnostics to Log Analytics.
6. Send a permitted request.
7. Exceed the rate limit and observe `429`.
8. Exceed the quota and observe `403`.
9. Query:

```kusto
ApiManagementGatewayLogs
| where TimeGenerated > ago(1h)
| project TimeGenerated, OperationName, ResponseCode, TotalTime
```

10. Compare direct vs gateway calls and remove/barricade direct application bypass in the design.

## Critical distinction

The standalone APIM **AI Gateway tier** is a separate public-preview offering with limited regions and pricing pending. This lab uses APIM created through Foundry, not that standalone tier. APIM Consumption also lacks some LLM token-policy capabilities required here.

## Cost and cleanup

Stay far below 100,000 calls. If the displayed SKU is billable outside your budget, create the policy XML/design and stop before deployment. Delete the APIM instance during day 30; removing the Foundry association alone does not stop APIM resources.

## Sources

- [Configure AI Gateway in Foundry](https://learn.microsoft.com/azure/foundry/configuration/enable-ai-api-management-gateway-portal)
- [APIM pricing](https://azure.microsoft.com/pricing/details/api-management/)
- [AI Gateway capabilities](https://learn.microsoft.com/azure/api-management/genai-gateway-capabilities)
- [Import Foundry API](https://learn.microsoft.com/azure/api-management/azure-ai-foundry-api)
- [APIM policy support](https://learn.microsoft.com/azure/api-management/api-management-policies)

