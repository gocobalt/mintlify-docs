---
name: mintlify-design
description: >-
  Decide which Mintlify component to use and how to use it the way the Claude
  (platform.claude.com) docs do: when to reach for Steps vs a numbered list,
  Tabs vs CodeGroup, Cards vs inline links, which callout (Note/Tip/Warning/
  Info) fits a given aside, when to hyperlink (and to what), and when a table or
  Accordion/FAQ beats prose. Use this whenever writing or reviewing any Refold
  .mdx page and choosing components, fixing a "wall of text" page, adding
  callouts or links, building a Steps/Tabs/Card layout, or asking "should this
  be a callout or a note, a card or a link". This skill governs COMPONENT and
  LINK choices; pair it with `claude-doc-style` for page structure and
  `refold-voice` for wording. Apply it on every Refold docs page — good
  component choices are what makes a page feel like the Claude docs.
---

# Mintlify design: components, callouts, and links

The Claude docs look polished because components are used *with intent* — each
one earns its place by doing a job that plain prose does worse. The failure mode
in most docs is the opposite: walls of text where a `<Steps>` or a table belonged,
or decorative components where plain text was clearer.

This skill is a decision guide. For exact component syntax, the Mintlify
component reference is authoritative — see the existing `mintlify` skill and
[mintlify.com/docs/components](https://mintlify.com/docs/components). This file
is about **when** and **why**, with the patterns the Claude docs actually use.

The detailed catalog with verbatim examples is in
`references/component-catalog.md`. The rules below are the ones you apply on
every page.

---

## The component decision table

| If the content is… | Use | Not |
|--------------------|-----|-----|
| A procedure the reader follows start-to-finish | `<Steps>` | a numbered list |
| A short 2–4 step inline sub-procedure | a numbered list | `<Steps>` (overkill) |
| The same task in multiple languages/clients | `<Tabs>` with `<Steps>` inside each tab | stacked code blocks |
| The *same* code shown across languages, no prose between | `<CodeGroup>` | separate code blocks |
| Routing the reader to 2–4 next destinations | `<CardGroup>` of `<Card>` | a bullet list of links |
| One strong single next action | a single `<Card>` | a sentence with a link |
| A two-dimensional matrix (role×permission, mode×use-case) | a table | prose or nested bullets |
| A constraint, exception, or "heads up" | a callout (see below) | a sentence in a paragraph |
| A list of repeated Q→A pairs | `<section title="…?">` (FAQ accordion) | H3 per question |
| A glossary term defined inline | `<Tooltip>` | a parenthetical |
| A screenshot/diagram | `<Frame>` (image) or a `mermaid` block | a wall of words |

The single highest-leverage habit: **the moment you write a numbered procedure or
a two-column comparison, stop and convert it to `<Steps>` or a table.** That one
move accounts for most of the visual gap between a Refold draft and a Claude page.

---

## Callouts: which one, and when

Callouts carry the exceptions so the main prose stays a clean happy-path. The
Claude workspaces page has ~9 callouts on one page — that's the right density for
a page full of rules. Match the *type* to the *intent*:

| Callout | Intent | Example trigger |
|---------|--------|-----------------|
| `<Note>` | A rule or constraint the reader must know to avoid confusion | "Only organization admins can create workspaces." |
| `<Warning>` | An irreversible, destructive, or breaking consequence | "Archiving a workspace immediately revokes all API keys… This cannot be undone." |
| `<Tip>` | A shortcut or nicety that helps but isn't required | "To switch between workspaces, use the **Workspaces** selector in the top-left." |
| `<Info>` | Contextual availability / scope note, neutral in tone | "Claude Mythos Preview is offered separately… invitation-only." |

Rules that keep callouts effective:

- **One idea per callout.** If it has three unrelated rules, use three callouts or
  a bulleted list inside one.
- **`<Warning>` is reserved for real consequences** — data loss, revoked access,
  breaking changes, billing. Overusing it for mild cautions trains readers to
  ignore it.
- **Don't open or close a section with a stack of callouts.** Lead with the prose
  that gives context, then the callout for the exception.
- **A callout is not a substitute for structure.** If half the page is callouts,
  the happy-path prose is missing — write that first.

---

## Hyperlinking: when and to what

The Claude docs link generously but never decoratively. The governing principle:
**link the first mention of anything that has its own page or section, then don't
re-link it in the same section.**

Link these:

- **First mention of any concept, product, or object** that has a page:
  "[Claude Code](/docs/…)", "[Files API](/docs/…)", "a [workflow](/…)".
- **Prerequisites**, as a bulleted list of links at the top of a quickstart.
- **The deeper reference after a summary**: "For complete parameter details, see
  the [Workspaces API reference](/…)."
- **In-page jumps** to a section: "assign them a
  [workspace role](#workspace-roles-and-permissions)".
- **Related pages at the bottom**, in a `## See also` list.

Inline link vs Card — decide by intent:

- **Inline link** = "if you want more on this, it's here" (optional, mid-sentence,
  doesn't break flow).
- **Card** = "this is a place I'm sending you next" (a destination, visually
  prominent, used in "Next steps" and landing pages).

Don't:

- Link the same page five times in one section. Once, on first mention.
- Use bare link text like "click [here]". Link the noun: "[the Connect
  portal]".
- Card-ify an optional aside, or inline-link a primary next step that deserves a
  Card.

---

## Code blocks

- **Always label the language and, when useful, the role:** ```bash cURL,
  ```json Output, ```python Python. The role label (cURL / Output) tells the
  reader whether they're looking at input or result.
- **Pair input with output.** A request block is followed by its response block
  so the reader can verify success.
- **Inside `<Tabs>`, put a full `<Steps>` per tab** so each language is a
  complete path — don't make the reader stitch steps across tabs.

---

## Diagrams

A product with an architecture should show it. A single `mermaid` flowchart on
the "How it works" / overview page beats three paragraphs of data-flow prose.

**Theme every diagram with the neutral dual-mode palette** below — never a
brand-colored dark-background palette. The docs render in both light and dark
mode, and a diagram that hardcodes a dark fill (charcoal nodes, blue accents)
disappears against the white light-mode page. The fix is to give nodes their own
light surface with dark text so they read on *any* background:

```
%%{init: {'theme':'base','themeVariables':{'primaryColor':'#E2E8F0','primaryTextColor':'#1E293B','primaryBorderColor':'#64748B','lineColor':'#64748B','secondaryColor':'#E2E8F0','tertiaryColor':'#F1F5F9','tertiaryTextColor':'#1E293B'}}}%%
```

Light-gray nodes (`#E2E8F0`) + dark text (`#1E293B`) + mid-gray lines/borders
(`#64748B`) stay legible on both white and dark canvases. Use the same block on
every diagram so they look consistent. See `references/component-catalog.md`.

---

## Design checklist before shipping

- Did every numbered procedure become `<Steps>` (unless it's a trivial 2–4 step
  inline list)?
- Did every two-dimensional comparison become a table?
- Is each callout the right *type* for its intent, one idea each, with `<Warning>`
  reserved for real consequences?
- Is the first mention of each concept/object linked — and not re-linked all over
  the section?
- Are "next steps" Cards, and optional asides inline links?
- Do code blocks have language+role labels, and does each request show its
  response?
- If the thing has an architecture, is there a diagram?
