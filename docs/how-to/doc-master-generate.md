# How to Generate Documentation with doc-master

This guide walks you through generating documentation for your codebase using the doc-master plugin. You will learn how to run the generate command, control agent selection, specify document types, and refine the output.

## Prerequisites

Before starting, ensure you have:

- Claude Code installed and configured
- The doc-master plugin installed (`/plugin install doc-master`)
- Optionally: Run `/doc-master:setup` to configure your documentation standard
- A codebase with features you want to document

## Running the Generate Command

The primary command for generating documentation is `/doc-master:generate`. Provide the name of the feature or component you want to document:

```
/doc-master:generate "user authentication"
```

This command analyzes your codebase to find files related to user authentication, selects an appropriate documentation agent, and generates comprehensive documentation.

## Understanding Agent Selection

doc-master automatically selects the best agent based on what it finds in your codebase. The selection process works as follows:

1. **Codebase Analysis**: The command scans your project for files matching the feature name
2. **Pattern Matching**: Based on file types and locations, it identifies the dominant code type
3. **Agent Assignment**: An appropriate specialist agent handles the documentation

Available specialist agents include:

| Agent | Specialization | Triggered By |
|-------|----------------|--------------|
| api-docs | REST/GraphQL endpoints | Route handlers, API controllers |
| backend-docs | Services, business logic | Server-side modules, services |
| frontend-docs | UI components, state | React/Vue/Angular components |
| database-docs | Schemas, migrations | Models, migrations, ORMs |
| architecture-docs | System design, ADRs | Architecture requests |
| test-docs | Test strategy, coverage | Testing-related requests |
| user-guide-docs | End-user tutorials | User-facing feature requests |
| compliance-docs | Security, regulatory | Compliance, audit requests |
| mobile-docs | iOS/Android apps | Mobile platform requests |

For example, if you run `/doc-master:generate "payment processing"` and the command finds service classes and database models, it will dispatch the backend-docs agent.

## Specifying Document Type

Use the `--type` flag to generate documentation following a specific format from the Diataxis framework:

```
/doc-master:generate "payment processing" --type howto
```

The four document types serve different purposes:

**Tutorial** (`--type tutorial`): Learning-oriented guides that walk newcomers through a complete experience. Use this when you want to help someone learn by doing.

```
/doc-master:generate "user registration flow" --type tutorial
```

**How-to** (`--type howto`): Task-oriented guides for solving specific problems. Use this for practical instructions aimed at users who already understand the basics.

```
/doc-master:generate "webhook integration" --type howto
```

**Reference** (`--type reference`): Information-oriented technical descriptions. Use this for API documentation, configuration options, or complete feature specifications.

```
/doc-master:generate "REST API endpoints" --type reference
```

**Explanation** (`--type explanation`): Understanding-oriented discussions of concepts and design decisions. Use this to explain architecture choices or complex subsystems.

```
/doc-master:generate "caching strategy" --type explanation
```

## Controlling Output Location

Use the `--output` flag to specify where documentation should be saved:

```
/doc-master:generate "authentication" --output ./docs/features/
```

You can combine flags:

```
/doc-master:generate "search functionality" --type reference --output ./api-docs/
```

## Reviewing Generated Documentation

After generation completes, review the output carefully:

1. **Verify accuracy**: Check that code examples match your actual implementation
2. **Confirm completeness**: Ensure all public interfaces are documented
3. **Test examples**: Run any code snippets to confirm they work
4. **Check links**: Verify internal references point to correct locations

The generated documentation serves as a strong starting point, but domain expertise improves the final result.

## Regenerating vs Manual Editing

When documentation needs updates, choose your approach based on the situation:

**Regenerate when:**
- The underlying code has changed significantly
- You want a fresh analysis of the current implementation
- The document structure needs a complete overhaul

To regenerate, simply run the command again:

```
/doc-master:generate "payment processing" --type reference
```

**Edit manually when:**
- You need to add context the agent cannot infer from code
- Small corrections or clarifications are needed
- You want to preserve custom additions

For iterative refinement, you can also ask Claude to improve specific sections after generation:

```
Please expand the error handling section in docs/payment-processing.md with more examples
```

## Practical Examples

**Generate API reference for your REST endpoints:**
```
/doc-master:generate "products API" --type reference --output ./docs/api/
```

**Create a tutorial for a new feature:**
```
/doc-master:generate "multi-tenant setup" --type tutorial
```

**Document backend architecture:**
```
/doc-master:generate "order fulfillment service" --type explanation
```

**Generate how-to for common tasks:**
```
/doc-master:generate "database migrations" --type howto
```

## Troubleshooting

### Documentation seems incomplete

Ensure your feature name matches how the code is organized. More specific names yield better results. Instead of "users", try "user authentication service" or "user profile management".

### Wrong agent selected

If the auto-selected agent doesn't match your needs, be more specific in your request. For example, instead of "checkout", use "checkout API endpoints" to trigger the API docs agent.

### Output location not created

The generate command creates the output directory if it doesn't exist. If you see errors, check that you have write permissions to the specified path.

## See Also

- [How to Set Up doc-master](./doc-master-setup.md)
- [doc-master Agents Reference](../reference/doc-master-agents.md)
- [Diataxis vs Traditional Documentation](../explanations/diataxis-vs-traditional.md)
