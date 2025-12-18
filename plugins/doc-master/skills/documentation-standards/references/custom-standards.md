# Custom Documentation Standards Setup

Guide for integrating organization-specific documentation standards with Doc Master.

## Overview

When organizations have existing documentation guidelines, custom standards allow Doc Master to follow those conventions instead of Diátaxis or Traditional frameworks.

## Setup Process

### 1. Prepare Source Materials

Custom standards can come from:
- Local folder with markdown files
- URL to documentation standards page
- Combination of both

**Recommended source structure:**
```
custom-docs-standards/
├── style-guide.md       # Writing style and tone
├── structure.md         # Document organization rules
├── templates/           # Document templates
│   ├── api-doc.md
│   ├── readme.md
│   └── changelog.md
├── examples/            # Good/bad examples
│   ├── good-example.md
│   └── bad-example.md
└── checklist.md         # Quality checklist
```

### 2. Run Setup Command

```
/doc-master:setup
```

Choose "Custom" when prompted, then provide the source path or URL.

### 3. Agent Analysis

Doc Master analyzes your source materials and extracts:
- Writing style preferences
- Terminology requirements
- Structure patterns
- Formatting rules
- Quality criteria

### 4. Generated Configuration

The agent creates a comprehensive rules file stored in `.claude/doc-master.local.md`:

```yaml
---
standard: custom
proactive_agents: true
custom_source: /path/to/standards
---

# Documentation Standards

## Voice and Tone
- Use formal, technical language
- Avoid contractions
- Write in present tense

## Structure Requirements
- All docs must include version header
- Maximum heading depth: 4 levels
- Code examples required for all APIs

## Terminology
| Preferred | Avoid |
|-----------|-------|
| endpoint | API |
| execute | run |
| user | client |

## Templates
### API Documentation
[Template content...]

### README
[Template content...]

## Quality Checklist
- [ ] Follows naming conventions
- [ ] Includes version info
- [ ] Has working examples
```

## Source Material Guidelines

### Style Guide Content

Include in your style guide:
- Voice (formal/informal, first/second/third person)
- Tone (technical level, friendliness)
- Word list (preferred terms, terms to avoid)
- Grammar preferences (Oxford comma, etc.)
- Formatting conventions

**Example:**
```markdown
# Writing Style Guide

## Voice
- Use active voice
- Address the reader as "you"
- Use present tense for current behavior

## Terminology
Always use:
- "select" not "click"
- "enter" not "type"
- "application" not "app"

## Grammar
- Use Oxford comma
- Use sentence case for headings
- Spell out numbers under 10
```

### Structure Guidelines

Include in structure docs:
- Required sections
- Section order
- Heading conventions
- File naming rules
- Folder organization

**Example:**
```markdown
# Document Structure Standards

## Required Sections (in order)
1. Title (H1)
2. Overview
3. Prerequisites (if applicable)
4. Main content
5. Related links

## Headings
- H1: Document title only
- H2: Major sections
- H3: Subsections
- H4: Avoid if possible

## File Naming
- Use kebab-case
- Include version for versioned docs
- Pattern: {feature}-{type}.md
```

### Templates

Provide templates for:
- README files
- API documentation
- Changelogs
- Tutorials
- Reference pages

**Example API template:**
```markdown
# {API Name}

## Overview
{Brief description}

## Authentication
{Auth requirements}

## Endpoints

### {METHOD} {/path}

{Description}

#### Request
```json
{request example}
```

#### Response
```json
{response example}
```

#### Errors
| Code | Description |
|------|-------------|
| 400 | {error desc} |
```

## URL Source Support

When providing a URL:
1. Doc Master fetches the page content
2. Parses markdown or HTML
3. Extracts style patterns and rules
4. May need multiple URLs for complete coverage

**URL format in setup:**
- Single page: `https://docs.company.com/style-guide`
- Documentation hub: `https://docs.company.com/standards/`

**Limitations:**
- Must be publicly accessible (or provide auth)
- HTML is converted to markdown
- Complex layouts may lose structure
- Interactive elements ignored

## Updating Custom Standards

### Update Source Materials
1. Modify source files or update URL content
2. Run `/doc-master:setup` again
3. Choose to refresh custom standards
4. Agent re-analyzes and updates rules

### Manual Rule Adjustments
1. Edit `.claude/doc-master.local.md` directly
2. Add or modify rules in the markdown body
3. Changes take effect immediately

## Validation

After setup, validate that custom standards are correctly applied:

1. Run `/doc-master:audit` on existing docs
2. Check that audit uses custom criteria
3. Generate sample docs with `/doc-master:generate`
4. Verify output follows custom standards

## Common Issues

### Incomplete Extraction
**Problem:** Agent misses some rules from source.
**Solution:** Make rules more explicit in source, use structured format.

### Conflicting Rules
**Problem:** Source has contradictory guidance.
**Solution:** Review and resolve conflicts in source materials.

### URL Inaccessible
**Problem:** Can't fetch URL content.
**Solution:** Use local files, or ensure URL is accessible.

### Rules Too Vague
**Problem:** Generated rules not specific enough.
**Solution:** Provide more examples and specific patterns in source.

## Best Practices

1. **Keep source current** - Update standards source regularly
2. **Be explicit** - Vague guidelines lead to inconsistent output
3. **Provide examples** - Good/bad examples clarify expectations
4. **Test early** - Validate standards before wide adoption
5. **Iterate** - Refine rules based on generated output quality
