---
name: generate
description: Generate documentation for specific feature or component
argument-hint: "<feature> [--type tutorial|howto|reference|explanation] [--output path]"
allowed-tools: ["Read", "Write", "Glob", "Grep", "Bash", "AskUserQuestion", "Task"]
---

# Documentation Generator

Generate documentation for a specific feature, component, or module using the appropriate specialized agent.

## Arguments

- `feature` (required): What to document
  - Feature name: "user authentication", "payment processing"
  - Component path: "./src/components/Button"
  - Module: "api/users"

- `--type` (optional): Document type to generate
  - `tutorial`: Learning-oriented walkthrough
  - `howto`: Task-oriented guide
  - `reference`: Technical reference documentation
  - `explanation`: Conceptual explanation
  - If omitted: Generate appropriate type based on context

- `--output` (optional): Output path for generated documentation
  - Default: Suggests appropriate location based on project structure

## Process

### Step 1: Load Configuration

Read `.claude/doc-master.local.md` for:
- Documentation standard (Diátaxis/Traditional/Custom)
- Custom rules (if applicable)
- Project-specific notes

### Step 2: Analyze Feature

1. Locate feature code:
   - Search for related files
   - Read main implementation
   - Identify dependencies

2. Understand feature:
   - What does it do?
   - How is it used?
   - What are the public interfaces?
   - What are common use cases?

3. Identify domain:
   - Backend → Use backend-docs agent
   - Frontend → Use frontend-docs agent
   - API → Use api-docs agent
   - Database → Use database-docs agent
   - Architecture → Use architecture-docs agent
   - Tests → Use test-docs agent
   - User-facing → Use user-guide-docs agent
   - Compliance → Use compliance-docs agent
   - Mobile → Use mobile-docs agent

### Step 3: Determine Document Type

If `--type` not specified, determine based on:
- Feature nature (new feature → tutorial, existing API → reference)
- User needs (ask if unclear)
- Existing documentation gaps

### Step 4: Gather Information

Collect all information needed for documentation:
- Code signatures, parameters, return types
- Usage examples from tests or existing code
- Related documentation
- Error cases and edge cases

### Step 5: Generate Documentation

**CRITICAL: You MUST use the Task tool to spawn the appropriate specialized agent.** Do NOT generate documentation yourself - delegate to the domain-specific agent.

Use the Task tool with the appropriate `subagent_type`:
- `doc-master:backend-docs` - For backend/service documentation
- `doc-master:frontend-docs` - For frontend/component documentation
- `doc-master:api-docs` - For API/endpoint documentation
- `doc-master:database-docs` - For database/schema documentation
- `doc-master:architecture-docs` - For architecture/design documentation
- `doc-master:test-docs` - For test strategy documentation
- `doc-master:user-guide-docs` - For end-user documentation
- `doc-master:compliance-docs` - For compliance/security documentation
- `doc-master:mobile-docs` - For mobile app documentation

Example Task tool call:
```
Task(
  subagent_type="doc-master:backend-docs",
  description="Document user service",
  prompt="Generate reference documentation for the user service at src/services/user.ts. Include all public methods, parameters, return types, and examples."
)
```

The spawned agent will generate documentation following these guidelines:

**For Reference Documentation:**
- Complete API signatures
- All parameters with types and descriptions
- Return values
- Error conditions
- Working examples

**For Tutorial:**
- Clear learning objectives
- Step-by-step instructions
- Progressive complexity
- Working code at each step
- "What you'll build" preview

**For How-To Guide:**
- Specific problem statement
- Prerequisites
- Numbered steps
- Expected outcomes
- Troubleshooting tips

**For Explanation:**
- Context and background
- Why it works this way
- Trade-offs and alternatives
- Connections to other concepts

### Step 6: Apply Standards

Apply configured documentation standard:

**Diátaxis:**
- Ensure document fits one quadrant only
- Include cross-references to other quadrants
- Follow Diátaxis writing guidelines

**Traditional:**
- Follow hierarchical structure
- Include in appropriate section
- Link to related sections

**Custom:**
- Apply custom style rules
- Use required templates
- Follow terminology guidelines

### Step 7: Output

1. Display generated documentation in console
2. Ask user to review
3. Offer to save to file:
   - Suggest appropriate path
   - Or use `--output` path

## Example Usage

**Generate API reference:**
```
/doc-master:generate "users API" --type reference

Analyzing users API...
Found: src/api/users.ts (245 lines)
Domain: API documentation
Type: Reference

Generating documentation...

# Users API Reference

## Overview
The Users API provides endpoints for managing user accounts...

## Endpoints

### GET /users
List all users with pagination support.

#### Parameters
| Name | Type | Required | Description |
...

[Full reference documentation]

Save to docs/reference/api/users.md? [Y/n]
```

**Generate tutorial:**
```
/doc-master:generate "authentication" --type tutorial

Analyzing authentication feature...
Found: src/auth/ (12 files)
Domain: Backend
Type: Tutorial

Generating documentation...

# Implementing User Authentication

In this tutorial, you'll add complete user authentication
to your application...

## What You'll Build
- User registration
- Login/logout flow
- Protected routes

## Prerequisites
- Node.js 18+
- Completed Getting Started guide

## Step 1: Install Dependencies
...

Save to docs/tutorials/authentication.md? [Y/n]
```

**Auto-detect type:**
```
/doc-master:generate "Button component"

Analyzing Button component...
Found: src/components/Button/Button.tsx
Domain: Frontend
Detected type: Reference (component API)

Generating documentation...

# Button Component

A customizable button component for user interactions.

## Props
| Prop | Type | Default | Description |
...

## Variants
...

## Examples
...
```

## Domain-Specific Generation

Each domain agent brings specialized knowledge:

| Domain | Agent | Specialization |
|--------|-------|----------------|
| Backend | backend-docs | Services, data flows, deployment |
| Frontend | frontend-docs | Components, state, accessibility |
| API | api-docs | Endpoints, schemas, auth |
| Database | database-docs | Schema, migrations, queries |
| Architecture | architecture-docs | Design, ADRs, diagrams |
| Tests | test-docs | Strategy, coverage, plans |
| User Guides | user-guide-docs | Workflows, tutorials, UX |
| Compliance | compliance-docs | Security, audit, regulatory |
| Mobile | mobile-docs | Platform-specific, stores |

## Tips

- Let the agent auto-detect domain when possible
- Provide specific feature names for better results
- Review and edit generated documentation
- Generate reference first, then tutorials
- Use `--type` to override auto-detection
- Iterate: generate, review, refine
