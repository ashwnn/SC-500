# Day 13 - Secure application platform services

**Time:** 90-120 minutes  
**Mode:** Hands-on with free/consumption services; WAF design if cost is high  
**SC-500:** App Service, Functions, Logic Apps, WAF, backend API protection

## Business request

Pathfinder uses a web app, an event-driven document function, and a workflow that creates analyst tasks. Each service must authenticate callers, use workload identity, restrict network access, and generate security logs.

## App Service

1. Create a minimal app on a free or lowest test tier.
2. Enforce HTTPS, current minimum TLS, FTPS disabled, and secure deployment settings.
3. Enable App Service Authentication with the `Pathfinder-Case-API` registration. Require authentication for all routes except a health endpoint if needed.
4. Enable a managed identity and use a Key Vault reference for a synthetic configuration value.
5. Review access restrictions, VNet integration, and a private endpoint. Deploy only the combination supported by the chosen tier.

## Functions and Logic Apps

1. Create a consumption Function that receives a small synthetic blob event.
2. Require Entra/API authorization as supported, enable managed identity, and avoid account keys in settings.
3. Create a consumption Logic App that receives an alert-shaped test event and writes a sanitized record.
4. Use managed connectors/managed identity where supported. Restrict inbound trigger access and rotate any generated callback URL after the test.
5. Send diagnostic logs to the security workspace later used by Sentinel.

## Container Instances and Container Apps station

1. Compare Azure Container Instances and Azure Container Apps for the same tiny image.
2. For each, identify managed identity, ACR pull authorization, secret handling, ingress exposure, TLS, VNet/private access, and diagnostic logging.
3. Deploy only one consumption-oriented Container App if the live estimate is acceptable. Require HTTPS, set ingress to internal where the test permits, enable managed identity, and pull from ACR without registry admin credentials.
4. Record why ACI is suited to a short isolated task while Container Apps adds application ingress/revisions/scaling. Delete any deployed container after the test.

## WAF and API backend design

1. Review Application Gateway WAF policy with OWASP managed rules, exclusions, detection, prevention, and logs.
2. If the cost estimate fits the network burst bucket, deploy briefly in detection mode, send harmless test requests, review logs, switch to prevention for one known test, then delete it.
3. Define APIM backend protections for day 25: validate JWT, limit request size, restrict IP where appropriate, rate/quota controls, and managed-identity backend authentication.

## Failure tests

- Anonymous app request receives a redirect/401.
- App identity reads the allowed secret; user without a data role cannot.
- Unauthorized Function/Logic App request fails.
- Diagnostics contain application access and platform events.

## Cost and cleanup

Delete WAF/Application Gateway, public IP, and paid plan immediately. Keep free/consumption components only if forecast remains safe.

## Sources

- [App Service security](https://learn.microsoft.com/azure/app-service/overview-security)
- [App Service authentication](https://learn.microsoft.com/azure/app-service/overview-authentication-authorization)
- [Functions security](https://learn.microsoft.com/azure/azure-functions/security-concepts)
- [Secure Logic Apps](https://learn.microsoft.com/azure/logic-apps/logic-apps-securing-a-logic-app)
- [WAF overview](https://learn.microsoft.com/azure/web-application-firewall/overview)
