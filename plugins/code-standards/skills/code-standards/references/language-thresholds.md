# Language-Specific Thresholds

Detailed size limits and conventions by programming language.

> **Note:** These are language-specific recommendations that may override the plugin defaults (File: 800 LOC, Function: 80 LOC). Some languages warrant stricter or more lenient limits based on their conventions and typical patterns.

## TypeScript / JavaScript

> TypeScript/JavaScript uses **stricter limits** than defaults due to the emphasis on small, composable modules.

### File Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 100-250 | Ideal for components/modules |
| Soft limit | 400 | Review structure |
| Hard limit | 600 | Must split |

### Function Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 15-25 | Ideal |
| Soft limit | 40 | Review |
| Hard limit | 60 | Must refactor |

### Additional Rules
- Components: Max 200 LOC for React/Vue components
- Test files: Can be longer (up to 800 LOC) as tests are self-contained
- Index/barrel files: Keep minimal, avoid logic
- Prefer named exports over default exports
- One component per file

### Complexity
- Cyclomatic complexity: Max 10 per function
- Nested callbacks: Max 3 levels deep
- Chained promises: Prefer async/await

---

## Python

### File Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 100-200 | Ideal for modules |
| Soft limit | 350 | Review structure |
| Hard limit | 500 | Must split |

### Function Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 10-20 | Python prefers shorter functions |
| Soft limit | 35 | Review |
| Hard limit | 50 | Must refactor |

### Additional Rules
- Classes: Max 300 LOC including methods
- Methods: Max 30 LOC
- `__init__.py`: Minimal, imports only
- Docstrings: Required for public API
- Type hints: Required for function signatures

### Complexity
- Cyclomatic complexity: Max 8 per function (stricter)
- Indentation depth: Max 4 levels
- List comprehensions: Keep simple, extract if complex

---

## Go

### File Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 200-400 | Go files are typically larger |
| Soft limit | 600 | Review structure |
| Hard limit | 800 | Must split |

### Function Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 20-40 | Error handling adds lines |
| Soft limit | 60 | Review |
| Hard limit | 80 | Must refactor |

### Additional Rules
- Error handling inflates LOC - acceptable
- `*_test.go`: Can be longer (up to 1000 LOC)
- One package per directory
- Prefer composition over inheritance
- Interfaces: Define in consumer package

### Complexity
- Cyclomatic complexity: Max 12 per function (more tolerant)
- Nested error checks: Acceptable up to 4 levels
- Early returns: Encouraged

---

## Java

### File Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 200-400 | One class per file |
| Soft limit | 600 | Review class responsibilities |
| Hard limit | 800 | Must split |

### Method Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 15-30 | Ideal |
| Soft limit | 50 | Review |
| Hard limit | 75 | Must refactor |

### Additional Rules
- Classes: Max 500 LOC excluding imports
- Methods per class: Max 15 public methods
- Constructor: Max 10 parameters (prefer builder pattern)
- Test classes: Can be larger (up to 1000 LOC)
- Package depth: Max 5 levels

### Complexity
- Cyclomatic complexity: Max 10 per method
- Inheritance depth: Max 3 levels
- Interface methods: Max 10 per interface

---

## Ruby

### File Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 100-200 | Rails conventions |
| Soft limit | 300 | Review structure |
| Hard limit | 400 | Must split |

### Method Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 8-15 | Ruby prefers very short methods |
| Soft limit | 25 | Review |
| Hard limit | 40 | Must refactor |

### Additional Rules
- Classes: Max 200 LOC
- Controllers: Max 100 LOC (thin controllers)
- Models: Max 300 LOC (can be larger)
- Views: Max 50 LOC of Ruby code
- Concerns/modules: Max 150 LOC

### Complexity
- Cyclomatic complexity: Max 8 per method
- Nesting: Max 3 levels
- Method chains: Max 4 chained calls

---

## Rust

### File Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 200-400 | Similar to Go |
| Soft limit | 600 | Review structure |
| Hard limit | 800 | Must split |

### Function Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 20-40 | Pattern matching adds lines |
| Soft limit | 60 | Review |
| Hard limit | 80 | Must refactor |

### Additional Rules
- `mod.rs`: Minimal, re-exports only
- Implementations: Keep impl blocks focused
- Traits: Max 10 methods per trait
- Match arms: Max 10 arms per match
- Error types: One per module

### Complexity
- Cyclomatic complexity: Max 12 per function
- Lifetime annotations: Simplify if >3 lifetimes
- Generic constraints: Simplify if >4 constraints

---

## C# / .NET

### File Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 200-400 | Similar to Java |
| Soft limit | 600 | Review structure |
| Hard limit | 800 | Must split |

### Method Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 15-30 | Ideal |
| Soft limit | 50 | Review |
| Hard limit | 75 | Must refactor |

### Additional Rules
- Classes: One per file (mostly)
- Partial classes: Use sparingly
- LINQ: Prefer method syntax, keep readable
- Async methods: Always suffix with `Async`

---

## PHP

### File Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 150-300 | One class per file |
| Soft limit | 450 | Review structure |
| Hard limit | 600 | Must split |

### Method Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 15-25 | Ideal |
| Soft limit | 40 | Review |
| Hard limit | 60 | Must refactor |

### Additional Rules
- Controllers: Max 150 LOC (thin controllers)
- Models/Eloquent: Max 400 LOC
- Traits: Max 200 LOC
- Blade templates: Minimal PHP, use components

---

## Swift

### File Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 200-350 | Similar to TypeScript |
| Soft limit | 500 | Review structure |
| Hard limit | 700 | Must split |

### Function Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 15-30 | Ideal |
| Soft limit | 45 | Review |
| Hard limit | 60 | Must refactor |

### Additional Rules
- Extensions: Use for protocol conformance
- ViewControllers: Max 300 LOC
- SwiftUI Views: Max 150 LOC
- Protocols: Max 8 requirements

---

## Kotlin

### File Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 150-300 | More concise than Java |
| Soft limit | 450 | Review structure |
| Hard limit | 600 | Must split |

### Function Size
| Level | LOC | Notes |
|-------|-----|-------|
| Target | 15-25 | Kotlin is concise |
| Soft limit | 40 | Review |
| Hard limit | 55 | Must refactor |

### Additional Rules
- Data classes: Keep minimal
- Extension functions: Max 20 LOC
- Coroutines: Keep suspend functions focused
- Sealed classes: Max 10 subclasses

---

## Summary Table

Quick reference for all languages compared to plugin defaults:

**Plugin Defaults:** File Hard: 800 LOC | Function Hard: 80 LOC | Complexity: 15

| Language | File Hard | Func Hard | Complexity | vs Default |
|----------|-----------|-----------|------------|------------|
| **Defaults** | **800** | **80** | **15** | - |
| TypeScript/JS | 600 | 60 | 10 | Stricter |
| Python | 500 | 50 | 8 | Stricter |
| Go | 800 | 80 | 12 | Standard |
| Java | 800 | 75 | 10 | Standard |
| Ruby | 400 | 40 | 8 | Stricter |
| Rust | 800 | 80 | 12 | Standard |
| C# | 800 | 75 | 10 | Standard |
| PHP | 600 | 60 | 10 | Stricter |
| Swift | 700 | 60 | 10 | Stricter |
| Kotlin | 600 | 55 | 10 | Stricter |
