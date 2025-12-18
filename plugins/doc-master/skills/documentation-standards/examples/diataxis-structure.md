# Example: Diátaxis Documentation Structure

This example shows how to organize documentation following the Diátaxis framework.

## Directory Structure

```
docs/
├── index.md                    # Documentation home
├── tutorials/
│   ├── index.md               # Tutorials overview
│   ├── getting-started.md     # First tutorial
│   ├── build-first-app.md     # Project-based tutorial
│   └── deploy-to-production.md
├── how-to/
│   ├── index.md               # How-to guides overview
│   ├── configure-auth.md
│   ├── handle-errors.md
│   ├── optimize-performance.md
│   └── migrate-from-v1.md
├── explanation/
│   ├── index.md               # Explanations overview
│   ├── architecture.md
│   ├── security-model.md
│   └── design-decisions.md
└── reference/
    ├── index.md               # Reference overview
    ├── api/
    │   ├── client.md
    │   ├── server.md
    │   └── types.md
    ├── configuration.md
    └── cli.md
```

## Navigation Example (mkdocs.yml)

```yaml
nav:
  - Home: index.md
  - Tutorials:
    - tutorials/index.md
    - Getting Started: tutorials/getting-started.md
    - Build Your First App: tutorials/build-first-app.md
    - Deploy to Production: tutorials/deploy-to-production.md
  - How-to Guides:
    - how-to/index.md
    - Configure Authentication: how-to/configure-auth.md
    - Handle Errors: how-to/handle-errors.md
    - Optimize Performance: how-to/optimize-performance.md
    - Migrate from v1: how-to/migrate-from-v1.md
  - Explanation:
    - explanation/index.md
    - Architecture: explanation/architecture.md
    - Security Model: explanation/security-model.md
    - Design Decisions: explanation/design-decisions.md
  - Reference:
    - reference/index.md
    - API:
      - Client: reference/api/client.md
      - Server: reference/api/server.md
      - Types: reference/api/types.md
    - Configuration: reference/configuration.md
    - CLI: reference/cli.md
```

## Sample Tutorial Page

```markdown
# Getting Started with Widget Library

In this tutorial, you'll create your first widget and display it in a web page.
By the end, you'll have a working interactive widget showing live data.

**Time:** 15 minutes
**Prerequisites:** Basic HTML and JavaScript knowledge

## What You'll Build

A simple dashboard widget that displays the current time and updates every second.

## Step 1: Set Up Your Project

Create a new directory and initialize a project:

```bash
mkdir my-first-widget
cd my-first-widget
npm init -y
npm install widget-library
```

## Step 2: Create the HTML Page

Create an `index.html` file:

```html
<!DOCTYPE html>
<html>
<head>
  <title>My First Widget</title>
</head>
<body>
  <div id="widget-container"></div>
  <script src="main.js"></script>
</body>
</html>
```

## Step 3: Create the Widget

Create a `main.js` file:

```javascript
import { Widget } from 'widget-library';

const widget = new Widget({
  container: '#widget-container',
  title: 'Current Time'
});

// Update every second
setInterval(() => {
  widget.setContent(new Date().toLocaleTimeString());
}, 1000);
```

## Step 4: Run Your Widget

Start a local server and open the page:

```bash
npx serve .
```

Open http://localhost:3000 in your browser. You should see your widget
displaying the current time, updating every second.

## What's Next

Now that you have a basic widget working:

- **Tutorial:** [Build a Complete Dashboard](./build-first-app.md)
- **How-to:** [Configure Widget Styling](../how-to/configure-styling.md)
- **Reference:** [Widget API](../reference/api/widget.md)
```

## Sample How-to Page

```markdown
# How to Configure Authentication

This guide shows how to set up authentication for your widgets.

## Prerequisites

- Widget Library installed
- API key from the dashboard

## Steps

### 1. Get Your API Key

Go to the [Developer Dashboard](https://dashboard.example.com) and create
a new API key with the scopes you need.

### 2. Configure the Client

```javascript
import { Client } from 'widget-library';

