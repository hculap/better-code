# readme-writer Acceptance Tests Reference

A comprehensive reference for the 10 acceptance tests used by the readme-writer plugin to evaluate README quality.

## Quick Reference Checklist

| # | Test | Priority | Pass Criteria |
|---|------|----------|---------------|
| 1 | What is it? | P0 | Reader understands purpose in 10 seconds |
| 2 | Is it maintained? | P0 | Project status clear in 10 seconds |
| 3 | Quickstart | P1 | Works in ≤5 minutes |
| 4 | Runnable example | P1 | Copy/pasteable code exists |
| 5 | Expected output | P1 | Success is clearly shown |
| 6 | Navigation | P2 | Find sections in ≤10 seconds |
| 7 | License | P2 | Explicit and linked |
| 8 | Contribution | P2 | Route is clear |
| 9 | Accessibility | P3 | Headings hierarchical |
| 10 | Scope | P3 | Links to detailed docs |

## Priority Levels

| Priority | Severity | Impact | When to Fix |
|----------|----------|--------|-------------|
| **P0** | Critical | Blocks adoption entirely | Immediately |
| **P1** | High | Significantly degrades experience | Before release |
| **P2** | Medium | Causes friction but users can proceed | This sprint |
| **P3** | Low | Minor inconvenience | When time permits |

---

## Test 1: What is it?

**Priority:** P0 (Critical)

### Pass Criteria

A reader can understand what the project does within 10 seconds of viewing the README.

**Checklist:**
- [ ] First sentence explains what the project is
- [ ] Problem being solved is stated
- [ ] Target audience is clear
- [ ] No jargon without explanation

### Common Failures

| Failure | Example | Why It Fails |
|---------|---------|--------------|
| Badges-first | README opens with 5 lines of badges | Delays key information |
| Jargon lead | "A WebSocket-based RPC framework" | Only experts understand |
| Feature list first | Jumps to features without context | Missing the "what" |
| Vague description | "Makes development easier" | Not specific enough |

### Examples

**Failing:**
```markdown
# MyLib

[![Build](badge)] [![Coverage](badge)] [![npm](badge)]

## Features
- Fast
- Lightweight
- Easy to use
```

**Passing:**
```markdown
# MyLib

Parse and validate email addresses in JavaScript. Catches 99.9% of invalid
emails including edge cases like IP addresses and quoted strings.

[![Build](badge)] [![npm](badge)]
```

### Fix Strategy

Start with: "[Project name] does [specific action] for [target audience]. It solves [specific problem]."

---

## Test 2: Is it maintained?

**Priority:** P0 (Critical)

### Pass Criteria

The project's maintenance status is clear within 10 seconds.

**Checklist:**
- [ ] Status is explicitly stated (active, maintenance mode, deprecated)
- [ ] Last update is visible (badge or text)
- [ ] CI status is shown if applicable
- [ ] Version number is displayed

### Common Failures

| Failure | Example | Why It Fails |
|---------|---------|--------------|
| No status | Missing any indication of status | Reader assumes abandoned |
| Stale badges | "Build passing" from 2 years ago | Misleading |
| Hidden info | Status buried at bottom | Not visible in 10 seconds |

### Examples

**Failing:**
```markdown
# MyLib

A parsing library.

## Installation
...
```

**Passing:**
```markdown
# MyLib

![npm](https://img.shields.io/npm/v/mylib)
![Build](https://github.com/org/mylib/workflows/CI/badge.svg)
![Last commit](https://img.shields.io/github/last-commit/org/mylib)

**Status: Active** | [Changelog](CHANGELOG.md)

A parsing library.
```

### Fix Strategy

Add a status line near the top: "**Status:** Active | Beta | Maintenance Mode | Deprecated"

---

## Test 3: Quickstart Works

**Priority:** P1 (High)

### Pass Criteria

A new user can achieve their first success within 5 minutes.

**Checklist:**
- [ ] Total steps number 5 or fewer
- [ ] Each step has clear outcome
- [ ] No hidden prerequisites
- [ ] First success is visible (output shown)

### Common Failures

| Failure | Example | Why It Fails |
|---------|---------|--------------|
| Too many steps | 10+ step installation | Overwhelming, risky |
| Hidden deps | Assumes Docker installed | Fails mysteriously |
| No success indicator | Steps complete, nothing visible | User uncertain |
| Buried quickstart | After features/architecture sections | Not found quickly |

### Examples

**Failing:**
```markdown
## Installation

1. Clone the repository
2. Install dependencies
3. Configure environment
4. Set up database
5. Run migrations
6. Seed data
7. Build assets
8. Start server
9. Verify installation
```

