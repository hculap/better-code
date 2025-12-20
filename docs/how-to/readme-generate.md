# How to Generate a README with readme-writer

This guide walks you through generating a professional README for your project using the readme-writer plugin. You will learn how to run the generator, understand what it analyzes, and customize the output.

## Prerequisites

- The readme-writer plugin installed (`/plugin install readme-writer`)
- A project directory with source code
- Optionally: package.json, configuration files, and git history for richer results

## Steps

### 1. Navigate to your project

Open Claude Code in your project's root directory. The generator works best when run from the top level of your repository.

### 2. Run the generate command

Execute the following command:

```
/readme-writer:generate
```

The generator immediately begins analyzing your project. No additional arguments are required.

### 3. Wait for analysis to complete

The analyzer examines several sources to understand your project:

- **package.json** - Extracts project name, description, dependencies, and available scripts
- **Source code** - Scans for main entry points, exports, and code patterns
- **Git history** - Reviews recent commits to understand project evolution
- **Configuration files** - Checks for TypeScript, ESLint, testing frameworks, and build tools
- **Existing documentation** - Reads any current README or docs to preserve important context

This analysis typically takes 30-60 seconds depending on project size.

### 4. Review the 9-step generation process

The generator follows the PRD-README v1 standard, a structured process to build each README section:

1. **Specify target reader** - Determines primary audience and their job-to-be-done
2. **Engineer the top section** - Creates scannable header (15-30 seconds to understand)
3. **Provide executable quickstart** - Minimal steps to first success (< 5 minutes)
4. **Add real usage** - 2-4 common workflows with examples
5. **Progressive disclosure** - Links to detailed docs elsewhere
6. **Include contributor path** - How to contribute to the project
7. **Add support routes** - Where to get help
8. **Make legal/security clear** - License and security policy
9. **Prevent documentation rot** - Maintainability considerations

Each section is generated based on actual project content rather than generic templates.

### 5. Review the generated README

Once complete, the generator creates or updates `README.md` in your project root. Open the file and verify:

- The project description accurately reflects your software
- Installation commands match your actual setup process
- Code examples are correct and runnable
- All referenced files and paths exist

### 6. Customize sections as needed

After generation, you can manually edit any section. Common customizations include:

- Adding project-specific badges (coverage, downloads, sponsors)
- Expanding usage examples for your most important features
- Including screenshots or diagrams
- Adding acknowledgments or credits sections

The generator produces valid Markdown that you can freely modify.

## When to Regenerate vs Manually Edit

**Regenerate** when you have made significant changes to your project structure, added major features, or changed the installation process. The analyzer will detect these changes and update all affected sections.

**Manually edit** for small updates like fixing typos, adding a single example, or updating version numbers. Direct edits are faster for targeted changes.

**Best practice**: Run the generator after major releases or refactors. Make incremental edits between generations.

## Result

After following these steps, you will have a README.md file containing:

- A professional header with relevant badges
- Clear installation and usage instructions
- Code examples derived from your actual project
- Contribution guidelines ready for open-source collaboration

## Common Issues

### Missing sections in output

Some sections may be omitted if the analyzer cannot find relevant information. For example, the Configuration section requires detectable config files or environment variables. Add the missing information manually or create the relevant source files and regenerate.

### Outdated examples

If code examples reference old APIs, regenerate the README after updating your source code. The analyzer pulls examples from current code.

### Badges not appearing

The generator creates badge markdown, but badges require external services (shields.io, GitHub Actions). Verify your CI/CD is configured and badge URLs are correct.

## See Also

- [How to Audit and Fix README Issues](./readme-audit.md)
- [The PRD-README v1 Standard](../explanations/prd-readme-standard.md)
- [readme-writer Acceptance Tests Reference](../reference/readme-writer-tests.md)
