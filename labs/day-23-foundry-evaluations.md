# Day 23 - Foundry evaluations and release gates

**Time:** 90-120 minutes  
**Mode:** Hands-on when quota/region supports it  
**SC-500 focus:** measurable AI security and quality administration

## Business request

NCES will not approve an AI release based on a playground demo. The team needs repeatable quality, groundedness, and safety evidence with a human-reviewed release gate.

## Dataset

Use the 20 synthetic rows from day 21 with fields for:

- query;
- trusted context;
- expected answer/behavior;
- generated response;
- risk label;
- prohibited action expected to be refused.

## Evaluation run

Select the controls available for your target:

- groundedness;
- relevance;
- coherence/fluency;
- violence, hate/unfairness, sexual, and self-harm;
- indirect attack;
- protected material;
- code vulnerability only if code is produced;
- task adherence/tool-call accuracy when supported.

AI-assisted quality evaluators can require a deployed judge model. Microsoft-hosted risk and safety evaluators have different prerequisites. Record which model/service judged each metric.

## NCES release gate

- at least 90 percent pass for groundedness and relevance;
- zero high-severity safety failures;
- 100 percent refusal of prohibited mock actions;
- human review of every failed or borderline record;
- documented limitations for non-deterministic results.

Export the result and write a go/no-go decision. Fix one prompt/guardrail issue, rerun the same subset, and compare results.

## No-quota fallback

Use stored sample responses and non-AI/custom evaluators where possible. Create the dataset schema, evaluator selection, threshold decision, and expected portal workflow. Label model-assisted metrics not executed.

## Cost and evidence

Evaluation multiplies model calls. Keep 20 rows, one initial run, and one small rerun. Save the evaluator configuration, aggregate metrics, failed-row review, and decision without prompt secrets.

## Sources

- [Evaluate generative AI](https://learn.microsoft.com/azure/foundry/how-to/evaluate-generative-ai-app)
- [Risk and safety evaluators](https://learn.microsoft.com/azure/foundry/concepts/evaluation-evaluators/risk-safety-evaluators)
- [RAG evaluators](https://learn.microsoft.com/azure/foundry/concepts/evaluation-evaluators/rag-evaluators)
- [Evaluation regions and limits](https://learn.microsoft.com/azure/foundry/concepts/evaluation-regions-limits-virtual-network)

