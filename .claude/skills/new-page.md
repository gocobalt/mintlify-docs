# New Documentation Page

Creates a new documentation page and registers it in the navigation.

## Instructions

When the user asks to add a new doc page, do the following:

### 1. Gather info

Ask the user:
- **Title** of the page
- **Section** it belongs to (build, implementation, ship, maintain, mcp, guides, concepts, sdks, etc.)
- **Version**: v1 or v2 (default v2)
- **Where in navigation** it should appear (after which page, or in which group)

### 2. Create the MDX file

Place the file in the appropriate directory matching the section. Use this frontmatter:

```mdx
---
title: "{Page Title}"
description: "{Brief description of the page content}"
---
```

Follow the content patterns of existing pages in the same section. Use Mintlify components as appropriate:
- `<Info>`, `<Tip>`, `<Warning>`, `<Note>` for callouts
- `<Steps>` and `<Step>` for numbered procedures
- `<Tabs>` and `<Tab>` for tabbed content
- `<CodeGroup>` for multi-language code examples
- `<AccordionGroup>` and `<Accordion>` for collapsible sections
- `<CardGroup>` and `<Card>` for card grids
- `<Frame>` for images

### 3. Register in mint.json

Add the page path (without `.mdx` extension) to the correct location in the `navigation` array in `mint.json`. Match the version and group structure of the target section.

Example — adding a page to the Build > Platform Setup group:
```json
{
  "group": "Platform Setup",
  "pages": [
    "build/basics/linked_account",
    "build/basics/developer_settings",
    "build/basics/your_new_page"  // <-- added here
  ]
}
```

### 4. Add images if needed

Place any images in `images/` under an appropriate subdirectory. Reference them with:
```html
<img height="200" src="/images/SubDir/filename.png" alt="Description"/>
```

### 5. Verify

- File path in mint.json matches the actual file location (without `.mdx`).
- The `version` field on the navigation group matches the intended version (v1/v2).
