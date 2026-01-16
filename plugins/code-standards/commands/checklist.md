---
description: Output the code review checklist for copy/paste
allowed-tools: Read
---

# Code Review Checklist

Output the lightweight review checklist ready for copy/paste into PR comments or code reviews.

## Checklist Output

```markdown
## Code Review Checklist

### Quick Validation
- [ ] Can I explain this code in 30 seconds?
- [ ] File sizes within limits? (target: 100-300 LOC, warning: 400, critical: 800)
- [ ] Function sizes within limits? (target: 10-30 LOC, warning: 50, critical: 80)
- [ ] One responsibility per module/class?

### Code Quality
- [ ] No hidden global state or surprising side effects?
- [ ] Errors handled meaningfully (no silent failures)?
- [ ] No swallowed exceptions or empty catch blocks?
- [ ] Appropriate logging at boundaries?

### Configuration & Security
- [ ] Config validated at startup?
- [ ] No secrets or credentials in code?
- [ ] External input validated and sanitized?
- [ ] Using parameterized queries (if applicable)?

### Testing
- [ ] Tests cover the important behavior?
- [ ] Tests focus on behavior, not implementation?
- [ ] Edge cases and error paths tested?

### Style & Consistency
- [ ] Formatting/lint checks pass?
- [ ] Type checks pass (if applicable)?
- [ ] Naming is clear and consistent?
- [ ] Comments explain "why", not "what"?

### Principles Check
- [ ] **KISS**: Is this the simplest solution?
- [ ] **DRY**: No real duplication? (not premature abstraction)
- [ ] **YAGNI**: No features built "for later"?
- [ ] **SRP**: Each module has one reason to change?
```

## Additional Context

If settings exist in `.claude/code-standards.local.md`, read them and adjust the thresholds in the checklist to match the project's configured limits.

For example, if strict thresholds are configured:
- Change "target: 100-300 LOC, max: 400-600" to "target: 100-200 LOC, max: 250"
- Change "target: 10-30 LOC, max: 50" to "target: 10-20 LOC, max: 30"

## Output Format

Present the checklist in a clean, copyable format. If the user mentions they want it for a specific platform (GitHub PR, Jira, etc.), adjust formatting as needed.
