# How to Audit and Fix README Issues

Use the readme-writer plugin to identify quality issues in your README and fix them systematically. This guide walks you through running an audit, understanding the results, and improving your documentation score.

## Run the Audit

Start by auditing your current README file.

1. Open your project in Claude Code
2. Run the audit command:
   ```
   /readme-writer:audit
   ```
3. Wait for the analysis to complete (typically 10-30 seconds depending on README size)

The audit evaluates your README against 10 quality criteria based on the PRD-README v1 Standard.

## Understand Your Score

The audit produces a score from 0 to 10, where each point represents one satisfied criterion.

| Score Range | Quality Level | Action Needed |
|-------------|---------------|---------------|
| 9-10 | Excellent | Minor polish only |
| 7-8 | Good | Address P1/P2 issues |
| 5-6 | Fair | Focus on P0/P1 issues first |
| Below 5 | Needs Work | Prioritize critical gaps |

**Example audit output:**

```
README Quality Audit Report
===========================
Score: 6/10

Issues Found:

[P0] CRITICAL: Missing installation instructions
     Section: Getting Started
     Impact: Users cannot install your project

[P1] MAJOR: No usage examples provided
     Section: Usage
     Impact: Users don't know how to use key features

[P2] MINOR: License badge missing from header
     Section: Badges
     Impact: License visibility reduced

[P3] POLISH: Inconsistent heading capitalization
     Section: Throughout
     Impact: Minor readability issue
```

## Read Priority Levels

Issues are ranked by severity to help you focus your effort.

| Priority | Severity | Action |
|----------|----------|--------|
| **P0** | Critical | Blocks users from installing or running your project. Fix immediately. |
| **P1** | Major | Significantly impacts usability. Address after P0 issues. |
| **P2** | Minor | Reduces quality but doesn't block usage. Fix when time permits. |
| **P3** | Polish | Cosmetic improvements. Address during final review. |

## The 10 Acceptance Tests

The audit checks your README against these specific criteria:

1. **What is it?** - Can a reader understand what the project does within 10 seconds?
2. **Is it maintained?** - Is the project status clear within 10 seconds?
3. **Quickstart works** - Can a user get started in 5 minutes or less?
4. **Runnable example** - Is there a copy-pasteable code example?
5. **Expected output** - Is it clear what success looks like?
6. **Navigation** - Can users find sections in 10 seconds or less?
7. **License** - Is the license explicit and linked?
8. **Contribution** - Is the contribution route clear?
9. **Accessibility** - Are headings hierarchical?
10. **Scope** - Does it link to detailed docs for advanced topics?

## Use Auto-Fix for Applicable Issues

Some issues can be fixed automatically. After reviewing the audit report:

1. Confirm which issues are marked as auto-fixable
2. Ask Claude to apply the fixes:
   ```
   Please fix the P2 and P3 issues identified in the audit
   ```
3. Review the changes made to your README
4. Commit the improvements if satisfied

Auto-fix typically handles formatting issues, missing badges, and structural problems where content can be inferred from your codebase.

## Manually Fix Complex Issues

Issues requiring your input cannot be auto-fixed. These typically include:

- **Missing installation steps** - Only you know your exact setup process
- **Usage examples** - Require domain knowledge of your API
- **Architecture explanations** - Need your design decisions documented

To fix manually:

1. Open your README in an editor
2. Address each issue from the audit report, starting with P0
3. Use the section guidance provided in the audit output
4. Save your changes

> **Tip**: For missing sections, ask Claude to help draft content by describing what you need. For example: "Add an installation section for this Node.js CLI tool that uses npm."

## Re-Audit to Verify Improvements

After making fixes, confirm your improvements.

1. Run the audit again:
   ```
   /readme-writer:audit
   ```
2. Compare your new score to the previous one
3. Verify that addressed issues no longer appear
4. Repeat the fix cycle if issues remain

Aim for a score of 8 or higher before considering your README complete.

## Common Issues and Solutions

### "Missing project description"

Add a clear one-paragraph summary immediately after your title explaining what the project does.

### "No API documentation"

Include code examples showing your main functions or CLI commands with expected outputs.

### "Missing contributing guidelines"

Add a CONTRIBUTING.md file or a Contributing section with basic contribution steps.

### "Quickstart too complex"

Reduce installation steps to the minimum required. Move advanced configuration to a separate section.

## See Also

- [How to Generate a README](./readme-generate.md)
- [The PRD-README v1 Standard](../explanations/prd-readme-standard.md)
- [readme-writer Acceptance Tests Reference](../reference/readme-writer-tests.md)
