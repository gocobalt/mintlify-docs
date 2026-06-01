# Mintlify components, links, and media placeholders

These docs are built on Mintlify (MDX), so three conventions apply to every page
you write or rewrite. They're defaults, not suggestions: reach for a component
before raw markdown, link generously, and mark where visuals belong.

(If a project ever uses a different platform, match that platform's components
instead. Everything else in this skill still holds.)

## 1. Use Mintlify components

Plain markdown works, but a Mintlify component almost always communicates better.
Default to the component that fits the content:

| Content | Component | Notes |
|---|---|---|
| A sequence of actions | `<Steps>` / `<Step title="...">` | The default for any procedure. One action per `Step`. |
| Two or more code variants (cURL, Node, Python) | `<CodeGroup>` | Each fenced block needs a title, e.g. ` ```bash cURL `. |
| Routing / next-step links on overviews | `<CardGroup cols={n}>` / `<Card title icon href>` | Each card's body is a one-line description of the destination. |
| A caution, aside, or tip | `<Warning>` `<Note>` `<Info>` `<Tip>` `<Check>` | `Warning` only for dangerous/irreversible actions. Use sparingly. |
| Alternative paths (OS, language, plan) | `<Tabs>` / `<Tab title="...">` | For content the reader picks one of, not sequential. |
| Optional / collapsible detail | `<Accordion>` / `<AccordionGroup>` | Keep the happy path visible; hide edge cases here. |
| API parameters and responses | `<ParamField>` / `<ResponseField>` | Use on reference pages instead of prose. |
| An image or video | `<Frame>` | See media placeholders below. |

Match the surrounding pages: if the docs already use a component a certain way,
follow that pattern rather than introducing a new style. Preserve the page's
front-matter (`title`, `description`) and slug when rewriting.

## 2. Hyperlink to related pages and sections

A reader who hits an unfamiliar term or a "you'll need X first" should be one
click from the page that explains it. Link proactively:

- **Link the first mention** of any concept, object, or feature that has its own
  page (a linked account, a workflow, an API proxy, auth flows).
- **Link prerequisites and next steps** explicitly, so the reader never has to
  search for where to go before or after.
- **Link to a specific section** with an anchor when only part of a page is
  relevant: `[set up the API proxy](/quickstart#set-up-an-api-proxy)`. Anchors
  are the heading text, lowercased, spaces to hyphens.
- **Use relative paths** (`/concepts/linked-account`), not absolute URLs, for
  internal links.
- **Keep link text descriptive** (the rule in `writing-style.md` still holds):
  the text names the destination, never "here".

When in doubt, link. An extra cross-link costs the reader nothing; a missing one
sends them to search.

## 3. Add media placeholders where a visual would help

Most UI procedures are clearer with a screenshot, and clearer still with a short
screen recording. You usually can't produce the asset, but you can mark exactly
where it goes and what it should show, so the author just drops it in.

**Prefer a video placeholder over an image placeholder.** A 10-20 second screen
recording of a flow ("create a linked account from the dashboard") teaches more
than a static shot and ages better than prose steps.

Add a placeholder wherever the reader would otherwise have to map words to a UI
they can't see: multi-step dashboard flows, "click the three-dot menu" style
interactions, anything where *what they should see* confirms success.

Use a `<Frame>` with a clear, greppable `MEDIA-TODO` marker describing the asset.
Default to video:

```mdx
{/* MEDIA-TODO (video, preferred): 15s screen recording of Dashboard >
    Linked Accounts > + Add Account, filling ID, Name, and UDF, then Save. */}
<Frame caption="Creating a linked account from the dashboard">
  <video controls className="w-full aspect-video rounded-xl" src="/videos/PLACEHOLDER.mp4" />
</Frame>
```

Fall back to an image placeholder only when a static shot is genuinely enough
(a single screen, a settings panel, an end-state):

```mdx
{/* MEDIA-TODO (image): screenshot of the Integrations tab with the
    three-dot menu open, showing the Logs option. */}
<Frame caption="Opening integration logs">
  <img src="/images/PLACEHOLDER.png" alt="Integrations tab with the three-dot menu open on Logs" />
</Frame>
```

Rules for placeholders:
- Every `MEDIA-TODO` says **what to capture**, specific enough to record without
  guessing.
- Always include a real `caption` and, for images, real `alt` text up front, so
  the page is accessible and the AI-readability holds even before the asset
  lands.
- Place the media right after the step or paragraph it illustrates, not at the
  top of the section.
- Don't overdo it: one good walkthrough video per procedure beats a screenshot
  on every step.
