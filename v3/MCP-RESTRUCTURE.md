# MCP tab — restructure proposal

Branch: `mcp-rework`. Goal: cut the AI-slop duplication in the MCP tab, collapse
over-split topics, add the missing Authentication page, and stop re-explaining
concepts that already live in Platform.

---

## 1. Current state (what's there today)

The live MCP tab (`docs.json`) has **18 pages in 4 groups**, plus **4 orphan
stub files** not in navigation. Source: `v3/mcp-ai-agents/`.

```
Getting Started
├── what-is-mcp            overview/positioning            (93L)
├── architecture           "How it works" / request flow   (146L)
├── choose-your-pattern    direct vs agent vs workflow     (67L)
├── getting-started        Quickstart                      (154L)
└── connect-from-agent-code SDK wiring                      (211L)
Build
├── server-configuration   dashboard config                (103L)
├── Skills/
│   ├── overview           when/how skills work            (63L)
│   ├── creating-skills    fields + structure              (78L)
│   └── examples           2 worked examples               (150L)
└── Workflows/
    ├── overview           when to use, how it appears      (43L)
    ├── reliability        guarantees                        (41L)
    ├── configuration      how to add                        (36L)
    └── examples           SAP example                       (69L)
Reference
├── concepts               re-defines Refold objects         (55L)
└── tools                  full tool reference               (255L)
Operate
├── mcp-logs               audit trail                       (109L)
├── debugging              MCP Inspector + logs              (95L)
└── security-compliance    auth + isolation + audit + TLS    (144L)

Orphan stubs (not in nav, "Content coming soon"):
  overview/use-cases · enterprise/advanced-security
  implementation/account-hierarchy · implementation/multi-tenant-workflows
```

## 2. What's wrong

### 2.1 The same ideas are explained 3–4 times (the slop)

| Idea | Re-explained in |
|------|-----------------|
| The three patterns (direct / agent+skills / workflow) | `what-is-mcp` ("Three patterns"), `choose-your-pattern` (whole page), `architecture` (direct-mode naming) |
| Operating modes (direct vs agent) | `what-is-mcp` ("Two operating modes"), `choose-your-pattern`, `tools`, `architecture` |
| What gets logged / audit | `mcp-logs` (whole page) **and** `security-compliance` ("Audit logging" section) |
| Refold objects (application, linked account, connector) | `concepts` — but these are **Platform** concepts with canonical pages |

### 2.2 Over-split topics

- **Skills** is 3 pages for one topic. `overview` + `creating-skills` + `examples`
  is one page's worth of content.
- **Workflows as tools** is 4 pages (overview / reliability / configuration /
  examples) for a topic that fits comfortably on one page.

### 2.3 A page that is mislabeled

`security-compliance` is really four things bolted together:
**Authentication** (token model, per-user URLs, revocation), tenant isolation,
audit logging (duplicates MCP Logs), and transport/data governance. The
authentication content is the most-needed part and is buried under a
"compliance" label where readers won't look for it.

### 2.4 Missing page

There is **no dedicated Authentication page**, even though "how an agent
authenticates to an MCP server" is one of the first questions a builder asks.

### 2.5 Dead stubs

Four "Content coming soon" files exist on disk and are not in nav. They add
clutter and risk being shipped half-empty.

---

## 3. Proposed structure

**13 pages in 5 groups** (from 18 + 4 orphans). Concepts removed, Skills and
Workflows collapsed to one page each, Authentication added.

```
MCP/
├── Get started
│   ├── Overview              ← what-is-mcp (trim duplicate mode/pattern sections)
│   ├── Quickstart            ← getting-started
│   ├── How it works          ← architecture + MCP-specific objects from concepts
│   └── Choose your pattern   ← choose-your-pattern (the ONE pattern-decision page)
│
├── Build
│   ├── Server configuration  ← server-configuration
│   ├── Skills                ← MERGE skills/{overview,creating-skills,examples}
│   └── Workflows as tools    ← MERGE workflow-as-mcp/{overview,reliability,configuration,examples}
│
├── Connect
│   ├── Connect from agent code  ← connect-from-agent-code
│   └── Authentication & access  ← NEW (extracted from security-compliance)
│
├── Reference
│   └── Tools                 ← tools-reference/tools
│
└── Operate
    ├── MCP Logs              ← mcp-logs (canonical audit/logging page)
    ├── Debugging             ← debugging
    └── Security & compliance ← security-compliance MINUS auth (link out instead)
```

---

## 4. Page-by-page disposition