**Passing:**
```markdown
## Quick Start

```bash
npm install mylib
```

```javascript
const mylib = require('mylib');
console.log(mylib.parse('test@example.com'));
// Output: { valid: true, local: 'test', domain: 'example.com' }
```

That's it! For advanced configuration, see [docs](docs/).
```

### Fix Strategy

Reduce to: Install → One code example → Visible output. Move everything else to "Advanced Setup."

---

## Test 4: Runnable Example

**Priority:** P1 (High)

### Pass Criteria

At least one code example can be copied and executed without modification.

**Checklist:**
- [ ] Includes all imports/requires
- [ ] No placeholder values requiring replacement
- [ ] Syntactically correct
- [ ] Uses portable paths/values

### Common Failures

| Failure | Example | Why It Fails |
|---------|---------|--------------|
| Missing imports | Uses variable without import | Won't run |
| Placeholders | `YOUR_API_KEY` | Requires user knowledge |
| Syntax errors | Unclosed brackets | Immediate failure |
| Ellipsis | `config({ ... })` | Incomplete instruction |

### Examples

**Failing:**
```javascript
// Parse an email
const result = parse(email);
console.log(result);
```

**Passing:**
```javascript
const { parse } = require('mylib');

const result = parse('test@example.com');
console.log(result);
// Output: { valid: true, local: 'test', domain: 'example.com' }
```

### Fix Strategy

Test every code block by actually copying and running it.

---

## Test 5: Expected Output

**Priority:** P1 (High)

### Pass Criteria

Examples show what success looks like.

**Checklist:**
- [ ] At least one example shows expected output
- [ ] Output format is clear (console, file, UI)
- [ ] Success vs failure distinction shown
- [ ] Output is realistic, not placeholder

### Common Failures

| Failure | Example | Why It Fails |
|---------|---------|--------------|
| No output shown | Code ends at function call | User unsure if working |
| Placeholder output | `// returns result` | Not verifiable |
| Only success case | Missing error examples | Incomplete picture |

### Examples

**Failing:**
```javascript
const result = validate(email);
// Use result
```

**Passing:**
```javascript
const result = validate('test@example.com');
console.log(result);
// Output:
// {
//   valid: true,
//   normalized: 'test@example.com',
//   warnings: []
// }

const invalid = validate('not-an-email');
console.log(invalid);
// Output:
// {
//   valid: false,
//   error: 'Missing @ symbol'
// }
```

### Fix Strategy

Add `// Output:` comments after every code example.

---

## Test 6: Navigation

**Priority:** P2 (Medium)

### Pass Criteria

Users can find any section within 10 seconds.

**Checklist:**
- [ ] Table of contents for READMEs > 100 lines
- [ ] Headings are descriptive
- [ ] Logical section ordering
- [ ] No deeply nested headings

### Common Failures

| Failure | Example | Why It Fails |
|---------|---------|--------------|
| No TOC | Long README without navigation | Users scroll aimlessly |
| Vague headings | "Details", "More Info" | Not searchable |
| Random order | API before Installation | Unintuitive |
| Flat structure | 20 h2s with no grouping | Overwhelming |

### Examples

**Failing:**
```markdown
# Project

## Stuff
## Things
## More Stuff
## Configuration
## Even More Things
```

**Passing:**
```markdown
# Project

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [Usage](#usage)
  - [Basic Usage](#basic-usage)
  - [Advanced Usage](#advanced-usage)
- [API Reference](#api-reference)
- [Contributing](#contributing)
```

### Fix Strategy

