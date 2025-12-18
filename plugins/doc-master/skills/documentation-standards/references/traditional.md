# Traditional Documentation Structure

A hierarchical documentation structure suitable for developer tools, APIs, and focused projects.

## Standard Sections

### Overview

**Purpose:** Provide high-level project description and value proposition.

**Content:**
- What the project does
- Key features and capabilities
- Who should use it
- How it compares to alternatives

**Template:**
```markdown
# Project Name

## What is Project Name?

Project Name is a [category] that [primary function]. It helps developers
[key benefit] by [approach].

## Key Features

- **Feature A** - Brief description
- **Feature B** - Brief description
- **Feature C** - Brief description

## Use Cases

- Use case 1
- Use case 2
- Use case 3

## Requirements

- Requirement 1
- Requirement 2
```

### Getting Started

**Purpose:** Enable users to start using the project quickly.

**Content:**
- Installation instructions
- Minimal configuration
- First working example
- Common next steps

**Template:**
```markdown
# Getting Started

## Installation

### npm
```bash
npm install project-name
```

### yarn
```bash
yarn add project-name
```

## Quick Start

### 1. Import the Library

```javascript
import { Client } from 'project-name';
```

### 2. Initialize

```javascript
const client = new Client({
  apiKey: 'your-api-key'
});
```

### 3. Make Your First Request

```javascript
const result = await client.doSomething();
console.log(result);
```

## Next Steps

- [Configure authentication](./authentication.md)
- [Explore the API](./api-reference.md)
- [View examples](./examples.md)
```

### API Reference

**Purpose:** Document all public interfaces completely.

**Content:**
- All classes, functions, methods
- Parameters with types and descriptions
- Return values
- Examples for each item
- Error conditions

**Template:**
```markdown
# API Reference

## Classes

### Client

Main client for interacting with the service.

#### Constructor

```javascript
new Client(options)
```

##### Options

| Property | Type | Required | Description |
|----------|------|----------|-------------|
| apiKey | string | Yes | Your API key |
| timeout | number | No | Request timeout in ms (default: 30000) |
| retries | number | No | Number of retries (default: 3) |

##### Example

```javascript
const client = new Client({
  apiKey: 'sk-...',
  timeout: 60000
});
```

#### Methods

##### doSomething(params)

Performs the primary operation.

###### Parameters

| Name | Type | Description |
|------|------|-------------|
| params.input | string | The input data |
| params.options | object | Optional configuration |

###### Returns

`Promise<Result>` - The operation result

###### Throws

- `AuthenticationError` - Invalid API key
- `ValidationError` - Invalid parameters
- `RateLimitError` - Rate limit exceeded

###### Example

```javascript
const result = await client.doSomething({
  input: 'test data'
});
```

## Types

### Result

```typescript
interface Result {
  id: string;
  data: any;
  metadata: {
    timestamp: Date;
    version: string;
  };
}
```
```

### Examples

**Purpose:** Show complete, working code for common scenarios.

**Content:**
- Real-world use cases
- Complete, runnable code
- Expected output
- Explanatory comments

**Template:**
```markdown
# Examples

## Basic Usage

### Simple Request

```javascript
import { Client } from 'project-name';

const client = new Client({ apiKey: process.env.API_KEY });

async function main() {
  const result = await client.query('Hello, world!');
  console.log(result);
  // Output: { id: '123', response: 'Hi there!' }
}

main();
```

## Advanced Usage

### Batch Processing

Process multiple items efficiently:

```javascript
import { Client, BatchProcessor } from 'project-name';

const client = new Client({ apiKey: process.env.API_KEY });
const processor = new BatchProcessor(client, { concurrency: 5 });

const items = ['item1', 'item2', 'item3'];
const results = await processor.processAll(items);

console.log(`Processed ${results.length} items`);
```

### Error Handling

Robust error handling pattern:

```javascript
import { Client, AuthError, RateLimitError } from 'project-name';

async function robustQuery(input) {
  try {
    return await client.query(input);
  } catch (error) {
    if (error instanceof RateLimitError) {
      await sleep(error.retryAfter);
      return robustQuery(input);
    }
    if (error instanceof AuthError) {
      throw new Error('Check your API key');
    }
    throw error;
  }
}
```

## Integration Examples

### Express.js

```javascript
import express from 'express';
import { Client } from 'project-name';

const app = express();
const client = new Client({ apiKey: process.env.API_KEY });

app.post('/process', async (req, res) => {
  const result = await client.process(req.body);
  res.json(result);
});

app.listen(3000);
```
```

### FAQ

**Purpose:** Answer common questions and troubleshoot issues.

**Content:**
- Frequently asked questions
- Common problems and solutions
- Troubleshooting steps
- Known limitations

**Template:**
```markdown
# FAQ

## General

### What is the rate limit?

The default rate limit is 100 requests per minute. Enterprise plans
have higher limits. See [Rate Limits](./rate-limits.md) for details.

### Which languages are supported?

We provide official SDKs for:
- JavaScript/TypeScript
- Python
- Go
- Ruby

Community SDKs exist for Java, C#, and PHP.

## Troubleshooting

### "Authentication failed" error

This error occurs when:
1. API key is invalid or expired
2. API key doesn't have required permissions
3. API key is for wrong environment (test vs. production)

**Solution:** Verify your API key in the dashboard and ensure you're
using the correct environment.

### Requests are slow

Possible causes:
1. Network latency to API servers
2. Large payload sizes
3. Rate limiting

**Solutions:**
- Use regional endpoints if available
- Enable compression
- Implement caching for repeated requests

### "Invalid parameter" error

Check that:
1. Required parameters are provided
2. Parameter types match the specification
3. String lengths are within limits

## Known Limitations

- Maximum request size: 10MB
- Maximum response time: 60 seconds
- Concurrent connections: 10 per API key
```

## Section Organization

```
docs/
├── README.md              # Overview
├── getting-started.md     # Quick start
├── api-reference/
│   ├── client.md
│   ├── types.md
│   └── errors.md
├── examples/
│   ├── basic.md
│   ├── advanced.md
│   └── integrations.md
├── guides/                # Optional: task-based guides
│   ├── authentication.md
│   ├── error-handling.md
│   └── best-practices.md
└── faq.md
```

## Best Practices

1. **Keep sections focused** - Each section serves one purpose
2. **Link between sections** - Guide users to related content
3. **Update consistently** - All sections should reflect current version
4. **Test all code** - Examples must work
5. **Version documentation** - Match docs to software versions
