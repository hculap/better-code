---
description: Disable TDD Dev Mode for the session
allowed-tools: Read, Bash
---

# TDD Mode Deactivation

Disable TDD Dev Mode for this session. Hook enforcement will stop and normal coding workflow resumes.

## Deactivation Steps

1. **Remove the flag file**: Delete `.claude/.tdd-mode-active` if it exists

2. **Confirm deactivation**:

```
TDD Dev Mode: DISABLED

Hook enforcement is now OFF.
Normal coding workflow resumed.

To re-enable: /tdd-dev:start
```

## Note

Even with TDD mode disabled:
- The tdd-methodology skill remains available if you ask about TDD
- You can still use `/tdd-dev:feature`, `/tdd-dev:bug`, `/tdd-dev:refactor` commands explicitly
- Only automatic hook enforcement is disabled

Confirm TDD mode deactivation.
