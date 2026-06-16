---
name: refold-voice
description: >-
  Apply Refold's documentation voice and terminology to any docs content:
  the product name (Refold, never Cobalt/gocobalt), the correct names for
  platform objects (linked accounts, connectors, workflows, MCP server,
  Embedded Agents, Connect portal), the confident-but-plain brand tone, and the
  "no fluff, show the capability" rhythm. Use this whenever writing or editing
  any Refold .mdx page, reviewing a draft for on-brand wording, sweeping
  legacy "Cobalt" branding, or deciding what to call a feature. This skill
  governs WORDING and TERMINOLOGY; pair it with `claude-doc-style` for page
  structure and `mintlify-design` for components. Always apply this skill when
  the deliverable is Refold-facing documentation, even if the user only asks to
  "write the page" without mentioning voice.
---

# Refold documentation voice

Refold helps SaaS companies add third-party native integrations, deliver
enterprise integrations with AI, and expose tools to AI agents over MCP. The
docs should sound like an engineer who built the platform explaining it to
another engineer: confident, concrete, and free of marketing air.

The voice has three moves. Get these right and the page sounds like Refold.

## 1. Define, then prove — no hype

State what the thing is and what it does. Don't sell it. The capability is the
selling.

✅ (from the live MCP page)
> The Model Context Protocol is an open standard for connecting AI agents to
> external systems and data. Refold MCP lets SaaS platforms expose their
> integrations to AI agents over MCP. You configure an MCP server in the Refold
> dashboard, connect the enterprise apps your customers use, and hand them a URL.

🚫 "Refold's powerful, seamless MCP solution revolutionizes how you connect your
agents to a robust ecosystem of best-in-class integrations."

Banned brochure words: *powerful, seamless, robust, revolutionary, cutting-edge,
effortless, unlock, supercharge, best-in-class, game-changing.* If you delete the
adjective and the sentence still states the capability, the adjective was air.

## 2. The triple-fragment punch for emphasis

Refold's voice uses short sentence fragments to drive home what you *don't* have
to do. Use sparingly — once per page at most — right after the main definition.

✅ "No custom integration code. No agent framework. Refold handles
authentication, execution, tenant isolation, and audit logging."

The rhythm is: two or three negations of pain, then one positive sentence listing
what Refold does for you.

## 3. Speak to the builder's job

The reader is integrating Refold into *their* product for *their* customers.
Name those parties. "Your customers connect their tools." "Hand them a URL."
"The apps your customers use."

---

## Terminology — get these exactly right

Wrong terminology is the fastest way to sound off-brand and confuse readers.

### Product and company name

| Use | Never |
|-----|-------|
| **Refold** | Cobalt, gocobalt, Cobalt platform |
| `app.refold.ai`, `docs.refold.ai` | `app.gocobalt.io`, `gocobalt.io` |

Refold was previously branded "Cobalt." Any "Cobalt" / `gocobalt` reference in
existing content is a migration bug — fix it when you touch the page. (One
exception: the API path `Cobalt Connect` in the OpenAPI spec is being renamed to
`Connect` — check before mass-replacing inside `api-reference/`.)

### Platform objects — canonical names

| Canonical term | What it is | Don't call it |
|----------------|-----------|---------------|
| **Linked account** | An end-customer's connected third-party account | connection, integration instance |
| **App** / **Connector** | A supported third-party product (Salesforce, SAP…) | integration (when you mean the connector) |
| **Workflow** | An automation built from triggers + nodes | flow, automation, pipeline |
| **Trigger** | What starts a workflow (event, webhook, schedule, manual, API) | — |
| **Node** | A single step in a workflow | block, action (a node *can* be an action) |
| **MCP server** | A Refold-hosted endpoint exposing integrations to agents | MCP endpoint |
| **Embedded Agents** | The dashboard area for MCP servers | — |
| **Connect portal** | The hosted end-user connection UI | connect page |
| **Native** | The product for embedding integrations in your SaaS | Embedded (legacy tab name) |
| **Integration Delivery** | The AI-driven enterprise integration product | Project (legacy name) |

When in doubt about a feature name, grep the codebase for how an existing real
(non-stub) page refers to it, and match that. Consistency beats cleverness.

### Capitalization

- **Refold** — always capital R, never all-caps.
- Product names — Title Case: **Native**, **Integration Delivery**, **MCP**.
- Platform objects — lowercase in prose ("create a workflow", "a linked
  account"), Title Case only when it's a literal UI label or a defined term's
  first introduction.
- Code identifiers, API fields, and UI buttons — wrap in backticks or bold them
  exactly as they appear: `workspace_id`, **Create workspace**.

---

## Numbers and claims

- Integration count: write **"300+ connectors"** (the live MCP page uses 300+).
  The CLAUDE.md says "140+ providers" for the older catalog — check which surface
  you're documenting and match the number used there rather than guessing.
- Don't invent metrics, SLAs, or limits. If you don't have the real number, leave
  a `TODO:` rather than a plausible-sounding fabrication.

## Voice checklist before shipping

- Did you say **Refold** (not Cobalt) everywhere, including URLs?
- Are platform objects named with their canonical terms?
- Did you cut every brochure adjective?
- Does the page state capabilities instead of selling them?
- If you used the fragment-punch, is it just once and right after the definition?
- Are real product/customer parties named (your customers, their agents)?
