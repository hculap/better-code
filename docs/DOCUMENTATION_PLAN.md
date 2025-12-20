# better-code Documentation Plan

**Generated:** December 2024
**Framework:** Diátaxis
**Target Audience:** Plugin users
**Scope:** Entire project (4 plugins)

---

## Overview

This documentation plan follows the Diátaxis framework, organizing content into four quadrants:

- **Tutorials** - Learning-oriented, take users through a complete experience
- **How-To Guides** - Task-oriented, solve specific problems
- **Explanations** - Understanding-oriented, clarify concepts
- **Reference** - Information-oriented, describe the machinery

---

## Documentation Structure

```
docs/
├── tutorials/
│   ├── getting-started.md          # First-time onboarding
│   ├── first-tdd-session.md        # Complete TDD workflow
│   └── finding-performance-issues.md # n1-optimizer walkthrough
├── how-to/
│   ├── tdd-strictness.md           # Configure TDD modes
│   ├── tdd-test-patterns.md        # Set up test patterns
│   ├── n1-optimizer-results.md     # Interpret analysis results
│   ├── readme-generate.md          # Generate READMEs
│   ├── readme-audit.md             # Audit existing READMEs
│   ├── doc-master-setup.md         # Configure doc-master
│   └── doc-master-generate.md      # Generate documentation
├── explanations/
│   ├── tdd-mode-hooks.md           # How TDD enforcement works
│   ├── n1-optimizer-agents.md      # Four analyzer architecture
│   ├── prd-readme-standard.md      # PRD-README v1 explained
│   └── diataxis-vs-traditional.md  # Documentation frameworks
├── reference/
│   ├── configuration.md            # All plugin configuration
│   ├── tdd-dev-commands.md         # TDD command reference
│   ├── n1-optimizer-patterns.md    # Performance pattern catalog
│   ├── readme-writer-tests.md      # 10 acceptance tests
│   └── doc-master-agents.md        # 9 specialized agents
└── DOCUMENTATION_PLAN.md           # This file
```

---

## Document Inventory

### Tutorials (3 documents)

| Document | Purpose | Prerequisites |
|----------|---------|---------------|
| Getting Started | Install plugins, run first commands | Claude Code installed |
| Your First TDD Session | Complete red-green-refactor cycle | Getting Started |
| Finding Performance Issues | Detect and fix N+1 queries | Getting Started |

### How-To Guides (7 documents)

| Document | Task | Plugin |
|----------|------|--------|
| TDD Strictness | Configure enforcement levels | tdd-dev |
| TDD Test Patterns | Set up test file detection | tdd-dev |
| n1-optimizer Results | Prioritize and fix findings | n1-optimizer |
| README Generate | Create new READMEs | readme-writer |
| README Audit | Evaluate existing READMEs | readme-writer |
| doc-master Setup | Choose documentation standard | doc-master |
| doc-master Generate | Create documentation | doc-master |

### Explanations (4 documents)

| Document | Concept | Why It Matters |
|----------|---------|----------------|
| TDD Mode & Hooks | Hook-based enforcement | Understanding prevents confusion |
| n1-optimizer Agents | Parallel analysis design | Explains result format |
| PRD-README Standard | Quality measurement | Explains audit scoring |
| Diátaxis vs Traditional | Framework comparison | Informs setup choice |

### Reference (5 documents)

| Document | Contents | Format |
|----------|----------|--------|
| Configuration | All plugin settings | Tables with defaults |
| tdd-dev Commands | Command syntax & options | Synopsis + examples |
| n1-optimizer Patterns | Performance anti-patterns | Code examples + fixes |
| readme-writer Tests | 10 acceptance criteria | Pass/fail examples |
| doc-master Agents | 9 specialized agents | Triggers + capabilities |

---

## Cross-References

Documents link to each other following these patterns:

- **Tutorials** → Reference for complete details
- **How-To** → Reference for syntax, Explanations for context
- **Explanations** → Reference for specifics
- **Reference** → How-To for practical application

---

## Maintenance Notes

### Update Triggers

| Trigger | Action |
|---------|--------|
| New plugin command | Update reference + add how-to if needed |
| Configuration change | Update configuration.md |
| New agent added | Update agent reference |
| Pattern added | Update patterns reference |

### Quality Checks

- All code examples should be runnable
- All internal links should resolve
- Command syntax should match implementation
- Configuration defaults should be current

---

## Generation Summary

- **Total documents:** 19
- **Tutorials:** 3
- **How-To Guides:** 7
- **Explanations:** 4
- **References:** 5
- **Framework:** Diátaxis
- **Target:** Plugin users
