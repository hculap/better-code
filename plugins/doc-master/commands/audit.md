---
name: audit
description: Audit documentation quality and coverage
argument-hint: "[path] [--detailed | --checklist]"
allowed-tools: ["Read", "Glob", "Grep", "Bash"]
---

# Documentation Audit

Analyze existing documentation for quality, completeness, and adherence to configured standards.

## Arguments

- `path` (optional): Directory to audit (default: `./docs` or project root)
- `--detailed`: Generate comprehensive report with scores and recommendations
- `--checklist`: Quick pass/fail checklist (default mode)

## Process

### Step 1: Load Configuration

Read `.claude/doc-master.local.md` to determine active documentation standard:
- Diátaxis: Audit against four-quadrant criteria
- Traditional: Audit against hierarchical structure
- Custom: Audit against custom rules

If no configuration exists, suggest running `/doc-master:setup` first, but proceed with Diátaxis as default.

### Step 2: Discover Documentation

Search for documentation files:
```
- README.md, README files
- docs/ directory
- *.md files in common locations
- API documentation (openapi.yaml, swagger.json)
- Inline documentation (JSDoc, docstrings)
```

### Step 3: Analyze Documentation

#### Checklist Mode (default)

Quick pass/fail assessment:

**Completeness**
- [ ] README exists and has content
- [ ] Installation/setup documented
- [ ] Main features have documentation
- [ ] API endpoints documented (if applicable)
- [ ] Configuration options listed

**Accuracy**
- [ ] Code examples appear current
- [ ] Version information present
- [ ] No obviously outdated content
- [ ] Links are valid (spot check)

**Clarity**
- [ ] Headings are descriptive
- [ ] Code examples present
- [ ] Consistent formatting

**Organization**
- [ ] Logical structure
- [ ] Navigation/TOC present
- [ ] Related content linked

#### Detailed Mode

Comprehensive analysis with scoring:

**1. Coverage Analysis (0-10)**
- Map documented vs undocumented code
- Check for missing API documentation
- Identify undocumented features
- List documentation gaps

**2. Quality Score (0-10)**
- Writing quality assessment
- Code example validation
- Formatting consistency
- Terminology consistency

**3. Freshness Assessment (0-10)**
- Last modification dates
- Version alignment
- Outdated content detection
- Stale examples identification

**4. Structure Analysis (0-10)**
- Framework compliance (Diátaxis/Traditional/Custom)
- Navigation effectiveness
- Cross-reference quality
- Information architecture

**5. Accessibility Check**
- Image alt text presence
- Heading hierarchy
- Link text quality

### Step 4: Generate Report

Output findings to console:

**Checklist Mode:**
```
Documentation Audit - Checklist
===============================
Path: ./docs

Completeness
  [✓] README exists
  [✓] Installation documented
  [✗] API endpoints missing documentation
  [✓] Configuration documented

Accuracy
  [✓] Code examples appear current
  [✗] Version info missing
  [✓] Links valid

Clarity
  [✓] Descriptive headings
  [✓] Code examples present
  [✗] Inconsistent formatting in 3 files

Organization
  [✓] Logical structure
  [✗] No table of contents
  [✓] Related content linked

Result: 9/13 checks passed
Priority fixes:
1. Add API endpoint documentation
2. Add version information
3. Add table of contents
```

**Detailed Mode:**
```
Documentation Audit - Detailed Report
=====================================
Path: ./docs
Standard: Diátaxis
Date: 2024-01-25

Executive Summary
-----------------
Overall Score: 7.2/10
The documentation is functional but has gaps in API coverage
and could benefit from better organization.

Scores by Category
------------------
| Category       | Score | Status    |
|----------------|-------|-----------|
| Completeness   | 6/10  | Needs work|
| Accuracy       | 8/10  | Good      |
| Clarity        | 7/10  | Adequate  |
| Organization   | 7/10  | Adequate  |
| Freshness      | 8/10  | Good      |

Coverage Analysis
-----------------
Documented:
- User authentication (complete)
- Configuration (complete)
- Getting started (complete)

Missing:
- Payment API endpoints
- Webhook handlers
- Error codes reference

[Additional detailed sections...]

Action Items
------------
Priority 1 (Critical):
- Document Payment API endpoints
- Add error codes reference

Priority 2 (Important):
- Add table of contents to main docs
- Update screenshots in tutorial

Priority 3 (Nice to have):
- Add more code examples
- Improve cross-references
```

## Framework-Specific Criteria

### Diátaxis Audit
- Are all four quadrants represented?
- Is content correctly categorized?
- Do tutorials focus on learning?
- Are how-to guides task-focused?
- Is reference complete and accurate?

### Traditional Audit
- Does structure follow Overview → Getting Started → Reference → Examples → FAQ?
- Is API reference comprehensive?
- Are examples practical and working?

### Custom Audit
- Apply rules from custom configuration
- Check against specified criteria
- Validate against provided templates

## Tips

- Run `--checklist` for quick health checks
- Run `--detailed` before major releases
- Address Priority 1 items first
- Re-audit after making changes
