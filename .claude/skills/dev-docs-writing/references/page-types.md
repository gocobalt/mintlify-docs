# Page structures by type

Pick the structure that matches the page's job (you classified this in Stage 1).
Each section below gives the *purpose*, the *skeleton* to follow, and the most
common way that page type goes wrong. These are starting templates, not cages:
drop sections that don't apply, but don't reorder away from "most important
first" without a reason.

## Contents
- [Landing / overview page](#landing--overview-page)
- [Quickstart / tutorial](#quickstart--tutorial)
- [How-to guide](#how-to-guide)
- [Concept / explanation](#concept--explanation)
- [Reference page](#reference-page)

---

## Landing / overview page

**Purpose:** orient a newcomer in under 30 seconds and route them to the right
next page. It is a *map*, not a lesson. Its success metric is "did the reader
leave for the right next page?", not "did they read it all?"

**Reader:** someone who just arrived and doesn't yet know what the product is or
where to go.

**Skeleton:**
1. **What it is, in one or two plain sentences.** Lead with the value, not the
   category: "X lets you add native third-party integrations to your app in a
   few hours, without building or maintaining the integration layer yourself."
   Avoid restating the company name three times.
2. **Who it's for / what problem it removes:** one short paragraph, optional.
3. **Get started:** the single most likely next action, as a prominent link or
   card (usually the Quickstart).
4. **Routing cards/sections:** grouped links to the major areas (Guides,
   Concepts, SDKs, API reference), each with a one-line description of what the
   reader will find there. Group by reader intent, not by your internal org
   chart.
5. *(optional)* A small "popular pages" or "if you want to... go here" table.

**Goes wrong when:** it tries to teach instead of route; it repeats the intro
paragraph; it carries starter-theme boilerplate ("The first step to world-class
documentation..."); the link descriptions are empty or vague. Card descriptions
should tell the reader what they'll be able to *do* after clicking.

---

## Quickstart / tutorial

**Purpose:** take a beginner from nothing to one concrete, visible win, on rails.
The reader is learning the shape of the product by doing, so the win matters more
than completeness. Everything that isn't needed for *this* win is a distraction:
link it, don't inline it.

**Reader:** first-timer who wants proof the product works and a feel for the flow.

**Skeleton:**
1. **Title plus one-line promise:** "By the end you'll have run a live workflow
   and seen its response." State the outcome up front so the reader knows the
   payoff.
2. **Prerequisites:** a short, checkable list (account, key, X installed). All
   of them, before step 1. Nothing should be discovered mid-procedure.
3. **Numbered steps**, each one:
   - starts with a verb ("Configure your credentials", "Fire the event");
   - is one action (split "do A and then B" into two steps);
   - shows the exact command/click and, where useful, **what the reader should
     see** so they can confirm success ("You should see a *Connected* tag next
     to the integration.");
   - keeps explanation to a clause; deep "why" goes in a linked concept page.
4. **Checkpoint / result:** what success looks like, so the reader knows they did
   it ("If the workflow ran, the response appears on your webhook.site tab.").
5. **Next steps:** 2-3 specific links onward ("Customize this workflow", "Add
   your own UI with the SDKs").

**Goes wrong when:** steps bundle multiple actions into one paragraph; the
"happy path" is interrupted by edge cases and caveats (move those to a how-to or
a note); prerequisites are missing so the reader fails at step 3; there's no
visible checkpoint so the reader can't tell if it worked.

---

## How-to guide

**Purpose:** get an experienced reader through one specific, real task. Unlike a
tutorial it assumes competence and doesn't teach the basics; it solves the
problem and gets out of the way.

**Reader:** someone who knows the product and has a job to do right now.

**Skeleton:**
1. **Task-shaped title:** "Authenticate a linked account", "Set up an API proxy
   to capture a workflow response." Name the goal, not the feature.
2. **One-line scope:** what this accomplishes and, if non-obvious, when you'd
   need it.
3. **Prerequisites / assumptions:** brief; what state the reader must be in.
4. **The steps:** numbered, imperative, one action each, same rules as a
   tutorial but terser. Omit hand-holding the reader doesn't need.
5. **Verify:** how to confirm it worked.
6. *(optional)* **Troubleshooting:** the 1-3 failure modes that actually happen,
   each with the fix. *(optional)* **Related tasks** links.

**Goes wrong when:** it re-explains concepts the reader already has (link them
instead); it tries to cover every variant in one page instead of the common path
plus links; the title names a feature ("API Proxies") instead of a task
("Capture a workflow's response").

---

## Concept / explanation

**Purpose:** give the reader a correct mental model of *what something is* and
*why it works the way it does*. No steps; this is for understanding, consulted
when the reader wants to study, not act.

**Reader:** someone who hit a term or behavior and needs the model behind it.

**Skeleton:**
1. **Definition first**, in one sentence, in plain language: "A linked account
   represents one of your customer's connections to a third-party app."
2. **Why it exists / what problem it solves:** the motivation, briefly.
3. **How it fits:** its relationship to the other core objects (a diagram or a
   simple example often does this better than a paragraph; if you add a diagram,
   give it alt text).
4. **Key properties / lifecycle:** the few things the reader must hold in their
   head, ideally as a short list or a small table.
5. **Pointers:** links to the how-tos and reference that *use* this concept.

**Goes wrong when:** it drifts into setup steps (that's a how-to, so split it);
it explains five concepts at once instead of one; it front-loads history or edge
cases before the plain definition.

---

## Reference page

**Purpose:** let a reader look up an exact fact fast and trust it. Reference is
consulted, not read. Optimize for findability and consistency, not narrative.

**Reader:** someone mid-task who needs a parameter, field, endpoint, or value.

**Skeleton:**
1. **Title equals the thing** (the endpoint, object, or config group).
2. **One-line description** of what it is or does.
3. **The facts, in a consistent, scannable structure**, almost always a table or
   a tight definition list. For an API endpoint: method plus path, parameters
   (name, type, required, description), an example request, an example response,
   and the error cases.
4. **A minimal working example** the reader can copy.
5. **Cross-links** to the relevant how-to or concept.

**Rules specific to reference:** be exhaustive and exact (this is the source of
truth); keep entry structure identical across the page so the eye learns the
pattern; describe every parameter, including the boring ones; show real values
in examples, not `foo` or `bar`; flag defaults and required-ness explicitly.

**Goes wrong when:** the voice turns narrative or salesy; parameter tables skip
columns inconsistently; examples use placeholder values that don't actually run;
defaults and required fields are left ambiguous.