Add table of contents with [markdown-toc](https://github.com/jonschlinkert/markdown-toc) or manually.

---

## Test 7: License

**Priority:** P2 (Medium)

### Pass Criteria

License is explicitly stated and easily found.

**Checklist:**
- [ ] License name stated (MIT, Apache 2.0, etc.)
- [ ] Link to full license text
- [ ] Copyright holder identified
- [ ] Visible in README (not just LICENSE file)

### Common Failures

| Failure | Example | Why It Fails |
|---------|---------|--------------|
| Missing entirely | No license mentioned | Legal uncertainty |
| Just a file | LICENSE exists but not mentioned | Not visible |
| Ambiguous | "Open source" without specifics | Unclear terms |

### Examples

**Failing:**
```markdown
# Project

...

Made with love.
```

**Passing:**
```markdown
# Project

...

## License

MIT License - see [LICENSE](LICENSE) for details.

Copyright (c) 2024 Author Name
```

### Fix Strategy

Add a License section with license name and link to LICENSE file.

---

## Test 8: Contribution

**Priority:** P2 (Medium)

### Pass Criteria

Path to contributing is clear.

**Checklist:**
- [ ] Contribution welcome or not stated
- [ ] Link to contributing guide
- [ ] First contribution steps clear
- [ ] Code of conduct linked (if applicable)

### Common Failures

| Failure | Example | Why It Fails |
|---------|---------|--------------|
| No mention | No contributing section | Contributors uncertain |
| Vague | "Contributions welcome" only | No next step |
| Intimidating | Complex requirements upfront | Scares off contributors |

### Examples

**Failing:**
```markdown
# Project

...

## Development

Run `npm test` to test.
```

**Passing:**
```markdown
# Project

...

## Contributing

Contributions welcome! Please read our [Contributing Guide](CONTRIBUTING.md) first.

Quick start for contributors:
1. Fork the repository
2. Create a feature branch
3. Run `npm test` before submitting
4. Open a pull request

See [open issues](https://github.com/org/repo/issues) for ways to help.
```

### Fix Strategy

Add Contributing section with link to CONTRIBUTING.md or inline first steps.

---

## Test 9: Accessibility

**Priority:** P3 (Low)

### Pass Criteria

README follows accessibility best practices.

**Checklist:**
- [ ] Headings follow hierarchy (h1 > h2 > h3)
- [ ] Images have alt text
- [ ] Links are descriptive (not "click here")
- [ ] Tables have headers
- [ ] Code blocks specify language

### Common Failures

| Failure | Example | Why It Fails |
|---------|---------|--------------|
| Skipped levels | h1 followed by h4 | Screen reader confusion |
| Missing alt | `![](image.png)` | Image inaccessible |
| Vague links | "Click [here](url)" | Meaningless out of context |

### Examples

**Failing:**
```markdown
# Project

#### Installation   <!-- Skipped h2, h3 -->

![](screenshot.png)   <!-- No alt text -->

For more, click [here](docs/).   <!-- Vague link -->
```

**Passing:**
```markdown
# Project

## Getting Started

### Installation

![Screenshot of the dashboard showing usage statistics](screenshot.png)

For detailed documentation, see the [API Reference](docs/api.md).
```

### Fix Strategy

Audit headings for proper hierarchy, add alt text to all images.

---

## Test 10: Scope

**Priority:** P3 (Low)

### Pass Criteria

README links to detailed documentation for advanced topics.

**Checklist:**
- [ ] Advanced topics link elsewhere
- [ ] README stays focused on getting started
- [ ] Documentation structure is clear
- [ ] Links are not broken

### Common Failures

| Failure | Example | Why It Fails |
|---------|---------|--------------|
| Kitchen sink | 5000 line README | Overwhelming |
| Dead ends | No links to more info | Users stuck |
| Broken links | Links to moved/deleted docs | Frustrating |

### Examples

**Failing:**
```markdown
# Project

## Installation
...

## Every Single Configuration Option Ever
[3000 lines of configuration details]
```

**Passing:**
```markdown
# Project

## Installation
...

## Configuration

Basic configuration:
```javascript
mylib.configure({ timeout: 5000 });
```

For advanced configuration options, see [Configuration Guide](docs/configuration.md).

## Documentation

- [API Reference](docs/api.md)
- [Examples](docs/examples/)
- [Troubleshooting](docs/troubleshooting.md)
```

### Fix Strategy

Move detailed content to docs/ folder, keep README as entry point with links.

---

## Scoring Guide

### Calculating Score

| Tests Passing | Score | Rating |
|---------------|-------|--------|
| All 10 | 10/10 | Excellent |
| All P0 + P1 (7) | 7/10 | Good (release ready) |
| All P0 (2) | 2/10 | Minimum viable |
| Missing P0 | 0-1/10 | Not ready |

### Audit Workflow

1. **Run P0 tests first** (Tests 1-2)
   - If either fails, stop and fix before proceeding

2. **Run P1 tests** (Tests 3-5)
   - Must pass before public release

3. **Run P2 tests** (Tests 6-8)
   - Should pass for production quality

4. **Run P3 tests** (Tests 9-10)
   - Fix when time permits

### Auto-Fix Capabilities

Some issues can be auto-fixed by the plugin:

| Issue | Auto-fixable | Notes |
|-------|--------------|-------|
| Missing TOC | Yes | Generated from headings |
| Heading hierarchy | Yes | Adjusted to proper levels |
| Missing license section | Partial | Added if LICENSE file exists |
| Code block language | Yes | Detected from content |
| Broken internal links | No | Requires manual review |
| Placeholder values | No | Requires domain knowledge |

---

## See Also

- [How to Audit and Fix README Issues](../how-to/readme-audit.md)
- [How to Generate a README](../how-to/readme-generate.md)
- [The PRD-README v1 Standard](../explanations/prd-readme-standard.md)