| Current page | Action | Notes |
|--------------|--------|-------|
| `overview/what-is-mcp` | **Keep** as Overview | Replace "Two operating modes" + "Three patterns" with a 1-row-per-pattern table that links to *Choose your pattern*. Stop explaining patterns twice. |
| `overview/getting-started` | **Keep** as Quickstart | — |
| `overview/architecture` | **Keep** as How it works | Absorb the MCP-specific objects from `concepts` (MCP server, and how actions/workflows/skills become tools). |
| `overview/choose-your-pattern` | **Keep** | Becomes the single canonical home for the direct / agent+skills / workflow decision. |
| `overview/concepts` | **Delete** | Platform concepts (application, linked account, connector) are duplicated — link to Platform instead. MCP-only objects move to How it works. |
| `overview/server-configuration` | **Keep** | — |
| `skills/overview` | **Keep** as the merged **Skills** page | — |
| `skills/creating-skills` | **Merge → Skills** | Becomes the "Create a skill" section. |
| `skills/examples` | **Merge → Skills** | Becomes the "Examples" section (trim to 1–2). |
| `workflow-as-mcp/overview` | **Keep** as merged **Workflows as tools** | — |
| `workflow-as-mcp/reliability` | **Merge → Workflows as tools** | "What you get" section. |
| `workflow-as-mcp/configuration` | **Merge → Workflows as tools** | "Add a workflow" `<Steps>` section. |
| `workflow-as-mcp/examples` | **Merge → Workflows as tools** | "Example" section. |
| `connect-from-agent-code` | **Keep** | Move under a **Connect** group. |
| `implementation/security-compliance` | **Split** | Extract auth/access/revocation → new Authentication page. Keep the rest (tenant isolation, transport, data handling, deployment); replace its "Audit logging" section with a link to MCP Logs. |
| `tools-reference/tools` | **Keep** as Reference | — |
| `security/mcp-logs` | **Keep** | The one canonical audit/logging page. |
| `security/debugging` | **Keep** | — |
| `overview/use-cases` | **Delete** | Empty stub; merge any real use cases into Overview. |
| `enterprise/advanced-security` | **Delete** | Empty stub. |
| `implementation/account-hierarchy` | **Delete** | Empty stub (the platform concept, if needed, belongs in Platform). |
| `implementation/multi-tenant-workflows` | **Delete** | Empty stub; tenant isolation is covered in Security & compliance. |
| — | **New: Authentication & access** | See §5. |

Net: 22 files → 13 pages. Removed: 4 orphan stubs + `concepts` + 5 merged-away
pages. Added: 1 (Authentication).

---

## 5. The missing page: "Authentication & access"

**Recommended name: `Authentication & access`.** The content covers both
*authentication* (the Server-URL token, validation, per-user URLs) and *access
control* (which apps/actions an agent can reach, token scope, revocation), so a
name that says only "Authentication" undersells the access half. Alternatives if
you prefer one word: **Authentication** (matches how builders search) or
**Connecting securely**.

**Placement:** the **Connect** group, next to *Connect from agent code* — this is
what a builder needs the moment they wire up a Server URL.

**What it owns** (extracted from `security-compliance`):
- The token model: token embedded in the Server URL, validated every request,
  one token per linked account per MCP server.
- Per-end-user URLs and why you issue one per user.
- Token scope, invalid/unavailable behavior (403 / 503 fail-closed).
- Access control: which apps/actions are exposed, Agent Mode / Retrieve Skill
  toggles, per-user scoping.
- Token revocation (regenerate / delete linked account).

**Hyperlink into Platform — do not re-explain:** this page must defer to the
canonical Platform auth model rather than restating it. Link the first mention
of each:
- [Linked accounts](/v3/developer/configure/linked-account) — the token is tied
  to one linked account.
- [Connectors](/v3/developer/guide/build/connectors/overview) — where the
  underlying OAuth/credentials are configured.
- Platform **Auth flows / Authentication strategies** — how end users connect
  their accounts in the first place.

The MCP page should say *"MCP authentication builds on Refold linked accounts —
see [Linked accounts] for the underlying model"* and then cover only what is
MCP-specific (the Server-URL token and access toggles).

---

## 6. The rule that prevents the slop coming back

One canonical home per idea. Everything else links to it.

| Idea | Canonical home | Everyone else |
|------|----------------|---------------|
| Platform objects (application, linked account, connector, workflow, action) | **Platform** concept pages | Link, never redefine |
| The pattern decision (direct / agent / workflow) | **Choose your pattern** | Overview links to it with a 1-line-per-pattern table |
| The request lifecycle / object-to-tool model | **How it works** | — |
| What gets logged | **MCP Logs** | Security & compliance links to it |
| How agents authenticate | **Authentication & access** | Security & compliance links to it |
| Tool parameters | **Tools** (reference) | Concept pages link to it |

**Test for any MCP page:** *"Is this true for the whole platform, not just MCP?"*
→ it belongs in Platform; link to it. *"Have I already explained this on another
MCP page?"* → link to that page instead of repeating it.

---

## 7. Suggested execution order

1. Delete the 4 orphan stubs.
2. Create **Authentication & access** by extracting from `security-compliance`;
   trim `security-compliance` to isolation/transport/data + links.
3. Merge Skills (3→1) and Workflows as tools (4→1).
4. Delete `concepts`; fold MCP-only objects into **How it works**; trim the
   duplicate pattern/mode sections out of **Overview**.
5. Update the MCP `groups` in `docs.json` to the §3 tree; add 301 redirects for
   every removed/renamed path.
6. Run `/doc-pattern` on each surviving page so structure, voice, and components
   match the house style.
