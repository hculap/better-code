# Documentation Quality Criteria

Comprehensive checklists for evaluating and improving documentation quality.

## Quick Audit Checklist

Use this for rapid assessment:

- [ ] README exists and is current
- [ ] Installation instructions work
- [ ] All public APIs documented
- [ ] Code examples run without errors
- [ ] No broken links
- [ ] Last update within 6 months

## Comprehensive Audit Criteria

### 1. Completeness

#### Coverage
- [ ] All public classes/functions documented
- [ ] All parameters described with types
- [ ] All return values documented
- [ ] All error conditions explained
- [ ] All configuration options listed

#### Scope
- [ ] Installation/setup covered
- [ ] Authentication explained
- [ ] Common use cases addressed
- [ ] Edge cases documented
- [ ] Migration guides for major versions
- [ ] Deprecation notices present

#### Examples
- [ ] Quick start example exists
- [ ] Examples for each major feature
- [ ] Examples show realistic scenarios
- [ ] Examples include error handling
- [ ] Examples show both success and failure paths

### 2. Accuracy

#### Technical Correctness
- [ ] Code examples tested and working
- [ ] API signatures match implementation
- [ ] Version numbers current
- [ ] Dependencies correctly specified
- [ ] Platform requirements accurate

#### Freshness
- [ ] Documentation matches current version
- [ ] Deprecated features marked
- [ ] New features documented
- [ ] Changelog maintained
- [ ] Last reviewed date visible

#### Links
- [ ] Internal links working
- [ ] External links accessible
- [ ] Links point to correct versions
- [ ] Anchor links resolve

### 3. Clarity

#### Language
- [ ] Active voice used consistently
- [ ] Sentences concise (under 25 words)
- [ ] Technical terms defined or linked
- [ ] Consistent terminology throughout
- [ ] Appropriate reading level for audience

#### Structure
- [ ] Logical heading hierarchy
- [ ] Paragraphs focused (one idea each)
- [ ] Lists used for steps/options
- [ ] Tables used for comparisons
- [ ] Code blocks properly formatted

#### Navigation
- [ ] Table of contents for long docs
- [ ] Breadcrumbs or location indicators
- [ ] Search functionality works
- [ ] Related content linked
- [ ] Next steps suggested

### 4. Organization

#### Information Architecture
- [ ] Clear entry point (README/index)
- [ ] Logical section grouping
- [ ] Progressive complexity
- [ ] Consistent file naming
- [ ] Intuitive folder structure

#### Content Types
- [ ] Tutorials separate from reference
- [ ] Conceptual separate from procedural
- [ ] Quick start separate from deep dives
- [ ] Troubleshooting centralized

#### Cross-References
- [ ] Related topics linked
- [ ] Prerequisites stated
- [ ] Next steps provided
- [ ] See also sections where helpful

### 5. Maintainability

#### Source Control
- [ ] Docs versioned with code
- [ ] Changes tracked in commits
- [ ] Branch strategy for doc updates
- [ ] Review process defined

#### Single Source of Truth
- [ ] No duplicated content
- [ ] Generated docs from source where possible
- [ ] Templates used for consistency
- [ ] Variables for version numbers

#### Process
- [ ] Update triggers documented
- [ ] Owner/maintainer assigned
- [ ] Review schedule established
- [ ] Contribution guidelines exist

### 6. Accessibility

#### Visual
- [ ] Alt text for images
- [ ] Sufficient color contrast
- [ ] Not relying solely on color
- [ ] Readable font sizes
- [ ] Responsive design

#### Structural
- [ ] Semantic heading hierarchy
- [ ] Skip navigation links
- [ ] Keyboard navigable
- [ ] Screen reader compatible

#### Inclusive Language
- [ ] Gender-neutral terms
- [ ] No ableist language
- [ ] Culturally neutral examples
- [ ] Internationalization considered

## Scoring Guide

### Per Category (0-10)

| Score | Description |
|-------|-------------|
| 0-2 | Critical gaps, unusable |
| 3-4 | Major issues, difficult to use |
| 5-6 | Adequate, room for improvement |
| 7-8 | Good, minor issues only |
| 9-10 | Excellent, best practices followed |

### Overall Grade

| Average Score | Grade | Action |
|---------------|-------|--------|
| 0-3 | F | Urgent overhaul needed |
| 4-5 | D | Significant improvements required |
| 5-6 | C | Address major gaps |
| 7-8 | B | Polish and refine |
| 9-10 | A | Maintain and iterate |

## Audit Report Template

```markdown
# Documentation Audit Report

**Project:** [Name]
**Date:** [Date]
**Auditor:** [Name]
**Scope:** [What was reviewed]

## Executive Summary

[2-3 sentence overview of findings]

## Scores by Category

| Category | Score | Notes |
|----------|-------|-------|
| Completeness | X/10 | |
| Accuracy | X/10 | |
| Clarity | X/10 | |
| Organization | X/10 | |
| Maintainability | X/10 | |
| Accessibility | X/10 | |
| **Overall** | **X/10** | |

## Critical Issues

1. [Issue]: [Impact] - [Recommendation]
2. ...

## Warnings

1. [Issue]: [Impact] - [Recommendation]
2. ...

## Suggestions

1. [Improvement opportunity]
2. ...

## Action Items

| Priority | Item | Owner | Due |
|----------|------|-------|-----|
| High | | | |
| Medium | | | |
| Low | | | |
```

## Continuous Quality Metrics

### Automated Checks
- Link validation (weekly)
- Code example testing (on PR)
- Spell check (on PR)
- Reading level analysis (monthly)
- Accessibility scan (monthly)

### User Signals
- Search queries with no results
- Page bounce rates
- Time on page
- Support ticket topics
- User feedback/ratings

### Process Metrics
- Days since last update
- Outstanding issues/PRs
- Coverage of new features
- Review completion rate
