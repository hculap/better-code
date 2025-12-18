# Diátaxis Framework - Complete Guide

The Diátaxis framework (from Greek "dia" + "taxis" meaning "across arrangement") provides a systematic approach to documentation that serves different user needs.

## The Four Quadrants

### Tutorials

**Purpose:** Learning-oriented content that teaches through doing.

**Characteristics:**
- Guides the learner through a series of steps
- Shows how to complete a meaningful project
- Focuses on learning, not accomplishing a task
- Has a clear beginning, middle, and end
- Provides a safe, repeatable learning experience

**Writing Guidelines:**
- Let the learner learn by doing
- Get the learner started immediately
- Make sure the tutorial works every time
- Ensure the learner sees results immediately
- Focus on concrete steps, not abstract concepts
- Provide minimum necessary explanation
- Focus on what the learner will do, not what they should know

**Example Structure:**
```markdown
# Building Your First Widget

## What You'll Learn
By the end of this tutorial, you'll have created a working widget
that displays real-time data.

## Prerequisites
- Node.js 18+ installed
- Basic JavaScript knowledge
- 30 minutes of time

## Step 1: Create the Project
First, create a new directory and initialize the project...

## Step 2: Install Dependencies
...

## Step 3: Create Your First Component
...

## What's Next
Now that you have a working widget, explore:
- How-to guide: Adding interactivity
- Reference: Widget API
```

### How-to Guides

**Purpose:** Task-oriented content that solves specific problems.

**Characteristics:**
- Addresses a specific problem or question
- Assumes knowledge and competence
- Provides a series of steps to achieve a goal
- Focuses on practical application
- Answers "How do I...?" questions

**Writing Guidelines:**
- Focus on actions, not concepts
- Provide a sequence of steps
- Solve a specific problem
- Don't explain underlying concepts
- Be flexible about starting points
- Reference related guides

**Example Structure:**
```markdown
# How to Configure SSL Certificates

This guide shows how to set up SSL certificates for production.

## Prerequisites
- Admin access to server
- Domain name configured
- OpenSSL installed

## Steps

### 1. Generate Certificate Signing Request
```bash
openssl req -new -newkey rsa:2048 ...
```

### 2. Submit to Certificate Authority
...

### 3. Install the Certificate
...

## Troubleshooting
- If you see error X, check Y
- Common issue: Z

## Related
- How to renew certificates
- Reference: SSL configuration options
```

### Explanations

**Purpose:** Understanding-oriented content that provides context.

**Characteristics:**
- Discusses topics at a higher level
- Provides background and context
- Explains why things work the way they do
- Connects concepts to other concepts
- Helps build mental models

**Writing Guidelines:**
- Provide context and background
- Explain "why" not just "how"
- Discuss alternatives and tradeoffs
- Connect to bigger picture
- Use analogies where helpful
- Don't include step-by-step instructions

**Example Structure:**
```markdown
# Understanding Event-Driven Architecture

## Overview
Event-driven architecture is a design pattern where system
components communicate by producing and consuming events...

## Why Event-Driven?
Traditional request-response patterns create tight coupling...

### Decoupling Benefits
...

### Scalability Implications
...

## When to Use Events
Events work best when:
- Components need loose coupling
- Operations can be asynchronous
- Multiple consumers need the same data

## When to Avoid Events
Consider alternatives when:
- Strong consistency is required
- Debugging complexity is a concern
- Team is unfamiliar with patterns

## Comparison with Alternatives

| Approach | Coupling | Complexity | Consistency |
|----------|----------|------------|-------------|
| Events   | Loose    | Higher     | Eventual    |
| REST     | Medium   | Lower      | Strong      |
| RPC      | Tight    | Lowest     | Strong      |

## Further Reading
- Tutorial: Building an Event-Driven System
- Reference: Event Schema Specification
```

### Reference

**Purpose:** Information-oriented content that describes the machinery.

**Characteristics:**
- Describes the system objectively
- Is structured around the code/API
- Provides accurate, complete information
- Serves as a lookup resource
- Mirrors the structure of the codebase

**Writing Guidelines:**
- Be accurate and complete
- Describe, don't explain
- Be consistent in structure
- Keep descriptions concise
- Include all parameters, options, returns
- Show examples for each item

**Example Structure:**
```markdown
# Widget API Reference

## Widget

The Widget class represents a displayable component.

### Constructor

```javascript
new Widget(options)
```

#### Parameters

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| options.id | string | Yes | - | Unique identifier |
| options.title | string | No | "" | Display title |
| options.width | number | No | 300 | Width in pixels |

#### Returns
`Widget` - A new Widget instance

#### Example
```javascript
const widget = new Widget({
  id: 'main-widget',
  title: 'Dashboard',
  width: 500
});
```

### Methods

#### render()

Renders the widget to the DOM.

```javascript
widget.render()
```

##### Returns
`void`

##### Example
```javascript
widget.render();
```
```

## Document Type Selection

| User Need | Document Type | Example Query |
|-----------|--------------|---------------|
| "I want to learn" | Tutorial | "How do I get started with X?" |
| "I want to do X" | How-to | "How do I configure Y?" |
| "I want to understand" | Explanation | "Why does Z work this way?" |
| "I need details on" | Reference | "What parameters does A accept?" |

## Common Anti-Patterns

### Mixing Types
Don't combine tutorials with reference. A tutorial that stops to explain every API parameter loses momentum.

### Missing Types
Most projects have reference but lack tutorials. Users struggle to get started.

### Wrong Type for Content
Putting "how to" content in reference makes the reference cluttered. Putting concepts in tutorials slows learning.

### No Cross-References
Each document type should link to related documents of other types.

## Implementation Checklist

- [ ] Tutorials exist for major features
- [ ] How-to guides cover common tasks
- [ ] Explanations provide context for complex areas
- [ ] Reference covers all public APIs
- [ ] Documents link to related content of other types
- [ ] Navigation clearly separates the four types
- [ ] Each document clearly identifies its type
