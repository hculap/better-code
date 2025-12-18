---
name: plan
description: Generate documentation plan for project or feature
argument-hint: "[scope]"
allowed-tools: ["Read", "Glob", "Grep", "Bash", "Write", "AskUserQuestion"]
---

# Documentation Plan Generator

Create a structured documentation plan for a project, feature, or component.

## Arguments

- `scope` (optional): What to plan documentation for
  - If omitted: Plan for entire project
  - Feature name: Plan for specific feature (e.g., "user authentication")
  - Path: Plan for specific directory (e.g., "./src/api")

## Process

### Step 1: Load Configuration

Read `.claude/doc-master.local.md` to determine documentation standard.
Default to Diátaxis if not configured.

### Step 2: Analyze Scope

**For entire project:**
1. Scan codebase structure
2. Identify major components/modules
3. Check existing documentation
4. Map what needs documenting

**For specific feature:**
1. Locate feature code
2. Understand feature scope
3. Identify related components
4. Determine documentation needs

**For specific path:**
1. Analyze code in directory
2. Identify public interfaces
3. Determine documentation requirements

### Step 3: Identify Target Audiences

Ask user (if not clear from context):
- Who will read this documentation?
  - Developers using the API
  - End users of the product
  - Internal team members
  - Operations/DevOps
  - All of the above

### Step 4: Gap Analysis

Compare existing documentation against needs:
- What exists and is current?
- What exists but needs updating?
- What's completely missing?
- What should be removed (outdated)?

### Step 5: Generate Plan

Create documentation plan based on configured standard:

**Diátaxis Plan Structure:**
```markdown
# Documentation Plan: [Scope]

## Overview
- Target audience: [audiences]
- Documentation standard: Diátaxis
- Estimated documents: [count]

## Tutorials (Learning-Oriented)
Priority documents to create:

### 1. Getting Started Tutorial
- **Purpose**: First-time user onboarding
- **Covers**: Installation, basic setup, first use
- **Estimated length**: 1,000-1,500 words
- **Prerequisites**: None

### 2. [Feature] Tutorial
- **Purpose**: Learn [feature] through building
- **Covers**: [topics]
- **Estimated length**: [words]
- **Prerequisites**: Getting Started

## How-To Guides (Task-Oriented)
Priority guides to create:

### 1. How to [Task]
- **Purpose**: Solve specific problem
- **Covers**: [steps]
- **Estimated length**: 500-800 words

[Additional guides...]

## Explanations (Understanding-Oriented)
Conceptual documents needed:

### 1. Architecture Overview
- **Purpose**: Explain system design
- **Covers**: Components, data flow, decisions
- **Estimated length**: 1,500-2,000 words

[Additional explanations...]

## Reference (Information-Oriented)
Reference documentation needed:

### 1. API Reference
- **Purpose**: Complete API documentation
- **Covers**: All public endpoints/methods
- **Format**: Structured reference

[Additional references...]

## Existing Documentation Status
| Document | Status | Action |
|----------|--------|--------|
| README.md | Outdated | Update |
| api.md | Missing | Create |
| setup.md | Current | Keep |

## Recommended Order
1. [First priority document]
2. [Second priority document]
...

## Timeline Suggestion
- Phase 1: Core documents (README, Getting Started)
- Phase 2: API Reference
- Phase 3: How-to guides
- Phase 4: Explanations and tutorials
```

**Traditional Plan Structure:**
```markdown
# Documentation Plan: [Scope]

## Overview
- Target audience: [audiences]
- Documentation standard: Traditional

## Documents to Create

### Overview Section
1. Project README
   - Purpose, features, quick start

2. Architecture Overview
   - System design, components

### Getting Started Section
1. Installation Guide
2. Configuration Guide
3. Quick Start Tutorial

### API Reference Section
1. [Module] API
2. [Module] API
...

### Examples Section
1. Basic Usage Examples
2. Advanced Patterns
3. Integration Examples

### FAQ Section
1. Common Questions
2. Troubleshooting

[Existing documentation status and recommendations...]
```

### Step 6: Ask for Confirmation

Present plan summary and ask:
- Does this plan cover the right scope?
- Any documents to add or remove?
- Any priority adjustments?

### Step 7: Save Plan (Optional)

Offer to save plan as markdown file:
- `docs/DOCUMENTATION_PLAN.md`
- Or custom location

## Example Output

```
Documentation Plan: User Authentication Feature
==============================================

Target Audience: Developers integrating authentication

Documents to Create (Diátaxis):

TUTORIALS
---------
1. Implementing Basic Auth (Priority: High)
   - Walk through adding login/logout
   - ~1,200 words

HOW-TO GUIDES
-------------
1. How to Add Social Login (Priority: Medium)
2. How to Implement MFA (Priority: Medium)
3. How to Handle Session Expiry (Priority: High)

EXPLANATIONS
------------
1. Authentication Architecture (Priority: High)
   - Token flow, security model

REFERENCE
---------
1. Auth API Reference (Priority: High)
   - All auth endpoints
2. Configuration Options (Priority: Medium)

Existing Documentation:
- README.md mentions auth briefly → Expand
- No dedicated auth docs → Create

Recommended Order:
1. Auth API Reference (unblocks other docs)
2. Implementing Basic Auth tutorial
3. Authentication Architecture
4. How-to guides

Save plan to docs/DOCUMENTATION_PLAN.md? [Y/n]
```

## Tips

- Start with API reference - it unblocks other documentation
- Tutorials take longest to write well
- How-to guides are most requested by users
- Reference should match code exactly
- Review plan with stakeholders before starting
