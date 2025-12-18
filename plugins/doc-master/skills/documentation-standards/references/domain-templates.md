# Domain-Specific Documentation Templates

Templates and guidelines for documenting different software domains.

## Backend Documentation

### Service Overview Template

```markdown
# {Service Name}

## Purpose
{What business problem does this service solve?}

## Responsibilities
- {Responsibility 1}
- {Responsibility 2}

## Dependencies
| Service | Purpose | Required |
|---------|---------|----------|
| {name} | {why needed} | Yes/No |

## API Contracts
- Exposes: {list of APIs this service provides}
- Consumes: {list of APIs this service calls}

## Data Stores
| Store | Type | Purpose |
|-------|------|---------|
| {name} | PostgreSQL | Primary data |

## Configuration
| Variable | Description | Default |
|----------|-------------|---------|
| PORT | Server port | 3000 |

## Deployment
- Environment: {production/staging/etc.}
- Scaling: {horizontal/vertical strategy}
- Health check: {endpoint}

## Monitoring
- Key metrics: {list}
- Alerts: {conditions}
- Logs: {location and format}
```

### Data Flow Documentation

```markdown
# {Feature} Data Flow

## Overview
{High-level description of the data flow}

## Flow Diagram
```
[Source] → [Processing] → [Storage] → [Output]
```

## Steps

### 1. {Step Name}
- **Trigger:** {what initiates this step}
- **Input:** {data format and source}
- **Processing:** {what happens}
- **Output:** {data format and destination}
- **Errors:** {possible failures and handling}

### 2. {Step Name}
...

## Error Handling
| Error Type | Handling | Recovery |
|------------|----------|----------|
| {type} | {how handled} | {recovery steps} |
```

## Frontend Documentation

### Component Documentation Template

```markdown
# {ComponentName}

## Purpose
{What this component does and when to use it}

## Props

| Prop | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| {name} | {type} | Yes/No | {value} | {description} |

## Usage

### Basic
```jsx
<ComponentName prop1="value" />
```

### With Options
```jsx
<ComponentName
  prop1="value"
  prop2={callback}
  children={<Child />}
/>
```

## Variants
- **Primary:** {description}
- **Secondary:** {description}

## States
- Loading: {behavior}
- Error: {behavior}
- Empty: {behavior}

## Accessibility
- Role: {ARIA role}
- Keyboard: {keyboard interactions}
- Screen reader: {announcements}

## Related Components
- {ComponentA} - {relationship}
- {ComponentB} - {relationship}
```

### State Management Documentation

```markdown
# {Feature} State

## Store Structure
```typescript
interface {Feature}State {
  data: {type};
  loading: boolean;
  error: Error | null;
}
```

## Actions

### {actionName}
- **Trigger:** {when dispatched}
- **Payload:** {data type}
- **Effect:** {what changes in state}

## Selectors

### select{Something}
- **Returns:** {type}
- **Usage:** `const value = useSelector(selectSomething)`

## Side Effects
| Action | Effect | Outcome |
|--------|--------|---------|
| {action} | API call to {endpoint} | Updates {state} |

## Usage Example
```typescript
const Component = () => {
  const dispatch = useDispatch();
  const data = useSelector(selectData);

  useEffect(() => {
    dispatch(fetchData());
  }, []);

  return <div>{data}</div>;
};
```
```

## API Documentation

### REST Endpoint Template

```markdown
# {Endpoint Name}

## {METHOD} {/path}

{Brief description of what this endpoint does}

### Authentication
{Required auth method: API key, Bearer token, etc.}

### Request

#### Headers
| Header | Value | Required |
|--------|-------|----------|
| Authorization | Bearer {token} | Yes |
| Content-Type | application/json | Yes |

#### Path Parameters
| Parameter | Type | Description |
|-----------|------|-------------|
| {name} | {type} | {description} |

#### Query Parameters
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| {name} | {type} | Yes/No | {value} | {description} |

#### Body
```json
{
  "field": "value",
  "nested": {
    "field": "value"
  }
}
```

### Response

#### Success (200)
```json
{
  "id": "123",
  "data": {...}
}
```

#### Errors
| Status | Code | Description |
|--------|------|-------------|
| 400 | INVALID_INPUT | Request validation failed |
| 401 | UNAUTHORIZED | Invalid or missing auth |
| 404 | NOT_FOUND | Resource doesn't exist |
| 500 | INTERNAL_ERROR | Server error |

### Example

#### Request
```bash
curl -X {METHOD} \
  https://api.example.com{/path} \
  -H "Authorization: Bearer token" \
  -H "Content-Type: application/json" \
  -d '{"field": "value"}'
```

#### Response
```json
{
  "success": true,
  "data": {...}
}
```
```

## Database Documentation

### Schema Documentation Template

