---
name: documentation-standards
description: This skill should be used when the user asks to "write documentation", "create docs", "document code", "improve documentation", "documentation best practices", "diataxis", "technical writing", "API documentation", "user guide", mentions documentation quality, documentation structure, or needs guidance on software documentation standards and frameworks.
version: 0.1.0
---

# Documentation Standards

Comprehensive guidance for creating bulletproof software documentation using industry-proven frameworks and quality standards.

## Overview

Effective documentation requires structure, consistency, and audience awareness. This skill provides frameworks and quality criteria for creating documentation that serves developers, users, and stakeholders across all software project domains.

## Supported Frameworks

### Diátaxis Framework (Recommended)

The Diátaxis framework organizes documentation into four distinct types based on user needs:

| Type | Orientation | Purpose | User State |
|------|-------------|---------|------------|
| **Tutorials** | Learning | Teach through doing | "I want to learn" |
| **How-to Guides** | Tasks | Solve specific problems | "I want to accomplish X" |
| **Explanations** | Understanding | Provide context and background | "I want to understand why" |
| **Reference** | Information | Describe the machinery | "I need technical details" |

**When to use Diátaxis:**
- Products with diverse user bases (beginners to experts)
- Growing documentation that needs scalable structure
- Teams wanting clear content ownership
- Projects requiring both learning paths and quick lookups

For detailed Diátaxis implementation, consult `references/diataxis.md`.

### Traditional Structure

A straightforward hierarchical approach suitable for smaller projects:

| Section | Purpose |
|---------|---------|
| **Overview** | High-level project description and goals |
| **Getting Started** | Quick setup and first steps |
| **API Reference** | Technical specifications and endpoints |
| **Examples** | Code samples and use cases |
| **FAQ** | Common questions and troubleshooting |

**When to use Traditional:**
- Developer tools and API-first projects
- Smaller codebases with focused scope
- Teams preferring linear documentation flow
- Projects with primarily technical audiences

For detailed Traditional structure guidance, consult `references/traditional.md`.

### Custom Standards

Organizations with existing documentation standards can integrate their own frameworks:

1. Provide source materials via local folder path or URL
2. Agent analyzes and creates style/rules file
3. Generated standards stored in `.claude/doc-master.local.md`
4. All documentation agents follow custom rules

For custom standards setup, consult `references/custom-standards.md`.

## Quality Criteria

Apply these criteria to evaluate and improve documentation quality:

### Completeness

- [ ] All public APIs documented
- [ ] Setup and installation covered
- [ ] Common use cases addressed
- [ ] Error handling explained
- [ ] Edge cases documented

### Accuracy

- [ ] Code examples tested and working
- [ ] Version information current
- [ ] Links valid and pointing to correct resources
- [ ] Technical details verified against implementation

### Clarity

- [ ] Appropriate reading level for audience
- [ ] Jargon explained or avoided
- [ ] Consistent terminology throughout
- [ ] Clear, actionable headings

### Organization

- [ ] Logical information hierarchy
- [ ] Related topics grouped together
- [ ] Navigation intuitive
- [ ] Cross-references where helpful

### Maintainability

- [ ] Single source of truth (no duplication)
- [ ] Version-controlled with code
- [ ] Review process defined
- [ ] Update triggers documented

For complete quality checklists, consult `references/quality-criteria.md`.

## Domain-Specific Guidelines

Different software domains require specialized documentation approaches:

### Backend Documentation
Focus on: Service architecture, API contracts, data flows, deployment procedures, monitoring and logging, error handling patterns.

### Frontend Documentation
Focus on: Component libraries, state management, styling systems, accessibility guidelines, browser compatibility, performance considerations.

### API Documentation
Focus on: Endpoint specifications, request/response formats, authentication flows, rate limits, versioning strategy, SDK examples.

### Database Documentation
Focus on: Schema design, entity relationships, migration procedures, query patterns, indexing strategy, backup/recovery.

### Architecture Documentation
Focus on: System diagrams, design decisions (ADRs), component interactions, scalability considerations, security boundaries.

### Test Documentation
Focus on: Test strategy, coverage requirements, test data management, environment setup, CI/CD integration.

### User Guide Documentation
Focus on: Task-oriented workflows, screenshots and visuals, progressive disclosure, troubleshooting paths, glossary.

### Compliance Documentation
Focus on: Regulatory requirements, audit trails, security controls, data handling policies, certification maintenance.

### Mobile Documentation
Focus on: Platform-specific guidelines, offline behavior, push notifications, app store requirements, device compatibility.

For detailed domain-specific templates, consult `references/domain-templates.md`.

## Documentation Workflow

### Planning Phase

1. Identify target audiences and their needs
2. Audit existing documentation (if any)
3. Choose appropriate framework (Diátaxis, Traditional, Custom)
4. Create documentation inventory and gap analysis
5. Prioritize based on user impact

### Writing Phase

1. Start with the most critical user journeys
2. Write one complete section before moving on
3. Include code examples that work
4. Use consistent formatting and style
5. Add cross-references where helpful

### Review Phase

1. Technical accuracy review by developers
2. Clarity review by target audience member
3. Completeness check against inventory
4. Link and example verification
5. Accessibility check

### Maintenance Phase

1. Update docs with code changes
2. Periodically audit for accuracy
3. Track user feedback and pain points
4. Remove outdated content
5. Improve based on analytics

## Configuration

Documentation preferences are stored in `.claude/doc-master.local.md`:

```yaml
---
standard: diataxis
proactive_agents: true
custom_source: null
---

# Project-Specific Documentation Notes

Add any project-specific documentation conventions here.
```

### Configuration Fields

| Field | Values | Description |
|-------|--------|-------------|
| `standard` | `diataxis`, `traditional`, `custom` | Active documentation framework |
| `proactive_agents` | `true`, `false` | Whether agents trigger automatically |
| `custom_source` | path or URL | Source for custom standards (when standard=custom) |

## Best Practices

### Writing Style

- Use active voice ("Configure the server" not "The server should be configured")
- Lead with the action ("To deploy, run..." not "If you want to deploy, you should...")
- Be concise but complete
- Use consistent terminology
- Include context for code snippets

### Structure

- Use descriptive headings (not "Introduction" but "What This Library Does")
- Keep paragraphs short (3-5 sentences)
- Use lists for steps and options
- Include a table of contents for long documents
- Provide quick navigation paths

### Code Examples

- Show complete, runnable examples
- Include expected output
- Explain non-obvious parts
- Use realistic variable names
- Test all examples before publishing

### Visual Elements

- Use diagrams for architecture and flows
- Include screenshots for UI documentation
- Add tables for comparing options
- Use callouts for warnings and tips
- Ensure accessibility (alt text, color contrast)

## Additional Resources

### Reference Files

For detailed framework implementations:
- **`references/diataxis.md`** - Complete Diátaxis framework guide
- **`references/traditional.md`** - Traditional structure templates
- **`references/custom-standards.md`** - Custom standards setup
- **`references/quality-criteria.md`** - Comprehensive quality checklists
- **`references/domain-templates.md`** - Domain-specific documentation templates

### Example Files

Working documentation examples:
- **`examples/diataxis-structure.md`** - Example Diátaxis documentation outline
- **`examples/api-reference.md`** - Example API documentation
