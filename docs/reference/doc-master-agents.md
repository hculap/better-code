# doc-master Agents Reference

This reference documents the 9 specialized documentation agents available in the doc-master plugin.

## Agent Comparison Table

| Agent | Focus | Trigger Keywords | Color |
|-------|-------|------------------|-------|
| [API Docs](#api-documentation-specialist) | REST/GraphQL endpoints | "API", "endpoint", "route" | Blue |
| [Backend Docs](#backend-documentation-specialist) | Server architecture | "backend", "service", "server" | Yellow |
| [Frontend Docs](#frontend-documentation-specialist) | UI components | "component", "React", "Vue" | Purple |
| [Database Docs](#database-documentation-specialist) | Schemas, models | "schema", "database", "table" | Pink |
| [Architecture Docs](#architecture-documentation-specialist) | System design | "architecture", "ADR", "design" | Cyan |
| [Test Docs](#test-documentation-specialist) | Test strategy | "test", "spec", "coverage" | Gray |
| [User Guide Docs](#user-guide-documentation-specialist) | End-user docs | "user guide", "tutorial", "help" | Green |
| [Compliance Docs](#compliance-documentation-specialist) | Security, audit | "compliance", "security", "GDPR" | Red |
| [Mobile Docs](#mobile-documentation-specialist) | iOS/Android | "mobile", "iOS", "Android" | Orange |

---

## API Documentation Specialist

### Trigger Conditions

Activated when documentation request contains:
- "API", "endpoint", "route"
- "REST", "GraphQL"
- References to `/api/` paths

**Example triggers:**
```
/doc-master:generate "users API"
/doc-master:generate "REST endpoints in src/api/"
/doc-master:generate "GraphQL schema"
```

### Capabilities

- Analyzes route definitions and handlers
- Documents request/response schemas
- Identifies authentication requirements
- Generates OpenAPI-compatible structure
- Creates curl command examples

### Output Format

```markdown
# {API Name}

## Overview
## Authentication
## Endpoints

### {Method} {Path}
#### Request (path params, query params, body)
#### Response (success, errors)
#### Example
```

### Tools Available

Read, Glob, Grep, LS, Task, WebSearch, AskUserQuestion

---

## Backend Documentation Specialist

### Trigger Conditions

Activated when request contains:
- "backend", "service", "server"
- "architecture", "module"
- "business logic", "data flow"

**Example triggers:**
```
/doc-master:generate "order service"
/doc-master:generate "backend architecture"
/doc-master:generate "payment processing module"
```

### Capabilities

- Documents services and business logic
- Creates architecture diagrams
- Documents data flows
- Writes deployment documentation
- Documents error handling

### Output Format

```markdown
# {Service Name}

## Overview
## Architecture
## Dependencies
## Data Flow
## Configuration
## Error Handling
## Deployment
```

### Tools Available

Read, Glob, Grep, Bash, AskUserQuestion

---

## Frontend Documentation Specialist

### Trigger Conditions

Activated when request contains:
- "component", "UI"
- "React", "Vue", "Angular"
- "state management", "styling"

**Example triggers:**
```
/doc-master:generate "Button component"
/doc-master:generate "React components in src/ui/"
/doc-master:generate "state management"
```

### Capabilities

- Documents component props and events
- Creates usage examples
- Documents variants and states
- Identifies accessibility features
- Maps component relationships

### Output Format

```markdown
# {ComponentName}

## Import
## Usage
## Props
## Events
## Variants
## Accessibility
## Related Components
```

### Tools Available

Read, Glob, Grep, Bash, AskUserQuestion

---

## Database Documentation Specialist

### Trigger Conditions

Activated when request contains:
- "schema", "database", "table"
- "model", "entity", "migration"
- "ERD", "data model"

**Example triggers:**
```
/doc-master:generate "database schema"
/doc-master:generate "users table"
/doc-master:generate "entity relationships"
```

### Capabilities

- Documents tables and columns
- Creates ER diagrams (Mermaid)
- Documents relationships
- Shows indexes and constraints
- Provides example queries

### Output Format

```markdown
# Database Schema

## Overview
## ER Diagram
## Tables

### {table_name}
#### Columns
#### Constraints
#### Indexes
#### Relationships
```

### Tools Available

Read, Glob, Grep, Bash, AskUserQuestion

---

## Architecture Documentation Specialist

### Trigger Conditions

Activated when request contains:
- "architecture", "system design"
- "ADR", "decision record"
- "diagram", "infrastructure"

**Example triggers:**
```
/doc-master:generate "system architecture"
/doc-master:generate "ADR for caching strategy"
/doc-master:generate "infrastructure documentation"
```

### Capabilities

- Creates architecture overviews
- Documents design decisions (ADRs)
- Generates component diagrams
- Documents integration points
- Explains trade-offs

### Output Format

```markdown
# Architecture Overview

## System Context
## Components
## Data Flow
## Infrastructure
## Design Decisions

## ADR: {Decision Title}
### Context
### Decision
### Consequences
```

### Tools Available

Read, Glob, Grep, Bash, AskUserQuestion

---

## Test Documentation Specialist

### Trigger Conditions

Activated when request contains:
- "test", "testing", "spec"
- "coverage", "TDD"
- "test strategy", "test plan"

**Example triggers:**
```
/doc-master:generate "testing strategy"
/doc-master:generate "test coverage report"
/doc-master:generate "test patterns"
```

### Capabilities

- Documents testing strategy
- Creates test coverage reports
- Documents test patterns
- Writes testing guidelines
- Documents fixtures and mocks

### Output Format

```markdown
# Testing Documentation

## Overview
## Test Stack
## Running Tests
## Test Structure
## Coverage
## Patterns
## Utilities
## CI Integration
```

### Tools Available

Read, Glob, Grep, Bash, AskUserQuestion

---

## User Guide Documentation Specialist

### Trigger Conditions

Activated when request contains:
- "user guide", "user documentation"
- "tutorial", "walkthrough"
- "help", "how-to"

**Example triggers:**
```
/doc-master:generate "user guide for dashboard"
/doc-master:generate "getting started tutorial"
/doc-master:generate "feature walkthrough"
```

### Capabilities

- Creates end-user tutorials
- Documents workflows
- Writes help articles
- Creates FAQs
- Documents UI features

### Output Format

```markdown
# {Feature} User Guide

## Overview
## Prerequisites
## Getting Started
## Step-by-Step Guide
## Tips and Best Practices
## Troubleshooting
## FAQ
```

### Tools Available

Read, Glob, Grep, Bash, AskUserQuestion

---

## Compliance Documentation Specialist

### Trigger Conditions

Activated when request contains:
- "compliance", "security"
- "GDPR", "SOC2", "HIPAA"
- "audit", "regulatory"

**Example triggers:**
```
/doc-master:generate "security documentation"
/doc-master:generate "GDPR compliance"
/doc-master:generate "audit trail documentation"
```

### Capabilities

- Documents security controls
- Creates compliance checklists
- Documents audit trails
- Maps regulatory requirements
- Documents access controls

### Output Format

```markdown
# {Compliance Area} Documentation

## Overview
## Scope
## Controls
## Implementation
## Audit Evidence
## Monitoring
## Incident Response
```

### Tools Available

Read, Glob, Grep, Bash, AskUserQuestion

---

## Mobile Documentation Specialist

### Trigger Conditions

Activated when request contains:
- "mobile", "app"
- "iOS", "Android"
- "React Native", "Flutter"

**Example triggers:**
```
/doc-master:generate "mobile app screens"
/doc-master:generate "iOS documentation"
/doc-master:generate "React Native navigation"
```

### Capabilities

- Documents screens and navigation
- Creates platform-specific docs
- Documents native modules
- Writes deep linking docs
- Documents app store requirements

### Output Format

```markdown
# Mobile Documentation

## Overview
## Architecture
## Navigation
## Screens
## Components
## Native Modules
## Push Notifications
## Offline Support
## Build & Release
```

### Tools Available

Read, Glob, Grep, Bash, AskUserQuestion

---

## Agent Selection Logic

When multiple agents could apply:

| Request | Primary Agent | Why |
|---------|---------------|-----|
| "Document the API" | API Docs | Explicit API mention |
| "Document the user service" | Backend Docs | "Service" keyword |
| "Document how users authenticate" | User Guide Docs | User-facing focus |
| "Document the auth API" | API Docs | API takes precedence |
| "Document database for auth" | Database Docs | Database explicit |

### Override with --type

Force a specific document type:

```
/doc-master:generate "authentication" --type reference
/doc-master:generate "authentication" --type tutorial
```

---

## Common Properties

All agents share:

| Property | Value |
|----------|-------|
| Model | haiku (fast) or sonnet (detailed) |
| File Writing | Delegated to command |
| Path Format | Absolute paths |
| Output | Markdown |

---

## See Also

- [How to Generate Documentation](../how-to/doc-master-generate.md)
- [How to Set Up doc-master](../how-to/doc-master-setup.md)
- [Diataxis vs Traditional Documentation](../explanations/diataxis-vs-traditional.md)
