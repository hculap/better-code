# How to Interpret n1-optimizer Results

This guide walks you through reading and acting on n1-optimizer analysis output. After running `/n1-optimizer:analyze`, you receive findings from four parallel agents. This guide helps you understand what each section means and how to prioritize fixes.

## Understanding the Output Structure

The n1-optimizer runs four specialized agents simultaneously, each producing a findings section. Your output contains:

1. **Database Agent Findings** - Query patterns, N+1 issues, missing indexes
2. **Backend Agent Findings** - Loop inefficiencies, batching opportunities, caching gaps
3. **Frontend Agent Findings** - Render loops, excessive re-fetching, component inefficiencies
4. **API Agent Findings** - Over-fetching, under-fetching, pagination issues

Each agent reports issues in a consistent format with severity, location, description, and fix recommendations.

## Severity Levels

Every finding includes a severity level. Use these to guide your response:

| Severity | Meaning | Action Required | Typical Impact |
|----------|---------|-----------------|----------------|
| **HIGH** | Critical performance issue | Fix immediately | >100ms latency or O(n) database calls |
| **MEDIUM** | Noticeable degradation | Fix in current sprint | 10-100ms latency or suboptimal patterns |
| **LOW** | Minor optimization opportunity | Fix when convenient | <10ms improvement or code quality |

**Rule of thumb**: HIGH severity issues often indicate N+1 queries or unbounded loops that scale poorly with data growth. These become exponentially worse as your application grows.

## Reading Agent-Specific Findings

### Database Agent

Look for these key indicators:

- **"N+1 Pattern Detected"** - A loop executing individual queries instead of a batch
- **"Missing Index"** - Queries scanning full tables
- **"Sequential Queries"** - Multiple queries that could be combined

The database agent shows query locations and suggests specific fixes like `includes()`, `preload()`, or batch operations.

### Backend Agent

This agent identifies code-level inefficiencies:

- **"Loop Database Access"** - Database calls inside iteration
- **"Missing Batch Operation"** - Individual operations that should be batched
- **"Cache Opportunity"** - Repeated expensive computations

Findings include the file path, line numbers, and refactored code examples.

### Frontend Agent

Frontend findings focus on rendering and data fetching:

- **"Render Loop Fetch"** - API calls inside component render cycles
- **"Missing Pagination"** - Unbounded data requests
- **"Excessive Re-renders"** - Components triggering unnecessary updates

The agent identifies component files and suggests patterns like `useMemo`, `useCallback`, or data loading restructuring.

### API Agent

API-layer issues affect network efficiency:

- **"Over-fetching"** - Endpoints returning unused data
- **"Under-fetching"** - Multiple calls needed for single views
- **"Missing Batch Endpoint"** - Individual calls that should be consolidated

## Prioritization Strategy

Follow this decision matrix when multiple issues are found:

```
                    Data Growth Impact
                    Low         High
                 +----------+----------+
User-Facing  Yes |  MEDIUM  |   HIGH   |
Impact           +----------+----------+
             No  |   LOW    |  MEDIUM  |
                 +----------+----------+
```

**Prioritization steps:**

1. **Fix all HIGH severity issues first** - These cause immediate user-visible problems
2. **Address MEDIUM issues in the same code area** - If you are already modifying a file, fix related MEDIUM issues
3. **Group related fixes** - An N+1 in the database layer often pairs with a backend batching opportunity
4. **Defer LOW issues** - Track these but do not interrupt current work

## Example Output with Annotations

```
=== Database Issues (2 High, 1 Medium) ===

[HIGH] N+1 Pattern Detected                        <- Severity and pattern name
  Location: app/services/order_service.rb:45-52   <- Exact file and lines

  Problem: Loop iterates over orders and calls     <- What is wrong
           `order.customer` individually (N queries)

  Impact: 100 orders = 101 queries                 <- Why it matters

  Suggestion: Use `includes(:customer)` in         <- How to fix
              initial query

  Before:                                          <- Current problematic code
    orders.each { |o| puts o.customer.name }

  After:                                           <- Corrected code
    Order.includes(:customer).each { |o| puts o.customer.name }
```

Each finding follows this structure: severity, location, explanation, impact assessment, and actionable fix with code examples.

## Verifying Your Fix Worked

After implementing fixes:

1. **Re-run the analysis**: Execute `/n1-optimizer:analyze` on the same scope
2. **Compare findings**: The fixed issues should no longer appear
3. **Check for regressions**: Ensure fixes did not introduce new issues
4. **Validate with metrics**: If available, compare before/after query counts or response times

A successful fix removes the finding from output. If the issue persists, verify you modified the correct location and that the change was saved.

## Quick Reference

| Agent | Primary Focus | Common Fix Patterns |
|-------|---------------|---------------------|
| Database | Query efficiency | includes, joins, batch queries |
| Backend | Code-level loops | Batch operations, caching |
| Frontend | Render cycles | Memoization, pagination |
| API | Network efficiency | Field selection, batch endpoints |

When in doubt, start with the highest severity database findings. These typically yield the largest performance improvements with the least code change.

## See Also

- [Finding Performance Issues Tutorial](../tutorials/finding-performance-issues.md)
- [Understanding the Four n1-optimizer Agents](../explanations/n1-optimizer-agents.md)
- [n1-optimizer Patterns Reference](../reference/n1-optimizer-patterns.md)