```markdown
# {Schema/Database} Documentation

## Overview
{Purpose and scope of this schema}

## Entity Relationship Diagram
```
[Table1] 1--* [Table2] *--1 [Table3]
```

## Tables

### {table_name}

{Purpose of this table}

#### Columns
| Column | Type | Nullable | Default | Description |
|--------|------|----------|---------|-------------|
| id | UUID | No | gen_random_uuid() | Primary key |
| {col} | {type} | Yes/No | {default} | {description} |

#### Indexes
| Name | Columns | Type | Purpose |
|------|---------|------|---------|
| {idx_name} | {columns} | B-tree | {why needed} |

#### Constraints
- PRIMARY KEY: id
- FOREIGN KEY: {column} REFERENCES {table}({column})
- UNIQUE: {columns}
- CHECK: {condition}

#### Relationships
- Has many: {related_table}
- Belongs to: {parent_table}

## Migrations

### {version}_{name}
- **Purpose:** {what this migration does}
- **Reversible:** Yes/No
- **Dependencies:** {prior migrations}
```

## Architecture Documentation

### Architecture Decision Record (ADR) Template

```markdown
# ADR-{number}: {Title}

## Status
{Proposed | Accepted | Deprecated | Superseded by ADR-X}

## Date
{YYYY-MM-DD}

## Context
{What is the issue that we're seeing that motivates this decision?}

## Decision
{What is the change that we're proposing and/or doing?}

## Consequences

### Positive
- {benefit 1}
- {benefit 2}

### Negative
- {tradeoff 1}
- {tradeoff 2}

### Neutral
- {implication}

## Alternatives Considered

### {Alternative 1}
- **Pros:** {benefits}
- **Cons:** {drawbacks}
- **Why rejected:** {reason}

## References
- {related documents, discussions, etc.}
```

### System Design Document Template

```markdown
# {System} Design Document

## Overview
{What system is being designed and why}

## Goals
- {Goal 1}
- {Goal 2}

## Non-Goals
- {Explicitly out of scope}

## Background
{Context needed to understand the design}

## High-Level Design

### Architecture Diagram
```
[Component A] ←→ [Component B] ←→ [Component C]
        ↓              ↓
    [Store]      [External API]
```

### Components
| Component | Responsibility | Technology |
|-----------|---------------|------------|
| {name} | {what it does} | {stack} |

## Detailed Design

### {Component A}
{Detailed design of this component}

### Data Model
{Schema and data structures}

### APIs
{Interface definitions}

## Security Considerations
- {security aspect 1}
- {security aspect 2}

## Performance Considerations
- Expected load: {metrics}
- Scaling strategy: {approach}

## Monitoring & Observability
- Key metrics: {list}
- Alerts: {conditions}

## Rollout Plan
1. {Phase 1}
2. {Phase 2}

## Open Questions
- {Question 1}
```

## Test Documentation

### Test Plan Template

```markdown
# {Feature} Test Plan

## Overview
{What is being tested and why}

## Scope

### In Scope
- {functionality to test}

### Out of Scope
- {excluded areas}

## Test Strategy

### Unit Tests
- Coverage target: {percentage}
- Focus areas: {components}

### Integration Tests
- Scope: {what integrations}
- Environment: {test env}

### E2E Tests
- Critical paths: {user journeys}
- Browser coverage: {list}

## Test Cases

### {Test Suite Name}

| ID | Description | Steps | Expected | Priority |
|----|-------------|-------|----------|----------|
| TC001 | {what} | {steps} | {result} | High/Med/Low |

## Test Data
| Data Set | Purpose | Location |
|----------|---------|----------|
| {name} | {why needed} | {path} |

## Environment Requirements
- {requirement 1}
- {requirement 2}

## Success Criteria
- All critical tests passing
- Coverage > {threshold}
- No P1 bugs open
```

## User Guide Documentation

### Feature Guide Template

```markdown
# {Feature Name}

## What is {Feature}?
{Brief explanation in user-friendly terms}

## Getting Started

### Prerequisites
- {requirement 1}
- {requirement 2}

### Step 1: {Action}
{Instructions with screenshot if helpful}

### Step 2: {Action}
{Instructions}

## Common Tasks

### How to {Task 1}
1. {Step}
2. {Step}
3. {Step}

### How to {Task 2}
...

## Tips and Best Practices
- {Tip 1}
- {Tip 2}

## Troubleshooting

### {Problem}
**Cause:** {why this happens}
**Solution:** {how to fix}

## FAQ

### {Question}?
{Answer}

## Related
- [{Related Feature}]({link})
- [{Help Article}]({link})
```

## Compliance Documentation

### Security Control Documentation Template

```markdown
# {Control Name}

## Control ID
{Standard-Number, e.g., SOC2-CC6.1}

## Description
{What this control requires}

## Implementation

### Technical Controls
- {Control 1}: {how implemented}
- {Control 2}: {how implemented}

### Administrative Controls
- {Policy}: {reference}
- {Procedure}: {reference}

## Evidence

### Automated Evidence
| Source | Frequency | Location |
|--------|-----------|----------|
| {system} | {schedule} | {where stored} |

### Manual Evidence
| Document | Owner | Review Cycle |
|----------|-------|--------------|
| {doc} | {role} | {frequency} |

## Testing

### Test Procedure
1. {Step}
2. {Step}

### Expected Results
- {Expected outcome}

## Exceptions
| Exception | Justification | Expiration |
|-----------|---------------|------------|
| {what} | {why} | {date} |

## Related Controls
- {Related control IDs}
```
