# Writing style for docs

These are the sentence- and word-level rules. They're drawn from the conventions
behind the docs people consistently praise (Stripe, Twilio, Google's developer
documentation style guide) and tuned for a reader who is busy, skimming, and
possibly not a native English speaker. The throughline: be direct, be concrete,
be brief, and write for the reader who is scanning.

Each rule has a *why* and a before / after, because the rewrite is the part that
actually transfers.

## Contents
- [Sound human, sound expert](#sound-human-sound-expert)
- [Voice and tense](#voice-and-tense)
- [Punctuation: no em-dashes](#punctuation-no-em-dashes)
- [Sentences and paragraphs](#sentences-and-paragraphs)
- [Headings](#headings)
- [Procedures and steps](#procedures-and-steps)
- [Lists and tables](#lists-and-tables)
- [Links](#links)
- [Code and examples](#code-and-examples)
- [Notes, warnings, and tips](#notes-warnings-and-tips)
- [Words to cut](#words-to-cut)

---

## Sound human, sound expert

The page should read as if an expert technical product manager wrote it: someone
who built or shipped the feature, knows exactly where readers get stuck, and is
explaining it to a competent peer. That voice is calm, specific, and
authoritative. It states how things work without hedging, anticipates the real
question behind the reader's question, and never pads.

This also means avoiding the tells of machine-generated text, because they read
as generic and erode trust:

- **No formulaic framing.** Cut "In today's fast-paced world", "It's important
  to note that", "When it comes to X". Start with the substance.
- **No reflexive triads.** Not every sentence needs three parallel items
  ("fast, reliable, and scalable"). Say the thing that's true and specific.
- **No restating the prompt or the heading** in the first sentence of a
  section. The heading already said it; add information.
- **No empty summary sentences** like "By leveraging these features, users can
  effectively manage their integrations." If the closing sentence only restates
  the page, delete it.
- **No inflated vocabulary** where a plain word is exact: "use" not "utilize",
  "lets you" not "empowers you to", "helps" not "facilitates".
- **Commit to specifics.** An expert writes "this runs server-side because the
  request carries your secret key", not "for security reasons". Concrete beats
  vague every time.

The test: read the page aloud. If it sounds like a knowledgeable colleague
explaining it at a whiteboard, it passes. If it sounds like a brochure or a
template, rewrite it.

## Voice and tense

- **Second person, present tense, active voice.** Address the reader as "you",
  describe the system in the present, and put the actor before the verb. It
  reads as instructions to a person, which is what docs are.
  - *Before:* "The credentials will be configured by the user." *After:*
    "Configure your credentials."
- **Conversational but not chatty.** Warm and plain, not stiff, not jokey. The
  reader is mid-task; respect their time.
- **Don't congratulate the product.** Keep adjectives like "powerful",
  "seamless", and "world-class" out of docs. They're noise to someone trying to
  get something done, and they erode trust in the reference material.

## Punctuation: no em-dashes

Do not use em-dashes (—) anywhere in the documentation. They're a common tell of
machine-generated prose, and every place one appears, a cleaner mark does the
job. Choose the replacement by what the dash was doing:

- **Joining two independent clauses** -> use a period (two sentences) or a
  semicolon. "It runs server-side — the key is secret" becomes "It runs
  server-side. The key is secret."
- **Introducing an explanation or list** -> use a colon. "One field matters —
  the linked account ID" becomes "One field matters: the linked account ID."
- **An aside or parenthetical** -> use commas or parentheses. "The token, which
  expires hourly, must be refreshed" or "(it expires hourly)".
- **A label followed by its definition** -> use a colon. "Short paragraphs —
  1-4 sentences" becomes "Short paragraphs: 1-4 sentences."

Also avoid spaced hyphens ( - ) standing in for an em-dash; pick a real mark
above. En-dashes are fine in number ranges (1-4 sentences). Arrows (->) are fine
in before/after examples.

## Sentences and paragraphs

- **One idea per sentence; short sentences win.** If a sentence has two "and"s
  and a "which", split it.
- **Front-load the sentence with what matters.** The reader may only read the
  first few words.
  - *Before:* "In most integrations where you want to fetch some data, you'll
    need to set up an API proxy to capture the workflow's final response during
    testing." *After:* "To capture a workflow's response during testing, set up
    an API proxy. (Not every workflow needs one, so skip this if yours
    doesn't.)"
- **Short paragraphs:** 1-4 sentences. A paragraph is a unit of one thought;
  when it sprawls, the reader loses the thread and can't scan it.
- **Cut hedging and throat-clearing.** "It's worth noting that", "Basically",
  and "As you may know" add nothing.

## Headings

- **Sentence case**, not Title Case: "Set up an API proxy", not "Set Up An API
  Proxy."
- **Descriptive, not cute.** A reader scanning only the headings should
  understand the page. "Configure your credentials" beats "Getting ready."
- **Task-shaped on how-tos and tutorials** (verb phrases); **noun-shaped on
  concept and reference pages**. Keep sibling headings parallel in form.
- **No skipped levels** (don't jump H2 to H4) and no stacked headings with no
  text between them.

## Procedures and steps

This is where docs most often fail, and the fix has the highest payoff.

- **Numbered list for anything sequential.** If order matters, it's a numbered
  list, not a paragraph.
- **One action per step.** "Click *Get Hosted URL*, then generate and copy it,
  then open it in a new tab" is three steps, not one.
- **Start each step with the verb** (imperative): "Navigate to...", "Paste...",
  "Click *Save*."
- **Name UI elements exactly** and format them consistently (for example, bold
  for buttons and labels). Don't say "the button below"; position-based
  references break for screen readers and when layouts change.
- **State the result when it reassures the reader:** "Click *Connect*. A
  *Connected* tag appears next to the integration."
- *Before (real wall-of-text step):* "Go to Linked Accounts section in Refold
  and open any Linked Account present. You can also create a new linked account
  if you want by clicking on + Add Account button in the top right. Click on Get
  Hosted URL button > Generate Hosted URL > Copy the URL shown and open it in a
  new tab."
- *After:*
  > 1. Go to **Linked Accounts** and open any account (or create one with
  >    **+ Add Account**).
  > 2. Click **Get Hosted URL**, then **Generate Hosted URL**.
  > 3. Copy the URL and open it in a new tab.

## Lists and tables

- **Bulleted list** for unordered, parallel items. **Numbered list** for
  sequences and ranked items. **Table** for anything the reader looks *up* by a
  key (parameters, options, comparisons).
- **Keep list items parallel:** same grammatical form, roughly same length.
- **Don't bury a procedure in a bullet list.** If the items are sequential
  actions, number them.
- **Lead each bullet with the keyword** so the list is scannable down the left
  edge.

## Links

- **Link text names the destination.** Never "click here", "here", or "Read
  Documentation". The link text should make sense read out of context (it's
  what screen-reader users hear in a links list).
  - *Before:* "To get your credentials, click on Read Documentation." *After:*
    "Get your credentials from the [integration's setup guide]."
- **Link the first, most relevant mention**, not every mention.
- **Cross-link proactively** to related concepts, prerequisites, and next steps;
  link to a specific section with a `#anchor` when only part of a page applies.
  See `mintlify-and-media.md` for path and anchor conventions.
- **Prefer linking over inlining** when material belongs to another mode. Link
  the concept page rather than re-explaining it inside a tutorial.

## Code and examples

- **Examples must be copy-pasteable and correct.** A wrong command in docs
  costs the reader more than no command.
- **Minimal but complete:** show the smallest thing that actually runs, with
  required imports and setup, nothing extraneous.
- **Explain placeholders.** If the reader must substitute a value, make it
  obvious (`YOUR_API_KEY`) and say where it comes from.
- **Show real-looking values in examples**, not `foo` or `bar`, so the reader
  can map them to their own data. Never paste a real secret or token; use a
  labeled placeholder.
- **Format inline code, fields, endpoints, and filenames in code font** so
  they're visually distinct from prose.

## Notes, warnings, and tips

Use callouts sparingly. If everything is highlighted, nothing is.
- **Warning/Caution:** only for irreversible or dangerous outcomes (data loss,
  cost, security). "If your developer app isn't published, you can't
  authenticate accounts outside the developer environment" is a real warning, so
  surface it as one, near the step it affects, not buried in a paragraph.
- **Note:** a genuinely useful aside the reader can skip.
- **Tip:** an optional shortcut or best practice.
- Put the callout **next to the step it affects**, not paragraphs away.

## Words to cut

These almost always weaken docs:
- **"Simply", "just", "easy", "obviously":** condescending when the reader is
  stuck, and they add nothing. Cut them.
- **"In order to"** becomes "to". **"At this point in time"** becomes "now".
  **"Utilize"** becomes "use". **"A number of"** becomes "several" or the actual
  number.
- **Future tense for present behavior:** "the page will display" becomes "the
  page displays".
- **Ambiguous "it" or "this":** name the thing. "This is important" becomes
  "This validation step is important."
- **"etc." and trailing "and so on":** either the list matters (complete it) or
  it doesn't (cut it).
- **Latin abbreviations** in body text: prefer "for example" over "e.g." and
  "that is" over "i.e." for readers scanning quickly or reading in a second
  language.
