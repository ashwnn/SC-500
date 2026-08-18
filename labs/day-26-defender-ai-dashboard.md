# Day 26 - Defender for AI Services and Data and AI security dashboard

**Time:** 90-120 minutes plus processing delay  
**Mode:** Defender trial hands-on  
**SC-500:** Defender for AI Services, Data and AI security dashboard

## Business request

NCES needs cloud-wide AI inventory, posture, exposure, attack paths, and runtime threat evidence in the same security operation used for other workloads.

## Enable and inspect

1. Enable Defender CSPM and Defender for AI Services for the lab subscription.
2. Record the AI plan's independent 30-day trial and 75-billion-token scan cap. Keep the actual lab traffic tiny.
3. Enable suspicious prompt evidence only after reading privacy behavior. Use synthetic prompts exclusively.
4. Do not enable Purview data security for Foundry interactions unless the separate Purview licensing/PAYG decision is approved.
5. Open the **Data and AI security dashboard** and review:
   - AI asset inventory;
   - public endpoints and protection coverage;
   - recommendations and prioritized findings;
   - data/AI attack paths;
   - Defender alerts and Defender XDR handoff.
6. Generate Defender sample AI alerts if offered. Do not try to create a live malicious event.
7. Triage one sample: validate resource, prompt-evidence handling, identity, gateway path, containment, and monitoring query.
8. Compare dashboard coverage before/after enabling the relevant plans.

## Optional AI model security

If time permits, create an Azure Machine Learning workspace without compute, register one tiny benign supported model artifact, enable the preview AI model security component, and inspect inventory later. Do not upload malware or secrets. Document that scans can be delayed and private-link limitations may apply.

## Required explanation

Full Data and AI dashboard coverage can require Defender CSPM, sensitive-data discovery, and workload plans for Storage, Databases, and AI. Partial coverage is not proof the dashboard is broken.

## Cost and cleanup

Keep Defender AI only until the capstone. Delete any AML workspace/model if created. Do not enable Purview PAYG implicitly.

## Sources

- [AI threat protection](https://learn.microsoft.com/azure/defender-for-cloud/ai-threat-protection)
- [Enable Defender for AI Services](https://learn.microsoft.com/azure/defender-for-cloud/ai-onboarding)
- [Data and AI security dashboard](https://learn.microsoft.com/azure/defender-for-cloud/data-aware-security-dashboard-overview)
- [AI model security](https://learn.microsoft.com/azure/defender-for-cloud/ai-model-security)

