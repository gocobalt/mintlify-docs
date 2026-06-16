---
name: dev-docs-writing
description: >-
  Write or rewrite a single page of public-facing product or developer
  documentation so it is scannable, task-oriented, and effortless to read.
  Use this whenever the user wants to write, rewrite, restructure, tighten, or
  "make more readable" a docs page: an overview/landing page, quickstart,
  how-to guide, concept/explanation, tutorial, API reference, or README, or
  references a docs site (e.g. docs.refold.ai), a ".mdx"/Mintlify/Docusaurus
  page, or says things like "this page reads like a wall of text", "clean up
  our docs", "improve the structure of this page", or "rewrite the overview".
  It applies Diátaxis page structure, a reader-first writing style, and a
  collaborative co-authoring loop. Prefer this over generic prose help anytime
  the deliverable is a documentation page meant for external readers. Do NOT
  use it for internal decision docs / specs / RFCs (use doc-coauthoring), for
  marketing/blog copy, or for Word/PDF deliverables.
---

# Writing public-facing documentation pages

The job of a docs page is to get a reader to *do* or *understand* one thing with
the least friction possible. Readers don't read docs, they scan, grab, and
leave. Every choice on the page either lowers that friction or raises it. This
skill is about consistently lowering it.

Three things make a page good, and this skill covers all three:

1. **Structure:** the right skeleton for *this kind* of page, so a reader can
   navigate it in seconds. See `references/page-types.md`.
2. **Style:** sentences and words that are direct, scannable, and free of
   filler, in the voice of an expert who shipped the thing. See
   `references/writing-style.md`.
3. **Process:** a co-authoring loop that pulls the real context out of the
   author's head, drafts section by section, and tests the page against a cold
   reader before shipping. Described below.

On top of those, three **house conventions** apply to every page, because these
docs run on Mintlify. Keep them in mind throughout and consult
`references/mintlify-and-media.md` for the syntax:

- **Use Mintlify components**, not raw markdown, wherever one fits: `<Steps>`
  for procedures, `<CodeGroup>` for multi-language code, `<CardGroup>` for
  routing, the `<Note>`/`<Warning>`/`<Tip>` callouts, `<Tabs>`, `<Accordion>`.
- **Hyperlink generously.** Link the first mention of any concept, object,
  prerequisite, or next step that has its own page or section. When in doubt,
  link.
- **Add a media placeholder** wherever a screenshot would help the reader map
  words to the UI, marked with a `MEDIA-TODO` that says what to capture. Prefer
  a short video placeholder over a static image.

Read the reference files when you reach the relevant step. Don't try to hold all
the rules in your head up front.

---

## The one rule everything else serves

**Put the most important thing first, then stop adding things.**

This is the inverted pyramid. The first sentence of the page answers "what is
this and why do I care?" The first sentence of each section answers "what does
this section give me?" The first word of a step is the verb. Anything that
doesn't help the reader do the thing gets cut, including the things you were
proud of writing.

Watch for these smells (all of them are real failures pulled from shipped docs,
so they're easy to make):

- **Template leftovers / boilerplate**, e.g. "The first step to world-class
  documentation is setting up your editing environment." This is filler the
  starter theme shipped with. Delete it.
- **Duplicated content:** the same paragraph appearing twice on one page,
  usually from copy-paste. Read the whole page before editing.
- **Wall-of-text steps:** a procedure written as dense prose so the reader can't
  tell where one action ends and the next begins. Break into numbered,
  one-action steps.
- **Marketing voice in reference material**, like "blazing-fast", "world-class",
  "just a jiffy". Docs are not a landing page; readers came to get something
  done.
- **Vague links** like "click here" or "Read Documentation". Link text should
  name the destination.
- **Burying the action:** "The first step is to configure your credentials for
  the integration you want to test if required" becomes "Configure your
  integration credentials."

---

## The co-authoring workflow

Writing a great docs page is mostly an act of *extraction*: the author knows
things the page needs, and the reader knows none of them. The workflow closes
that gap. Adapt the depth to the task: a five-line tweak doesn't need a
context-gathering interview; a from-scratch overview does. When in doubt, ask
the user whether they want the full collaborative loop or a quick freeform pass.

### Stage 1: gather context and pick the page type

First, get oriented. Ask the user (shorthand answers are fine):

1. **What page is this, and what's its URL/path** (so it can be read if it
   already exists)?
2. **Who is the reader:** first-time evaluator, integrating developer, admin?
   What do they already know, and what are they trying to accomplish?
3. **What's the single most important outcome** when someone finishes this page:
   they understand X, they've shipped Y, they can find Z?
4. **What must be true before the reader starts** (prerequisites, accounts,
   keys)?
5. **Any house style, template, or sibling pages** to match?

