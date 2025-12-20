# Getting Started with better-code

Welcome to better-code, a collection of Claude Code plugins designed to help you write better code through test-driven development, performance optimization, and documentation. This tutorial will guide you through installing the plugin collection and getting started with each tool.

## What You'll Learn

By the end of this tutorial, you will:
- Install the better-code plugin collection from the marketplace
- Understand what each plugin does and when to use it
- Run your first command with each plugin
- Know where to go for deeper learning

## Before You Begin

Make sure you have:
- Claude Code installed and running
- A project directory where you want to use these plugins
- Basic familiarity with Claude Code slash commands

## Step 1: Add the Marketplace Collection

First, add the better-code collection to your Claude Code marketplace. Open Claude Code and run:

```
/plugin marketplace add hculap/better-code
```

You should see confirmation that the collection was added successfully. This makes all four plugins available for installation but doesn't install them yet.

## Step 2: Choose Your First Plugin

The better-code collection includes four plugins, each serving a different purpose:

| Plugin | Best For | Use When You... |
|--------|----------|-----------------|
| **tdd-dev** | Test-driven development | Want Claude to write tests before implementation |
| **n1-optimizer** | Performance analysis | Need to find N+1 queries and optimize database access |
| **readme-writer** | Documentation | Want to create or audit your project's README |
| **doc-master** | Comprehensive docs | Need API docs, user guides, or architecture documentation |

For this tutorial, we'll install all four. In practice, install only what you need.

## Step 3: Install the Plugins

Run these commands to install each plugin:

```
/plugin install tdd-dev
/plugin install n1-optimizer
/plugin install readme-writer
/plugin install doc-master
```

Each command confirms the installation. The plugins are now ready to use in your current project.

## Step 4: Try tdd-dev

The tdd-dev plugin enforces test-driven development by making Claude write tests before implementation code.

**Start TDD mode:**
```
/tdd-dev:start
```

You should see a confirmation that TDD mode is now active.

**Request a feature:**

Ask Claude to implement something:

> "Add a function that validates email addresses"

Claude will now:
1. Write a failing test first (Red phase)
2. Ask you to confirm the test fails
3. Write implementation code (Green phase)
4. Suggest improvements (Refactor phase)

**Turn off TDD mode:**
```
/tdd-dev:stop
```

> **Tip**: Use `/tdd-dev:start --strict` for stricter enforcement that requires explicit approval between phases.

## Step 5: Try n1-optimizer

The n1-optimizer plugin analyzes your code for performance issues, particularly N+1 query problems common in database applications.

**Run an analysis:**
```
/n1-optimizer:analyze
```

Four specialized agents work simultaneously to examine:
- Database query patterns
- ORM usage and eager loading
- Loop-based data fetching
- Caching opportunities

You should see a comprehensive report identifying potential N+1 issues with specific file locations and recommended fixes.

> **Tip**: This works best with codebases using ORMs like ActiveRecord, Sequelize, Prisma, or SQLAlchemy.

## Step 6: Try readme-writer

The readme-writer plugin helps you create professional README files following the PRD-README v1 standard.

**Generate a README:**
```
/readme-writer:generate
```

Claude analyzes your project structure and creates a comprehensive README including:
- Project description and purpose
- Installation instructions
- Usage examples
- Configuration options
- Contributing guidelines

You should see a complete README.md generated based on your actual codebase.

**Audit an existing README:**
```
/readme-writer:audit
```

This reviews your current README against best practices and suggests improvements.

## Step 7: Try doc-master

The doc-master plugin provides nine specialized documentation agents for different documentation needs.

**Generate documentation:**
```
/doc-master:generate
```

Tell Claude what documentation you need:

> "Create API reference documentation for the user service"

Claude matches your request to the appropriate specialist agent (in this case, the API Documentation agent) and generates targeted documentation.

**Available documentation types:**
- API references
- Architecture documentation
- User guides and tutorials
- Onboarding documentation
- Changelog entries
- Migration guides

You should see professional documentation tailored to your specific request.

> **Tip**: Be specific about what you need. "Document the authentication flow" produces better results than "write some docs."

## Troubleshooting

### Plugin not found after installation

**Why this happens**: The plugin may not have installed correctly.

**How to fix it**: Run `/plugin list` to see installed plugins. If missing, try reinstalling with `/plugin install <plugin-name>`.

### TDD mode not enforcing tests

**Why this happens**: You may have disabled it or started a new session.

**How to fix it**: TDD mode resets between sessions. Run `/tdd-dev:start` at the start of each session where you want enforcement.

### n1-optimizer shows no results

**Why this happens**: Your codebase may not use patterns the analyzer recognizes.

**How to fix it**: Ensure your project uses a supported ORM or database access pattern. The analyzer works best with established frameworks.

## Next Steps

You've now installed and tried all four better-code plugins. To go deeper:

- **tdd-dev**: Learn about strictness levels and customizing the Red-Green-Refactor cycle in [Your First TDD Session](./first-tdd-session.md)
- **n1-optimizer**: Understand the four analysis agents and how to act on their recommendations in [Finding Performance Issues](./finding-performance-issues.md)
- **readme-writer**: Master the PRD-README v1 standard and audit criteria in the [README Writer How-To Guides](../how-to/readme-generate.md)
- **doc-master**: Explore all nine documentation agents and their specialties in the [Doc Master Agents Reference](../reference/doc-master-agents.md)

## Related

- [Configuration Reference](../reference/configuration.md)
- [better-code Repository](https://github.com/hculap/better-code)
- [Filing Issues and Feature Requests](https://github.com/hculap/better-code/issues)
