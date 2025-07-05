# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.


## Development Commands

### Documentation Development
- `mintlify dev` - Start the development server to preview documentation changes locally
- `mintlify install` - Re-install dependencies if the dev server isn't running

### Prerequisites
- Install the Mintlify CLI: `npm i -g mintlify`
- Run commands from the root directory where `mint.json` is located

## Project Architecture

### Documentation Structure
This is a Mintlify-powered documentation site for **Cobalt** - a developer-first integration platform that helps SaaS companies build native integrations.

### Key Components
- **mint.json** - Main configuration file defining site structure, navigation, theming, and versioning
- **Multiple Documentation Versions** - The site supports v1, v2, and v3 versions with different content structures
- **MDX Files** - All documentation content is written in MDX format combining Markdown with React components

### Content Organization
- **api-reference/** - Complete API documentation with endpoints organized by functionality
- **concepts/** - Core platform concepts including workflows, applications, and authentication
- **guides/** - Step-by-step implementation guides and tutorials  
- **implementation/** - Technical implementation documentation with examples
- **resources/** - Integration provider setup guides (200+ integrations)
- **sdks/** - Client-side and server-side SDK documentation
- **images/** - Extensive image assets for documentation
- All the v3 document should be written in v3 Docs folder

### Navigation Architecture
The site uses a complex multi-version navigation system:
- **v3** - Current version with modern structure (Welcome, Developer Guide, MCPs, API Reference, Integrations, Releases)
- **v2** - Previous version focusing on Build, Ship, Maintain workflow
- **v1** - Legacy version with basic concepts and implementation guides

### Key Features
- **Multi-tenant support** - MCPs (Multi-Customer Platforms) for enterprise solutions
- **200+ Pre-built integrations** - Comprehensive integration catalog
- **Multiple auth flows** - OAuth, key-based, and custom authentication
- **Workflow engine** - Visual workflow builder with multiple node types
- **Real-time sync** - Event-driven data synchronization

### Documentation Standards
- Uses Mintlify components like `<Card>`, `<CardGroup>`, `<Accordion>`, `<Tabs>`, `<Callout>`
- Extensive use of images with consistent naming patterns
- Suggest placeholder images wherever it is required
- Create diagrams whenever possible to explain functionality 
- Cross-references between versions and sections
- Integration-specific setup guides with screenshots

### File Naming Conventions
- All documentation files use `.mdx` extension
- Images organized by integration/feature in `/images/` directory
- API endpoints follow REST convention naming
- Integration guides named by platform (e.g., `salesforce.mdx`, `hubspot.mdx`)

## Common Tasks

### Adding New Integration Documentation
1. Create new `.mdx` file in `resources/integration-providers/`
2. Add corresponding images in `images/[integration-name]/`
3. Update navigation in `mint.json` if needed
4. Follow existing integration guide template structure

### Updating API Documentation
1. Modify files in `api-reference/` directory
2. Update `openapi.yaml` if endpoints change
3. Ensure version consistency across v1, v2, v3 documentation

### Working with Multi-Version Content
- Check `mint.json` for version-specific navigation
- Ensure changes are applied to correct version paths
- Cross-reference related content across versions


# Cobalt Documentation Structure - Final Refined Version

## 🎯 **Tab Structure** (6 Clean Tabs)

### **Tab 1: Welcome** (Homepage)
*Goal: Clear entry point with navigation to all sections*

#### **Hero Section**
```mdx
# Build Native Integrations in Minutes
The developer-first integration platform that eliminates months of custom development.
Add 200+ integrations to your SaaS with a single API call.


---

### **Tab 2: Developer Guide**
*Goal: Everything developers need from zero to production*

#### **Getting Started** (Integrated within Developer Guide)
- **Quick Start** - 5-minute first integration
- **Core Concepts** - Linked Accounts, Workflows, Connect UI
- **Environment Setup** - Development environment
- **Your First Integration** - Complete walkthrough

#### **Platform Fundamentals**
- **Architecture Overview** - How Cobalt works
- **Authentication & Security** - OAuth, API keys, best practices
- **Linked Accounts Deep Dive** - User management
- **Workflows Engine** - Business logic and automation
- **Events & Webhooks** - Real-time data flow

#### **Implementation Guide**
- **Backend Integration** - Server-side setup
- **Frontend Integration** - Cobalt Connect UI
- **Data Transformation** - Mapping and formatting
- **Error Handling** - Robust error management
- **Testing Strategies** - Development to production

#### **Advanced Features**
- **Custom Workflows** - JavaScript functions, conditions
- **Bulk Operations** - Large dataset handling
- **Performance Optimization** - Scaling best practices
- **Custom Authentication** - Advanced auth flows

#### **Production Deployment**
- **Security Checklist** - Enterprise requirements
- **Go-Live Guide** - Production deployment
- **Monitoring & Analytics** - Observability setup
- **Maintenance & Updates** - Ongoing operations

---

### **Tab 3: MCPs**
*Goal: Multi-Channel Platform enterprise solution*

#### **MCP Overview**
- **What is MCP?** - Multi-tenant architecture
- **Use Cases** - Agencies, platforms, enterprises
- **Architecture** - How MCP scales
- **Getting Started with MCP** - Setup guide

#### **Implementation**
- **Account Hierarchy** - Organizations and teams
- **White-label Solutions** - Custom branding
- **Multi-tenant Workflows** - Shared vs isolated
- **Security & Compliance** - Enterprise features

#### **Management**
- **Organization Management** - Admin controls
- **User Management** - Roles and permissions
- **Billing & Usage** - Multi-tenant billing
- **Analytics & Reporting** - Cross-tenant insights

#### **Enterprise Features**
- **Single Sign-On** - SSO integration
- **Advanced Security** - Additional protection
- **Custom Domains** - Branded experiences
- **Priority Support** - Enterprise support

---

### **Tab 4: API Reference**
*Goal: Complete technical API documentation*

#### **Authentication**
- **API Keys** - Management and security
- **OAuth Flows** - Complete implementation
- **Token Management** - Refresh and expiry
- **Rate Limiting** - Limits and handling

#### **Core APIs**
- **Linked Accounts API** - User management endpoints
- **Applications API** - Integration management
- **Workflows API** - Workflow operations
- **Events API** - Webhook management
- **Configuration API** - Settings and config

#### **Webhooks**
- **Event Types** - Complete event reference
- **Payload Schemas** - Event data structures
- **Signature Verification** - Security validation
- **Retry Logic** - Failure handling

#### **SDKs & Libraries**
- **JavaScript/TypeScript SDK** - Frontend integration
- **Node.js SDK** - Backend implementation
- **Python SDK** - Server-side integration
- **React Components** - UI components
- **Migration Guides** - Version upgrades

#### **Error Handling**
- **Error Codes** - Complete reference
- **Response Formats** - Standard structures
- **Debugging Tools** - Investigation guides
- **Best Practices** - Error handling patterns

---

### **Tab 5: Integration Catalog**
*Goal: Platform-specific setup and configuration guides*

#### **Popular Platforms**
- **CRM Integrations**
  - Salesforce - Complete setup guide
  - HubSpot - Configuration walkthrough  
  - Pipedrive - Field mapping guide
  - Zendesk Sell - Implementation guide

- **Marketing Platforms**
  - Mailchimp - Contact sync patterns
  - Klaviyo - Segmentation setup
  - Marketo - Campaign automation
  - Constant Contact - Email workflows

- **Support Systems**
  - Zendesk - Ticket management
  - Intercom - Customer data sync
  - Freshdesk - Automation workflows
  - Help Scout - Integration patterns

- **Finance & Accounting**
  - QuickBooks - Transaction sync
  - Xero - Invoice management
  - Stripe - Payment processing
  - Square - Commerce integration

#### **Integration Patterns**
- **Real-time Sync** - Live data synchronization
- **Bulk Data Operations** - Large transfers
- **Event-driven Workflows** - Trigger automation
- **Custom Field Mapping** - Dynamic fields
- **Error Recovery** - Failure handling

#### **Custom Integrations**
- **Building Custom Apps** - New platforms
- **Authentication Setup** - Custom OAuth
- **API Endpoint Mapping** - Configuration
- **Testing Custom Apps** - Validation
- **Publishing to Catalog** - Submission process

---

### **Tab 6: Release Notes**
*Goal: Keep developers informed of changes and updates*

#### **Latest Releases**
- **Current Version** - Latest features and fixes
- **Recent Updates** - Past 3 months
- **Breaking Changes** - Migration requirements
- **Deprecation Notices** - Timeline for removals

#### **Product Updates**
- **New Integrations** - Recently added platforms
- **Feature Releases** - New capabilities
- **Performance Improvements** - Speed and efficiency
- **Security Updates** - Security enhancements

#### **Developer Resources**
- **Migration Guides** - Version upgrade help
- **API Changelog** - API-specific changes
- **SDK Updates** - Library changes
- **Documentation Updates** - Doc improvements

#### **Roadmap**
- **Upcoming Features** - What's coming next
- **Platform Additions** - New integrations planned
- **Community Requests** - User-requested features
- **Feedback Loop** - How to influence roadmap

---

## 🎯 **Why This Structure Works**

### **Clean Homepage Entry**
- **Welcome tab** acts as a clear navigation hub
- **Hero cards** provide immediate direction
- **No confusion** about where to start
- **Progressive disclosure** from simple to complex

### **Logical Organization**
- **Developer Guide** contains everything from getting started to production
- **MCPs** is clearly separated as enterprise product
- **API Reference** is pure technical documentation
- **Integration Catalog** focuses on platform-specific guides
- **Release Notes** keeps everyone informed

### **Benefits of Including Getting Started in Developer Guide**
✅ **Reduces tab proliferation** - Keeps navigation clean
✅ **Natural progression** - Smooth flow from basics to advanced
✅ **Single learning path** - Everything developers need in one place
✅ **Easier maintenance** - One comprehensive guide vs multiple fragments

### **User Journey Alignment**
- **First-time visitors** → Welcome page → Getting Started section
- **Implementing developers** → Developer Guide (complete journey)
- **Enterprise customers** → MCPs
- **API users** → API Reference
- **Platform-specific needs** → Integration Catalog
- **Staying updated** → Release Notes

This structure gives you the best of both worlds: a clean, uncluttered navigation with comprehensive coverage. The Welcome page acts as an effective traffic director, while each subsequent tab has a clear, distinct purpose.

**Recommendation: This structure is perfect for Cobalt.** It's clean, logical, and follows proven documentation patterns while serving all your user types effectively.

-----

# Navigation - Outlines how does navigation works in Mintliify

> Structure and customize your documentation's navigation hierarchy

The [navigation](settings#param-navigation) property in [docs.json](settings) defines how users will browse through your documentation. Think of it as the blueprint for your documentation's menu structure.

With proper navigation configuration, you can organize your content into a logical hierarchy that makes it easy for users to find exactly what they're looking for.

<Info>
  Do not use `api` as a title for any navigation element. The `/api` path is reserved in production and will cause pages to return 404 errors if their URLs contain `/api`.
</Info>

## Pages

Pages are the most fundamental navigation component.

<img className="block dark:hidden pointer-events-none" src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/pages-light.png" />

<img className="hidden dark:block pointer-events-none" src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/pages-dark.png" />

Pages is an array where each entry must be a reference to the path of a [page file](pages).

```json
{
  "navigation": {
    "pages": [
      "overview",
      "quickstart",
      "advanced/components",
      "advanced/integrations"
    ]
  }
}
```

***

## Groups

Use groups to organize your navigation into sections. Groups can be nested within each other, labeled with tags, and styled with icons.

<img className="block dark:hidden pointer-events-none" src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/groups-light.png" />

<img className="hidden dark:block pointer-events-none" src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/groups-dark.png" />

```json
{
  "navigation": {
    "groups": [
      {
        "group": "Getting Started",
		"icon": "play",
        "pages": [
          "quickstart",
          {
            "group": "Editing",
			"icon": "pencil",
            "pages": [
				"installation",
				"editor",
				{
					"group": "Nested group",
					"icon": "code",
					"pages": [
						"navigation",
						"code"
					]
				}
			]
          }
        ]
      },
      {
        "group": "Writing Content",
 		"icon": "notebook-text",
        "tag": "NEW",
        "pages": ["writing-content/page", "writing-content/text"]
      }
    ]
  }
}
```

## Tabs

Tabs help distinguish between different topics or sections of your
documentation.

<img className="block dark:hidden pointer-events-none" src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/tabs-light.png" />

<img className="hidden dark:block pointer-events-none" src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/tabs-dark.png" />

```json
"navigation": {
  "tabs": [
    {
      "tab": "API References",
      "pages": [
        "api-reference/get",
        "api-reference/post",
        "api-reference/delete"
      ]
    },
    {
      "tab": "SDKs",
      "pages": [
        "sdk/fetch",
        "sdk/create",
        "sdk/delete",
      ]
    },
    {
      "tab": "Blog",
      "href": "https://external-link.com/blog"
    }
  ]
}
```

***

## Anchors

Anchors are another way to section your content. They show up on top of your side navigation.

<img className="block dark:hidden pointer-events-none" src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/anchors-light.png" />

<img className="hidden dark:block pointer-events-none" src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/anchors-dark.png" />

The configuration is very similar to tabs.

While not required, we highly recommend that you set an `icon` field as well.

```json
"navigation": {
  "anchors": [
    {
      "anchor": "Documentation",
      "icon": "book-open",
      "pages": [
        "quickstart",
        "development",
        "navigation"
      ]
    },
    {
      "anchor": "API References",
      "icon": "square-terminal",
      "pages": [
        "api-reference/get",
        "api-reference/post",
        "api-reference/delete"
      ]
    },
    {
      "anchor": "Blog",
      "href": "https://external-link.com/blog"
    }
  ]
}
```

***

Anchors that strictly contain external links can be achieved using the `global` keyword:

```json
"navigation": {
  "global":  {
    "anchors": [
      {
         "anchor": "Community",
         "icon": "house",
         "href": "https://slack.com"
      },
      {
         "anchor": "Blog",
         "icon": "pencil",
         "href": "https://mintlify.com/blog"
      }
    ]
  },
  "tabs": /*...*/
}
```

## Dropdowns

Dropdowns show up in the same place as anchors, but are consolidated into a single dropdown.

<img className="block dark:hidden pointer-events-none" src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/dropdowns-light.png" />

<img className="hidden dark:block pointer-events-none" src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/dropdowns-dark.png" />

While not required, we also recommend that you set an icon for each dropdown item.

```json
"navigation": {
  "dropdowns": [
    {
      "dropdown": "Documentation",
      "icon": "book-open",
      "pages": [
        "quickstart",
        "development",
        "navigation"
      ]
    }
    {
      "dropdown": "API References",
      "icon": "square-terminal",
      "pages": [
        "api-reference/get",
        "api-reference/post",
        "api-reference/delete"
      ]
    }
    {
      "dropdown": "Blog",
      "href": "https://external-link.com/blog"
    }
  ]
}
```

***

## Versions

Versions can be leveraged to partition your navigation into different versions.

<img className="block dark:hidden pointer-events-none" src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/versions-light.png" />

<img className="hidden dark:block pointer-events-none" src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/versions-dark.png" />

```json
{
  "navigation": {
    "versions": [
      {
        "version": "1.0.0",
        "groups": [
          {
            "group": "Getting Started",
            "pages": ["v1/overview", "v1/quickstart", "v1/development"]
          }
        ]
      },
      {
        "version": "2.0.0",
        "groups": [
          {
            "group": "Getting Started",
            "pages": ["v2/overview", "v2/quickstart", "v2/development"]
          }
        ]
      }
    ]
  }
}
```

***

## Languages

Languages can be leveraged to partition your navigation into different languages.

<Info>
  You can automate [translations](/translations) of your documentation into any supported language.
</Info>

<img className="block dark:hidden pointer-events-none" src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages-light.png" />

<img className="hidden dark:block pointer-events-none" src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages-dark.png" />

We currently support the following languages:

<CardGroup cols={2}>
  <Card title="Arabic (ar)" icon={<img src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages/ar.png" className="w-6 h-6 my-0" />} horizontal />

  <Card title="Chinese (cn)" icon={<img src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages/cn.png" className="w-6 h-6 my-0" />} horizontal />

  <Card title="Chinese (zh-Hant)" icon={<img src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages/cn.png" className="w-6 h-6 my-0" />} horizontal />

  <Card title="English (en)" icon={<img src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages/en.png" className="w-6 h-6 my-0" />} horizontal />

  <Card title="French (fr)" icon={<img src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages/fr.png" className="w-6 h-6 my-0" />} horizontal />

  <Card title="German (de)" icon={<img src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages/de.png" className="w-6 h-6 my-0" />} horizontal />

  <Card title="Indonesian (id)" icon={<img src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages/id.png" className="w-6 h-6 my-0" />} horizontal />

  <Card title="Italian (it)" icon={<img src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages/it.png" className="w-6 h-6 my-0" />} horizontal />

  <Card title="Japanese (jp)" icon={<img src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages/jp.png" className="w-6 h-6 my-0" />} horizontal />

  <Card title="Korean (ko)" icon={<img src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages/ko.png" className="w-6 h-6 my-0" />} horizontal />

  <Card title="Portuguese (pt)" icon={<img src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages/pt.png" className="w-6 h-6 my-0" />} horizontal />

  <Card title="Portuguese (pt-BR)" icon={<img src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages/pt-br.png" className="w-6 h-6 my-0" />} horizontal />

  <Card title="Russian (ru)" icon={<img src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages/ru.png" className="w-6 h-6 my-0" />} horizontal />

  <Card title="Spanish (es)" icon={<img src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages/es.png" className="w-6 h-6 my-0" />} horizontal />

  <Card title="Turkish (tr)" icon={<img src="https://mintlify.s3.us-west-1.amazonaws.com/mintlify/images/navigation/languages/tr.png" className="w-6 h-6 my-0" />} horizontal />
</CardGroup>

```json
{
  "navigation": {
    "languages": [
      {
        "language": "en",
        "groups": [
          {
            "group": "Getting Started",
            "pages": ["en/overview", "en/quickstart", "en/development"]
          }
        ]
      },
      {
        "language": "es",
        "groups": [
          {
            "group": "Getting Started",
            "pages": ["es/overview", "es/quickstart", "es/development"]
          }
        ]
      }
    ]
  }
}
```

***

## Nesting

It's important to note that you can use any combination of anchors, tabs, and dropdowns - either one can be nested within each other interchangeably.

This way, you can create a very complex navigation structure that is easy to manage.

<CodeGroup>
  ```json Anchors
  {
    "navigation": {
      "anchors": [
        {
          "anchor": "Anchor 1",
          "groups": [
            {
              "group": "Group 1",
              "pages": [
                "some-folder/file-1",
                "another-folder/file-2"
                "just-a-file"
              ]
            }
          ]
        }
        {
          "anchor": "Anchor 2",
          "groups": [
            {
              "group": "Group 2",
              "pages": [
                "some-other-folder/file-1",
                "various-different-folders/file-2",
                "another-file"
              ]
            }
          ]
        }
      ]
    }
  }
  ```

  ```json Tabs
  {
    "navigation": {
      "tabs": [
        {
          "tab": "Tab 1",
          "groups": [
            {
              "group": "Group 1",
              "pages": [
                "some-folder/file-1",
                "another-folder/file-2"
                "just-a-file"
              ]
            }
          ]
        }
        {
          "tab": "Tab 2",
          "groups": [
            {
              "group": "Group 2",
              "pages": [
                "some-other-folder/file-1",
                "various-different-folders/file-2",
                "another-file"
              ]
            }
          ]
        }
      ]
    }
  }
  ```

  ```json Tabs with external anchors
  {
    "navigation": {
      "tabs": [
        {
          "tab": "Tab 1",
          "global": {
            "anchors": [
              {
                "anchor": "Anchor 1",
                "href": "https://mintlify.com/docs"
              }
            ]
          },
          "groups": [
            {
              "group": "Group 1",
              "pages": [
                "some-folder/file-1",
                "another-folder/file-2"
                "just-a-file"
              ]
            }
          ]
        }
        {
          "tab": "Tab 2",
          "groups": [
            {
              "group": "Group 2",
              "pages": [
                "some-other-folder/file-1",
                "various-different-folders/file-2",
                "another-file"
              ]
            }
          ]
        }
      ]
    }
  }
  ```
</CodeGroup>
