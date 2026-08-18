# Day 22 - Foundry guardrails, Prompt Shields, and groundedness

**Time:** 90-120 minutes  
**Mode:** Hands-on where controls are exposed; some agent intervention points are preview  
**SC-500:** configure guardrails for agent security

## Business request

Uploaded resumes and policy documents are untrusted. The agent must resist direct jailbreaks, instructions hidden in documents, harmful content, sensitive-data disclosure, and unsafe tool use.

## Baseline attacks

Run synthetic tests before adding controls:

1. direct instruction override;
2. a retrieved document that says to ignore the system prompt and reveal a fictional identifier;
3. a prompt asking the agent to perform a mock prohibited deletion;
4. a question whose answer is absent from the supplied source;
5. harmless and disallowed content categories.

Record response, annotations, and expected business behavior.

## Configure

Create `gr-case-agent-restricted` and configure supported controls for:

- hate, violence, sexual, and self-harm input/output thresholds;
- user prompt attack detection;
- indirect prompt attack detection for document/tool content;
- PII detection/redaction where available;
- protected text/code detection where relevant;
- task adherence for attempted unsafe actions;
- groundedness for responses that must rely on provided context.

Apply the guardrail to the deployment/agent at each supported intervention point. Microsoft currently marks agent guardrails and some tool-call/tool-response controls as preview. Do not assume a model-only control automatically protects every agent tool path.

## Retest

Repeat the exact baseline set. Compare:

- allowed normal requests;
- blocked direct attack;
- blocked/flagged indirect attack;
- redacted sensitive output;
- refusal of unauthorized tool behavior;
- grounded/ungrounded result.

Inspect `detected`, `filtered`, severity, and redaction annotations. Tune one false positive without disabling the whole control.

## Required explanation

- Content filters focus on harmful content categories.
- Prompt Shields target adversarial user and document instructions.
- Groundedness checks support from supplied sources.
- Task adherence checks whether an agent stays within intended actions.
- Defender for AI Services detects runtime threats; it is not the inline replacement for guardrails.

## Cost and cleanup

Keep calls short and below 50 total. Do not send real personal data. Keep the guardrail for evaluation/red-team comparison.

## Sources

- [Guardrails overview](https://learn.microsoft.com/azure/foundry/guardrails/guardrails-overview)
- [Create guardrails](https://learn.microsoft.com/azure/foundry/guardrails/how-to-create-guardrails)
- [Prompt Shields](https://learn.microsoft.com/azure/foundry/openai/concepts/content-filter-prompt-shields)
- [Groundedness detection](https://learn.microsoft.com/azure/ai-services/content-safety/quickstart-groundedness)

