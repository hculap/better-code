# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2025-12-15

### Added
- Initial release of N1-Optimizer plugin
- Four parallel analysis agents:
  - `database-analyzer`: N+1 queries, missing indexes, ORM issues
  - `backend-analyzer`: Algorithm complexity, blocking operations, memory issues
  - `frontend-analyzer`: Re-renders, bundle size, state management patterns
  - `api-analyzer`: Over/under-fetching, pagination, caching
- `/n1-optimizer:analyze` command for orchestrated parallel analysis
- `performance-patterns` skill with anti-pattern reference guide
- Severity classification: HIGH, MEDIUM, LOW based on performance impact
- Consolidated report output with Quick Wins section
