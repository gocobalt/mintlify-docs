---
description: Write or rewrite a Refold docs page using the Claude-docs patterns (structure + voice + Mintlify design)
argument-hint: "[path to .mdx page, or a description of the page to create]"
---

# /doc-pattern — author a Refold docs page the Claude-docs way

You are writing or rewriting a Refold documentation page so it reads and looks
like the Claude (platform.claude.com) documentation. Three skills define the
house pattern; **load and apply all three before writing**, because they cover
different layers and only together produce an on-pattern page:

1. **`claude-doc-style`** — page skeleton + sentence-level style.
2. **`refold-voice`** — terminology, product names, brand tone.
3. **`mintlify-design`** — component, callout, and link choices.

Also read **`.claude/doc-structure.md`** to place the page correctly and pick the
right page type (tutorial / how-to / reference / explanation).

## Target

The user passed: **$ARGUMENTS**

- If that's a path to an existing `.mdx` file → rewrite it in place.
- If it's a description (e.g. "the webhooks concept page") → find the existing
  page if one exists, otherwise create a new one and register it in navigation
  (`docs.json`/`mint.json`) per `.claude/skills/new-page.md`.
- If `$ARGUMENTS` is empty → ask which page to work on, then proceed.

## Workflow

Follow this order — it mirrors how the Claude docs are actually built.

1. **Load the pattern.** Invoke the three skills above (Skill tool) and read
   `.claude/doc-structure.md`. Don't skip this even if the page looks simple.

2. **Study the neighbors.** Read 2–3 real (non-stub) pages in the same
   section/product to match their depth, terminology, and conventions. A good
   reference for component-rich pages: `v3/mcp-ai-agents/overview/what-is-mcp.mdx`.

3. **Classify the page** (tutorial / how-to / reference / explanation) and pick
   the matching skeleton from `claude-doc-style` → `references/page-skeletons.md`.

4. **Draft** the page:
   - Benefit-led `description` frontmatter; inverted-pyramid opening (define, then
     "Use X to…").
   - H2s in the standard order for the page type.
   - Every procedure in `<Steps>`; every matrix in a table; every constraint/
     warning/shortcut in the correct callout; first mention of each concept
     hyperlinked; a `## See also` or "Next steps" `<CardGroup>` at the end.
   - Refold terminology throughout (Refold, not Cobalt; canonical object names).
   - Add `MEDIA-TODO:` placeholders where a screenshot or diagram would help,
     describing what to capture, rather than leaving the spot bare.

5. **Run the three checklists** at the bottom of each skill against your draft.
   Fix anything that fails.

6. **Show the result.** If a local Mintlify dev server is running, reload and
   confirm the page renders without MDX errors; otherwise tell the user how to
   preview. Summarize what changed and why, mapped to the patterns (e.g.
   "converted the 6-step paragraph into `<Steps>`; pulled the irreversible-delete
   note into a `<Warning>`; linked first mention of linked accounts").

## Guardrails

- **Don't invent facts** — limits, API fields, SLAs, metrics. If you don't have
  the real value, leave a `TODO:` and say so. A plausible fabrication in docs is
  worse than an obvious gap.
- **Don't duplicate.** If the concept already has a canonical page, update or link
  to it instead of writing a second version (see the placement test in
  `.claude/doc-structure.md`).
- **Preserve correct existing content.** Restructure and tighten; don't discard
  accurate technical detail just to fit the skeleton.
- **One page per invocation** unless the user explicitly asks for a batch.
