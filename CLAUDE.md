# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the Mintlify-hosted documentation site for **Refold** (previously branded as "Cobalt"), a platform that enables SaaS companies to add third-party native integrations. The site documents 140+ integration providers, a REST API, SDKs, and workflow automation features.

## Development Commands

```bash
# Install Mintlify CLI (prerequisite)
npm i -g mintlify

# Run local dev server (must be run from repo root where mint.json lives)
mintlify dev

# Re-install dependencies if dev server fails
mintlify install
```

There is no package.json, no build step, and no test suite. Deployment happens automatically via GitHub App when pushing to `main`.

## Architecture

### Configuration

- **`mint.json`** — Central configuration defining navigation, tabs, versioning (v1/v2), branding, API auth settings, and all page routes. This is the most important file to understand.
- **`api-reference/openapi.yaml`** — Full OpenAPI spec (~273KB) for the Cobalt REST API. API reference pages are auto-generated from this.

### Versioning

The docs support two versions configured in `mint.json`:
- **v1** — Legacy documentation (uses `concepts/`, `guides/`, `configure/` directories)
- **v2** — Current documentation (uses `build/`, `implementation/`, `ship/`, `maintain/` directories, plus `mcp/`)

### Content Sections (mapped to tabs in mint.json)

| Tab | Directories | Purpose |
|-----|------------|---------|
| Guides (v1) / Implementation & Guides (v2) | `concepts/`, `guides/`, `build/`, `implementation/`, `ship/`, `maintain/` | Platform docs and how-to guides |
| API Reference | `api-reference/` | REST API endpoints (driven by openapi.yaml) |
| SDKs | `sdks/` | Node.js server SDK, React SDK, JS SDK |
| Resources | `resources/integration-providers/` | Per-integration provider docs (140+ apps) |
| MCP (v2 only) | `mcp/` | Model Context Protocol integration docs |

### Key Conventions

- All documentation pages are `.mdx` files (Markdown with JSX components)
- Images are stored in `images/` with subdirectories per feature/integration
- Logos and branding assets are in `logo/`
- Reusable snippets go in `_snippets/`
- When adding a new page, it must also be added to the navigation in `mint.json`
- Integration provider docs follow a consistent pattern — check an existing one in `resources/integration-providers/` as a template
