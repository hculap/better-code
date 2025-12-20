# How to Set Up doc-master for Your Project

This guide walks you through configuring doc-master for your project, including selecting a documentation standard that fits your team's needs.

## Prerequisites

Before starting, ensure you have:
- Claude Code CLI installed
- The doc-master plugin installed (`/plugin install doc-master`)
- A project directory with source code to document

## Step 1: Run the Setup Command

Start the configuration wizard by running:

```
/doc-master:setup
```

The setup command will prompt you to select a documentation standard and configure project-specific settings.

## Step 2: Choose a Documentation Standard

doc-master supports three documentation approaches:

### Diataxis (Recommended for Most Projects)

Choose Diataxis when your project needs comprehensive documentation covering multiple user needs. This framework organizes documentation into four distinct types:

- **Tutorials**: Learning-oriented guides for beginners
- **How-to Guides**: Task-oriented instructions for specific goals
- **Reference**: Technical descriptions of APIs and components
- **Explanation**: Understanding-oriented background and concepts

Best for: Libraries, frameworks, developer tools, and projects with diverse audiences.

### Traditional

Choose Traditional for simpler projects or when your team prefers a conventional structure. This approach uses familiar sections:

- Overview and introduction
- Getting Started / Quick Start
- API Reference
- Examples
- FAQ

Best for: Small utilities, internal tools, and teams transitioning from existing documentation.

### Custom

Choose Custom when you have established documentation standards or specific organizational requirements. You provide your own templates and guidelines.

## Step 3: Provide Custom Standards (If Applicable)

When selecting Custom, you must provide your standards in one of two ways:

**Local folder**: Point to a directory containing your documentation templates and style guides:
```
./docs/standards/
```

**URL**: Reference an external standards repository or documentation site:
```
https://example.com/docs/writing-standards
```

Your custom standards should define document structure, formatting rules, and any required sections.

## Step 4: Verify Your Configuration

After setup completes, verify the configuration file was created at:

```
.claude/doc-master.local.md
```

Open this file to confirm your settings. A typical Diataxis configuration looks like:

```markdown
---
standard: diataxis
proactive_agents: true
custom_source: null
---

## Documentation Notes

Following Diataxis framework for all documentation.
```

## Configuration Options

| Option | Values | Default | Description |
|--------|--------|---------|-------------|
| `standard` | diataxis, traditional, custom | diataxis | Documentation framework to use |
| `proactive_agents` | true, false | true | Whether agents activate automatically |
| `custom_source` | path or URL | null | Location of custom standards |

## Example Setup Flow

Here is a complete setup session for a TypeScript library:

```
> /doc-master:setup

Welcome to doc-master setup.

Select a documentation standard:
  1. Diataxis (tutorials, how-tos, reference, explanation)
  2. Traditional (README-focused with standard sections)
  3. Custom (provide your own standards)

> 1

Proactive agents enabled? [Y/n]:
> Y

Configuration saved to .claude/doc-master.local.md

Run /doc-master:generate to create documentation.
```

## Changing Standards Later

To switch documentation standards after initial setup:

1. Run `/doc-master:setup` again
2. Select your new standard
3. The configuration file will be updated

Existing documentation remains unchanged. New documentation will follow the updated standard.

## Next Steps

With setup complete, you can:
- Run `/doc-master:generate "feature name"` to create documentation
- Run `/doc-master:audit` to check existing documentation quality
- Run `/doc-master:plan` to create a documentation plan for your project

## See Also

- [How to Generate Documentation](./doc-master-generate.md)
- [Diataxis vs Traditional Documentation](../explanations/diataxis-vs-traditional.md)
- [doc-master Agents Reference](../reference/doc-master-agents.md)