If the page already exists, read it in full first (use the docs connector, fetch
the URL, or read the file). Note what's salvageable and what's a smell from the
list above. If images lack alt text, flag it: a reader pasting the page into an
AI assistant, or using a screen reader, gets nothing from them.

Then **classify the page** into one of the four Diátaxis modes, because the mode
dictates the structure and the voice:

| Reader is... | Mode | Example page |
|---|---|---|
| learning by doing, on rails | **Tutorial / Quickstart** | "Quickstart", "Build your first integration" |
| trying to accomplish a known task | **How-to guide** | "Authenticate a linked account", "Set up an API proxy" |
| looking a fact up mid-work | **Reference** | API endpoints, config fields, the glossary |
| trying to understand *why/what* | **Explanation / Concept** | "What is a Linked Account?", "How workflows execute" |

A landing/overview page is its own thing: a *map* whose job is to orient and
route, not to teach. Open `references/page-types.md` once you know the mode; it
has a section skeleton for each.

The most common real failure is **mixing modes on one page**: a tutorial
interrupted by three paragraphs of reference detail, or a concept page that
trails off into setup steps. If a page is trying to do two jobs, the fix is
usually to split it and link, not to write harder.

### Stage 2: draft section by section

Don't draft the whole page in one shot. Build the skeleton first, then fill it.

1. **Lay out the skeleton.** Using the matching template from
   `references/page-types.md`, write the page as headings plus one-line
   placeholders (`[what this section will cover]`). Create it as a file (`.mdx`
   or `.md`) in the working directory so there's a shared artifact to point at.
   Confirm the structure with the user before filling it.
2. **Fill the highest-uncertainty section first**, usually the core task or the
   core idea, not the intro. Summaries and "next steps" come last, once the body
   exists to summarize.
3. For each section: ask 2-5 sharp questions about what it must contain, draft
   it applying `references/writing-style.md`, then refine through *surgical
   edits* (`str_replace`), never by reprinting the whole page.
4. Ask the user to react with specific changes ("cut the second bullet, the
   reader already set the key in step 1") rather than editing silently, so their
   preferences carry into later sections.

After 2-3 passes with no substantive change, ask what can be *removed* without
losing meaning. Length is a cost the reader pays.

### Stage 3: test against a cold reader

A page makes sense to its author by definition. The test is whether it makes
sense to someone with zero context.

1. **Predict the reader's questions.** List 5-10 things a real reader would
   arrive wanting to know, or would type into a search/assistant to find this
   page.
2. **Read the page as that stranger.** Drop all conversation context and read
   only the page text. For each predicted question, can the page answer it? What
   does it silently assume the reader already knows? Where would they get stuck
   or guess? (If working in an environment with sub-agents, hand the bare page
   text to a fresh instance and ask it the questions instead; it's a cleaner
   test. In a plain chat, do the cold read yourself, or suggest the user paste
   the page into a fresh Claude conversation and ask it the questions.)
3. **Fix the gaps**, then re-read. Repeat until a cold read surfaces nothing new.

Finish by reminding the user to do their own read-through and verify every fact,
link, code sample, and UI label. They own the page, and a wrong command in docs
is worse than no docs.

---

## Before you call a page done

Run this checklist. It's the compressed form of everything above.

- [ ] First two sentences say what the page is and why the reader cares, with no
      throat-clearing and no boilerplate.
- [ ] The page does **one** job (one Diátaxis mode); secondary material is split
      out and linked.
- [ ] It reads as if an **expert technical product manager** wrote it: specific,
      authoritative, no AI tells, no filler, no empty summary sentences.
- [ ] **No em-dashes** anywhere. Use periods, colons, commas, or parentheses.
- [ ] Headings are descriptive and sentence-case; a reader scanning only the
      headings understands the shape of the page.
- [ ] Procedures are numbered, one action per step, each starting with a verb,
      stating the expected result where it helps.
- [ ] Prerequisites appear *before* the steps, not discovered mid-way.
- [ ] Code is copy-pasteable, minimal, correct, with placeholders explained and
      no real secrets pasted.
- [ ] Links have descriptive text (never "here" or "click here"), and the page
      cross-links related concepts, prerequisites, and next steps.
- [ ] Uses **Mintlify components** where they fit (`<Steps>`, `<CodeGroup>`,
      `<CardGroup>`, callouts) rather than raw markdown.
- [ ] **Media placeholders** (`MEDIA-TODO`, video preferred) mark every spot a
      screenshot or recording would help, each saying what to capture.
- [ ] No duplicated paragraphs, no filler ("simply", "just", "world-class").
- [ ] Ends by pointing the reader to the obvious next step.
- [ ] Images have alt text.

When the user is editing an existing page, preserve their working URL/slug,
front-matter, and any component conventions (Mintlify/Docusaurus tags). Match the
surrounding docs, don't reinvent the house style.
