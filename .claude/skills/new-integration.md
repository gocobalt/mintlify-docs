# New Integration Provider Page

Creates documentation for a new integration provider.

## Instructions

When the user asks to add a new integration (they will provide the provider name and auth type), do the following:

### 1. Determine scope

Ask the user:
- **Provider name** (e.g. "Aircall", "Salesforce")
- **Auth type**: "API Key" or "OAuth 2.0"
- **Simple or full?** — Simple = single setup page. Full = overview + setup + features (3 pages). Default to simple unless told otherwise.

### 2. Create the MDX file(s)

Files go in `resources/integration-providers/`.

**For a simple (single-page) API Key integration**, create `{provider_slug}.mdx`:

```mdx
---
title: Connect
description: Connect with the Linked Account's {Provider} account.
---

<Note>
{Provider} is an **API Key** based integration and does not require the setup of an app.
</Note>

### Required Credentials of a Linked Account

To setup **{Provider}** as an integration, you will need the following credentials from your Linked Account:

- **API Key**

### Getting Credentials of {Provider}

To find the API Key, the linked account needs to:

1. Log in to their [{Provider} account]({provider_url}).
<!-- Add numbered steps with screenshots as available -->

#### Actions and triggers

<Tabs>
  <Tab title="Actions">
    <AccordionGroup>
      <Accordion title="Actions">
        <!-- List available actions -->
      </Accordion>
    </AccordionGroup>
  </Tab>
  <Tab title="Triggers">
    <!-- List available triggers or note "No triggers available" -->
  </Tab>
</Tabs>
```

**For a simple OAuth integration**, the structure is the same but replace the Note with the OAuth app creation steps:

```mdx
---
title: Setup
description: Connect to your users' {Provider} account.
---

### Pre-requisites

1. {Provider} Developer Account.
2. Required Settings configured in the [Overview page](/resources/integration-providers/{provider_slug}_overview).

### Creating an app in {Provider}

1. Log in to the [{Provider} Developer Portal]({developer_portal_url}).
<!-- Numbered steps for app creation -->

#### Configuring credentials in Cobalt

1. Navigate to the [{Provider} App](https://app.gocobalt.io/apps) in Cobalt.
<!-- Steps for entering Client ID, Client Secret -->

#### Configuring Scopes

<!-- Scope configuration steps -->
```

**For a full (3-page) integration**, create:
- `{provider_slug}_overview.mdx` — Provider metadata (slug, auth method, website, dev portal, API ref, supported resources) using CardGroup
- `{provider_slug}.mdx` — Setup/connection guide (as above)
- `{provider_slug}_features.mdx` — Tutorial for building a sample workflow

### 3. Create image directory

Create `images/{ProviderName}/` (PascalCase) for any screenshots.

### 4. Register in mint.json

Add the new integration to the `navigation` array in `mint.json` under the Resources tab's "Integration Providers" section. Insert alphabetically:

**Simple:**
```json
{
  "group": "{Provider Name}",
  "pages": ["resources/integration-providers/{provider_slug}"]
}
```

**Full (3-page):**
```json
{
  "group": "{Provider Name}",
  "pages": [
    "resources/integration-providers/{provider_slug}_overview",
    "resources/integration-providers/{provider_slug}",
    "resources/integration-providers/{provider_slug}_features"
  ]
}
```

### 5. Verify

- Confirm the file paths in mint.json match the created files (without `.mdx` extension).
- Confirm alphabetical ordering in the navigation.