const client = new Client({
  apiKey: process.env.WIDGET_API_KEY
});
```

### 3. Use Authenticated Requests

```javascript
const data = await client.fetchData();
```

### 4. Handle Authentication Errors

```javascript
try {
  const data = await client.fetchData();
} catch (error) {
  if (error.code === 'INVALID_API_KEY') {
    // Handle invalid key
  }
}
```

## Common Issues

**"Invalid API Key" error**
- Verify the key is copied correctly
- Check the key has required scopes
- Ensure the key isn't expired

## Related

- [Security Model](../explanation/security-model.md)
- [Client API Reference](../reference/api/client.md)
```

## Sample Explanation Page

```markdown
# Architecture Overview

This document explains the architecture of Widget Library and the
decisions behind its design.

## High-Level Architecture

Widget Library follows a client-server architecture where widgets
render on the client while data is fetched from the server.

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Browser   │────▶│   Widget    │────▶│    API      │
│             │◀────│   Library   │◀────│   Server    │
└─────────────┘     └─────────────┘     └─────────────┘
```

## Why Client-Side Rendering?

We chose client-side rendering for several reasons:

1. **Interactivity:** Widgets can respond instantly to user actions
2. **Real-time updates:** WebSocket connections enable live data
3. **Reduced server load:** Rendering happens on user devices

The tradeoff is initial load time, which we mitigate with code splitting.

## Data Flow

When a widget requests data:

1. Widget calls `client.fetchData()`
2. Client checks local cache
3. If cache miss, request goes to API server
4. Server validates authentication
5. Server fetches from database
6. Response cached and returned to widget

## Caching Strategy

We use a two-tier caching strategy:

- **Browser cache:** Short TTL (5 minutes) for frequently accessed data
- **Server cache:** Longer TTL (1 hour) for shared data

This balances freshness with performance.

## Related

- [Tutorial: Getting Started](../tutorials/getting-started.md)
- [How-to: Optimize Performance](../how-to/optimize-performance.md)
- [Reference: Cache Configuration](../reference/configuration.md#cache)
```

## Sample Reference Page

```markdown
# Client API Reference

## Client

The main class for interacting with the Widget API.

### Constructor

```javascript
new Client(options)
```

#### Options

| Property | Type | Required | Default | Description |
|----------|------|----------|---------|-------------|
| apiKey | string | Yes | - | Your API key |
| baseUrl | string | No | https://api.widget.io | API base URL |
| timeout | number | No | 30000 | Request timeout (ms) |
| retries | number | No | 3 | Retry attempts |

#### Example

```javascript
const client = new Client({
  apiKey: 'wk_live_xxx',
  timeout: 60000
});
```

### Methods

#### fetchData(query)

Fetches data from the API.

##### Parameters

| Name | Type | Description |
|------|------|-------------|
| query | object | Query parameters |
| query.type | string | Data type to fetch |
| query.limit | number | Maximum results (default: 100) |

##### Returns

`Promise<DataResponse>` - The fetched data

##### Throws

- `AuthError` - Invalid or missing API key
- `RateLimitError` - Rate limit exceeded
- `NetworkError` - Connection failed

##### Example

```javascript
const response = await client.fetchData({
  type: 'metrics',
  limit: 50
});
console.log(response.data);
```

## Types

### DataResponse

```typescript
interface DataResponse {
  data: any[];
  meta: {
    total: number;
    page: number;
    limit: number;
  };
}
```
```

## Cross-Referencing Pattern

Each document should link to related content of other types:

| From | Link To | Example |
|------|---------|---------|
| Tutorial | How-to for next steps | "Now configure auth: [How-to](../how-to/configure-auth.md)" |
| Tutorial | Reference for details | "See full API: [Reference](../reference/api/client.md)" |
| How-to | Reference for options | "All options: [Configuration](../reference/configuration.md)" |
| How-to | Explanation for context | "Why this works: [Architecture](../explanation/architecture.md)" |
| Explanation | Tutorial to try it | "Try it yourself: [Tutorial](../tutorials/getting-started.md)" |
| Reference | How-to for usage | "How to use: [Configure Auth](../how-to/configure-auth.md)" |
