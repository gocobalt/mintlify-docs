# Refold documentation structure

The reference map of the Refold docs site: how it is organized, what each tab
owns, and where a new page belongs. Read this before creating or moving a page so
content lands in the right place and the navigation stays coherent.

This file describes the **v3 target structure** (the rewrite locked 2026-05-07,
spec in `v3/FINAL-DOCUMENTATION-STRUCTURE.md`). The live site today is configured
in `docs.json`; v1/v2 legacy trees still exist under their own directories. When
the v3 cutover happens, the `/v3/` prefix is dropped and old paths 301-redirect.

---

## The governing model

Refold ships **three products on one shared platform**:

| Product | Persona | Job-to-be-done |
|---------|---------|----------------|
| **Native** | SaaS product engineer | Embed third-party integrations into your SaaS app |
| **Integration Delivery** | Solution architect | Deliver bespoke enterprise integrations with AI agents |
| **MCP** | AI engineer | Give an agent secure access to enterprise tools |

The shared substrate (linked accounts, connectors, workflows, auth, deploy,
security) lives **once** in **Platform** and the product tabs cross-link into it.
API Reference and SDKs are shared reference.

**The placement test for any new page:** *"Would this page also be true for the
other two products?"* If yes → Platform. If no → the product tab. This is what
keeps duplication from creeping back.

---

## Top-level navigation (six tabs)

```
Platform │ Native │ Integration Delivery │ MCP │ API Reference │ SDKs
```

| # | Tab | Owns | Maps to directory |
|---|-----|------|-------------------|
| 1 | **Platform** | Concepts, build apps/workflows, admin, deploy, operate, security | `developer/` → `platform/` |
| 2 | **Native** | Embed flow, customization, Native-only workflow patterns | `embedded/` → `native/` |
| 3 | **Integration Delivery** | AI lifecycle (FSD→go-live), Workflow Agent, Field-Mapping Workbench | `project/` → `integration-delivery/` |
| 4 | **MCP** | MCP server, workflow-as-MCP, chains, connect-your-agent | `mcp-ai-agents/` → `mcp/` |
| 5 | **API Reference** | OpenAPI-driven endpoint reference | `api-reference/` (from `openapi.yaml`) |
| 6 | **SDKs** | Node, React, browser-JS SDKs | `sdks/` |

Topbar (right): Integrations catalog · Changelog · Status · Dashboard CTA.
Root `/` is a standalone three-card persona landing page, not a tab.

---

## What each tab contains

### Platform (the shared substrate)
`Get started` · `Core concepts` (linked accounts, apps & connectors, workflows,
triggers & actions, events & webhooks, auth flows, data references, tables) ·
`Build apps & connectors` · `Build workflows` (incl. the single canonical
**Nodes** reference) · `Workspace administration` · `Auth & white-label` ·
`Deploy` · `Operate` · `Security & compliance`.

### Native (lean — cross-links into Platform)
`Overview` · `Quickstart` · `How Native works` · `Embed` (React SDK flow, hosted
flow, build-your-own-UI, customization, connection management) · `Workflow
patterns for Native` · `Integration settings` · `Recipes`.

### Integration Delivery (the headline AI story)
`Overview` · `Quickstart` · `How it works` · `Concepts` · `Lifecycle`
(FSD → TSD → field mapping → workflow generation → testing → go-live) · `Workflow
Agent` · `Field-Mapping Workbench` · `Knowledge base` · `Testing` · `Operate` ·
`Examples` · `Enterprise`.

### MCP
`Overview` · `Quickstart` · `How MCP works` · `Concepts` · `Build` · `Connect
your agent` (Claude Desktop, Claude Code, ChatGPT, Cursor, custom clients) ·
`Examples` · `Enterprise`.

---

## Page-type → Diátaxis mapping

Every page is one of four types. Knowing the type sets the structure (see the
`claude-doc-style` skill for the matching skeleton).

| Type | Where it lives | Voice |
|------|----------------|-------|
| **Tutorial** | Quickstart, Recipes, Examples | "Do this, then this — by the end you'll have…" |
| **How-to** | Build, Embed, Connect your agent, Install | "To accomplish X, do Y" |
| **Reference** | API Reference, SDKs, Nodes, Field types | Exhaustive, alphabetized, no narrative |
| **Explanation** | Overview, How it works, Concepts | "Why it works this way" |

A node/field page is **reference only**. The conceptual "what is a node" lives
once on the concept page; reference pages link to it instead of re-explaining.

---

## Where AI features are documented

AI features sit **next to the human-equivalent feature they augment**, not in a
separate "AI" section. Exceptions: MCP (its own product) and Integration Delivery
(AI is the substrate).

- AI-assisted custom apps → Platform / Build apps & connectors
- Agent node → Platform / Build workflows / Nodes
- Workflow Agent, Field-Mapping Workbench, Knowledge base → Integration Delivery
- MCP server, workflow-as-MCP, chains → MCP

---

## House conventions (apply on every page)

- **Files are `.mdx`** with `title` + benefit-led `description` frontmatter.
- **A new page must be added to navigation** (`docs.json`, or `mint.json` on
  legacy trees). A page not in nav is invisible.
- **URLs** are lowercase, hyphenated, and mirror the directory path.
- **Images** live in `images/<feature>/`; logos in `logo/`; reusable fragments in
  `_snippets/`.
- **One canonical home per concept.** Before creating a page, search for an
  existing one — update or link rather than duplicate (the v3 audit found the
  same concept described in up to 4 places).
- **Naming:** Refold (never Cobalt); Native (not Embedded); Integration Delivery
  (not Project); MCP (not "MCP / AI Agents").

---

## Authoring skills that enforce this

When writing or editing a page, these skills apply (the `/doc-pattern` command
chains all three):

- **`claude-doc-style`** — page skeleton and sentence-level style.
- **`refold-voice`** — terminology, product names, brand tone.
- **`mintlify-design`** — component, callout, and link choices.

For mechanical page creation + navigation registration, see
`.claude/skills/new-page.md`.
