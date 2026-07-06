---
name: claude-doc-style
description: >-
  Write or rewrite a Refold docs page in the structural style of the Claude
  (platform.claude.com) documentation: a benefit-led one-line description, an
  inverted-pyramid opening, a predictable H2 flow (How it works → Concepts →
  procedures → Use cases → Best practices → FAQ → See also), short
  second-person imperative sentences, and bolded lead terms in lists. Use this
  whenever the user wants a page to "read like the Claude docs", "match the
  Anthropic docs style", asks for the standard page skeleton/structure, or is
  drafting/restructuring any concept, how-to, or reference .mdx page in this
  repo. This skill governs STRUCTURE and SENTENCE STYLE; pair it with
  `refold-voice` for terminology/voice and `mintlify-design` for component and
  link choices. Prefer this skill over generic prose help for any Refold docs
  page, even when the user doesn't name Claude explicitly.
---

# Claude-style documentation structure

The Claude docs read well because every page is predictable. A reader who has
seen one page knows where to look on every other page: the first sentence says
what the thing is, the first section says how it works, procedures live in
`<Steps>`, edge cases live in callouts, and the bottom routes you onward. This
skill reproduces that predictability for Refold.

Two things make the style work, and they reinforce each other:

1. **A fixed page skeleton** so readers navigate by muscle memory.
2. **A flat, confident sentence style** — second person, present tense,
   imperative, one idea per sentence.

Read `references/page-skeletons.md` for the full per-page-type templates and
`references/sentence-style.md` for the line-level rules with verbatim Claude
examples. Pull them in when you reach the relevant step — don't try to hold
every rule in your head.

---

## The opening is the whole game

A reader decides in the first two sentences whether this page answers their
question. So front-load.

**Frontmatter description is a benefit, not a label.** It states what the reader
gets, in one line, no period needed.

```mdx
---
title: "Workspaces"
description: "Organize API keys, manage team access, and control costs with workspaces."
---
```

Not `"description: Information about workspaces"`. The Claude docs always lead
with the payoff.

**The first body sentence defines the thing. The second says what you do with
it.** This is the inverted pyramid — most important first, then stop adding.

> Workspaces provide a way to organize your API usage within an organization.
> Use workspaces to separate different projects, environments, or teams while
> maintaining centralized billing and administration.

Definition, then "Use X to…". No throat-clearing, no "In this guide we will".

---

## The page skeleton

Most concept/how-to pages follow this H2 order. Omit sections that don't apply —
but keep the ones you use in this order, because the order is what makes pages
feel consistent.

```
# (title comes from frontmatter)
<one–two sentence definition + "Use X to…">

## How <thing> works          ← the mental model; bulleted "Key characteristics"
## <Core concept(s)>          ← roles, types, states — often a table
## Managing <thing>           ← the procedures, grouped by surface (Console / API)
## <Resource> and scoping     ← what it touches, what it doesn't
## Common use cases           ← short scenarios, often a table
## Best practices             ← a <Steps> list of recommendations
## FAQ                        ← <section title="…?"> accordions
## See also                   ← bullet list of related pages
```

The reference file has the variant skeletons for quickstart, pure-reference, and
landing pages. Use them rather than inventing a new order per page.

---

## Sentence style in four rules

The full rule set with examples is in `references/sentence-style.md`. The five
that matter most:

1. **Talk to the reader as "you," in the present tense, doing the action now.**
   "When you create additional workspaces, you can assign API keys, members, and
   resource limits to each one." Not "Workspaces can have keys assigned to them."

2. **One idea per sentence. Cut the connective fat.** Claude docs sentences are
   short and declarative. If a sentence has two "and"s and a "which," split it.

3. **Bold the lead term in every list item that defines something.** It turns a
   paragraph-in-a-list into a scannable glossary:
   > - **Workspace identifiers** use the `wrkspc_` prefix
   > - **Maximum 100 workspaces** per organization
   > - **API keys** are scoped to a single workspace

4. **Show the concrete token, ID, or path inline.** "(for example,
   `wrkspc_01JwQvzr7rXLA5AGx3HKfFUJ`)". Readers trust docs that show real values.

5. **Never use em dashes (`—`) in content.** They read as AI-generated. Rewrite
   the sentence with a period, comma, colon, or parentheses instead. "Build in
   the browser. No deploy needed." not "Build in the browser — no deploy." This
   applies to page prose, card and step text, table cells, and callouts. (Hyphens
   in compound words like `AI-native` are fine; the ban is the em dash only.)

---

## Procedures, edge cases, and routing

These three are where most Refold pages currently fall short. The fixes map
directly onto components — see `mintlify-design` for the syntax, but the
*editorial* rules are:

- **Every UI procedure is a `<Steps>` block** with an imperative `<Step
  title="Verb phrase">`. Bold the literal UI elements: **Settings >
  Workspaces**, **Create workspace**. A 2–4 step inline sub-procedure can be a
  plain numbered list, but anything a user follows start-to-finish is `<Steps>`.

- **Edge cases and constraints become callouts, not sentences buried in
  paragraphs.** Irreversible/destructive → `<Warning>`. Rule/constraint →
  `<Note>`. Shortcut/nice-to-know → `<Tip>`. The Claude workspaces page has 9
  callouts on one page — they carry the exceptions so the prose stays clean.

- **Every page ends by routing the reader onward** — a `## See also` bullet list
  for reference pages, or a `<CardGroup>` of "Next steps" for concept/quickstart
  pages. Never end on the last sentence of the last procedure.

---

## Quick self-check before you ship

- Does the first sentence define the thing, and the second say what you do with it?
- Is the description a benefit, not a label?
- Are the H2s in the standard order?
- Is every multi-step procedure in `<Steps>`?
- Has every constraint/warning/shortcut been pulled into a callout?
- Does the page route the reader somewhere at the end?
- Are there zero em dashes (`—`) anywhere in the content?
- Read it aloud: any sentence you stumble on is too long, so split it.

If you're writing for Refold specifically, also run the `refold-voice` checklist
(terminology, product names) and the `mintlify-design` checklist (component and
link choices).
