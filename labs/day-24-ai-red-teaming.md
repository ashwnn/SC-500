# Day 24 - AI Red Teaming Agent

**Time:** 90-120 minutes  
**Mode:** Hands-on in supported Foundry path; feature/target constraints may be preview  
**SC-500 focus:** adversarial AI security testing and remediation

## Business request

The security team must probe behavior beyond the fixed release dataset and measure whether adversarial strategies can make the agent violate its boundaries.

## Scope and safety

- Target only the synthetic `case-agent-purple` project.
- Start with two relevant risk categories and three objectives per category.
- Use mock tools with no external side effects.
- Never target public third-party models or endpoints without authorization.

## Run

1. Select the current cloud AI Red Teaming Agent workflow in Foundry.
2. Configure attacks for direct/indirect prompt injection, sensitive-data leakage, task adherence/prohibited actions, and code vulnerability only when relevant.
3. Run the smallest scan. Review generated objectives and attack strategies.
4. Treat Attack Success Rate as a triage measure, not an unquestionable truth. Manually review every reported success and material false negative.
5. Remediate one issue by changing agent instruction, tool permission, or guardrail.
6. Rerun the same objective set and compare ASR and behavior.
7. Add confirmed issues to a backlog with severity, evidence, mitigation, owner, and retest date.

## Fallback

If cloud red teaming is unavailable, use Microsoft's local SDK only when its current compatibility note matches your Foundry project. Otherwise, perform a manual adversarial set based on the same categories and document that the agent was not executed.

Microsoft's local path has preview/compatibility restrictions and requires supported Python versions. Do not rewrite the project around an older classic SDK merely to complete a screenshot.

## Evidence

Scope authorization, target, strategies, objective count, reviewed successful attacks, before/after ASR, one remediation, and human-review notes.

## Cost and cleanup

Small red-team runs can still generate many model calls. Stop after the planned rerun. Retain only sanitized report output.

## Sources

- [AI Red Teaming Agent](https://learn.microsoft.com/azure/foundry/concepts/ai-red-teaming-agent)
- [Cloud red teaming](https://learn.microsoft.com/azure/foundry/how-to/develop/run-ai-red-teaming-cloud)
- [Local red-team workflow](https://learn.microsoft.com/azure/foundry/how-to/develop/run-scans-ai-red-teaming-agent)

