# Page skeletons by page type

Pick the skeleton that matches the page's job, then fill it. All examples are
drawn from the patterns observed on platform.claude.com (Workspaces, Models
overview, Get started).

## Table of contents
- [Concept / how-to page](#concept--how-to-page) — the default
- [Quickstart / tutorial page](#quickstart--tutorial-page)
- [Pure reference page](#pure-reference-page)
- [Overview / landing page](#overview--landing-page)

---

## Concept / how-to page

This is the default skeleton (the Claude "Workspaces" page is the model).

```mdx
---
title: "Workspaces"
description: "Organize API keys, manage team access, and control costs with workspaces."
---

Workspaces provide a way to organize your API usage within an organization. Use
workspaces to separate different projects, environments, or teams while
maintaining centralized billing and administration.

## How workspaces work

Every organization has a **Default Workspace** that cannot be renamed... When you
create additional workspaces, you can assign API keys, members, and resource
limits to each one.

Key characteristics:
- **Workspace identifiers** use the `wrkspc_` prefix (for example, `wrkspc_01Jw…`)
- **Maximum 100 workspaces** per organization (archived workspaces don't count)

## Workspace roles and permissions

| Role | Permissions |
|------|-------------|
| Workspace User | Use the Workbench only |
| Workspace Developer | Create and manage API keys, use the API |

## Managing workspaces

### Using the Console
#### Create a workspace
<Steps> … </Steps>

### Using the Admin API
```bash cURL
…
```

## API keys and resource scoping
## Common use cases
## Best practices
<Steps> … </Steps>

## FAQ
<section title="What's the Default Workspace?"> … </section>

## See also
- [Admin API](/docs/…)
- [Rate limits](/docs/…)
```

**Rules of thumb:**
- "How X works" is mandatory and comes first. It carries the mental model plus a
  "Key characteristics" bulleted list with bolded lead terms.
- Group procedures by *surface* (Console vs API) under "Managing X", with `###`
  per surface and `####` per individual procedure.
- "Common use cases" is a table (`Use case | Purpose`) or short bulleted
  scenarios — not paragraphs.
- "Best practices" is a `<Steps>` list where each step is a recommendation with a
  one-sentence rationale.
- FAQ uses `<section title="Question?">` blocks (Mintlify renders them as
  accordions). Phrase titles as the literal question a user would ask.
- "See also" is the last thing on the page: a bullet list of related page links.

---

## Quickstart / tutorial page

Model: the Claude "Get started" page. Goal — reader has a working result in
minutes.

```mdx
---
title: "Get started with Refold"
description: "Make your first … and build a … in minutes."
---

## Prerequisites
- A Refold [account](…)
- An [API key](…)

## <Do the thing>
<Tabs>
  <Tab title="cURL">
    <Steps>
      <Step title="Set your API key"> … ```bash``` </Step>
      <Step title="Make your first call"> … ```bash cURL``` then ```json Output``` </Step>
    </Steps>
  </Tab>
  <Tab title="Node"> <Steps> … </Steps> </Tab>
</Tabs>

## Next steps
<Card title="…" icon="…" href="…">…</Card>
<CardGroup cols={3}> … </CardGroup>
```

**Rules of thumb:**
- Open with `## Prerequisites` as a short bulleted list of links. No preamble.
- Wrap multi-language flows in `<Tabs>`, with a `<Steps>` block *inside each tab*
  so each language is a complete, copy-pasteable path.
- Always pair an input code block with its `Output` code block so the reader can
  verify success: ```bash cURL then ```json Output.
- End with "Next steps": one headline `<Card>` for the single best next action,
  then a `<CardGroup cols={3}>` for the broader menu.
- Tutorial voice is "You made your first call. Next, learn…" — celebrate the
  win, then point forward.

---

## Pure reference page

For exhaustive, lookup-style content (node reference, field types, API params).

```mdx
---
title: "HTTP request node"
description: "Send an HTTP request to any endpoint from a workflow."
---

<one-sentence definition>

## Configuration
| Field | Type | Description |
|-------|------|-------------|

## Examples
```json … ```

## See also
```

**Rules of thumb:**
- No narrative. Lead with the definition, then go straight to the parameter
  table.
- Alphabetize or group consistently; reference pages are scanned, not read.
- The conceptual "what is a node" explanation lives once on the concept page, not
  repeated here. Link to it.

---

## Overview / landing page

For a tab or section root. Model: the bottom of the Claude "Models overview".

```mdx
---
title: "MCP"
description: "Give your agent secure access to enterprise tools."
---

<one-paragraph positioning: what this product is and who it's for>

<CardGroup cols={3}>
  <Card title="Quickstart" icon="play" href="…">Set up your first … in 5 min</Card>
  <Card title="How it works" icon="diagram-project" href="…">The architecture</Card>
  <Card title="Concepts" icon="book" href="…">Core ideas</Card>
</CardGroup>
```

**Rules of thumb:**
- A landing page's job is to route, not to teach. One positioning paragraph, then
  cards.
- Use `<CardGroup cols={3}>` with an `icon` and a one-line body per card.
- If the product has an architecture, a single diagram beats three paragraphs.
