# Understanding the PRD-README v1 Standard

## What is PRD-README and Why Does It Exist?

Every developer has experienced the frustration of encountering a promising library only to abandon it after ten minutes of confusion. The README looked comprehensive. It had installation instructions, API documentation, and even examples. Yet something fundamental was missing: clarity about what problem the library actually solves and whether it solves *your* problem.

The PRD-README v1 Standard emerged from a simple observation: most READMEs are written for people who have already decided to use the software. They document features and APIs but fail to help developers make the adoption decision itself. This creates a paradox where the documentation assumes knowledge that can only come from using the software.

PRD-README treats the README as a Product Requirements Document for developers. Just as a PRD defines success criteria for a product, a PRD-README defines what developers need to know before they can succeed with your library.

## The Five Outcomes

The fundamental insight is that README quality directly impacts five measurable outcomes:

| Outcome | What It Means |
|---------|---------------|
| **Correct Decisions** | Developers choose your library when it fits and alternatives when it doesn't |
| **Fast Success** | Developers achieve working results quickly |
| **Low Support** | Fewer issues about topics the README already covers |
| **Trust** | Developers believe your documentation reflects reality |
| **Low Drift** | Documentation stays synchronized with code |

These are not abstract goals. They are observable results that indicate whether your README is actually working.

## The Nine-Step Build Process

PRD-README specifies a deliberate sequence for constructing a README. This ordering is not arbitrary—each step builds upon the previous one.

### Step 0: Specify Target Reader and Job-to-Be-Done

Before writing anything, define who you are writing for and what they are trying to accomplish. A CLI tool for DevOps engineers has different readers than a React component library for frontend developers.

### Step 1: Engineer the Top Section

The first 15-30 seconds determine whether a reader continues. This section must immediately communicate:
- What the project is
- What problem it solves
- Whether it's actively maintained

### Step 2: Provide Executable Quickstart

A developer should reach their first success in under 5 minutes. This means:
- Minimal prerequisites
- Copy-pasteable commands
- Visible result at the end

### Step 3: Add Real Usage

Include 2-4 common workflows that demonstrate the library solving real problems. These go beyond "hello world" to show practical application.

### Step 4: Progressive Disclosure

Link to detailed documentation rather than cramming everything into the README. The README is an entry point, not an encyclopedia.

### Step 5: Include Contributor Path

Make it clear how others can contribute, even if it's just "open an issue first."

### Step 6: Add Support Routes

Tell developers where to get help: issue tracker, discussions, Discord, Stack Overflow tag.

### Step 7: Make Legal/Security Clear

Include license information and security policy. These matter for enterprise adoption.

### Step 8: Accessibility Requirements

Use hierarchical headings, alt text for images, and proper semantic structure.

### Step 9: Prevent Documentation Rot

Include practices that keep documentation current: CI checks, automated generation, clear update procedures.

## The Ten Acceptance Tests

The PRD-README standard defines ten specific tests that a compliant README must pass. Each test targets a common README failure mode.

### Test 1: What is it?

**Criteria**: Can a reader identify what the project does within 10 seconds?

**Rationale**: The common mistake of opening with badges, project history, or organizational context wastes precious first-impression time.

### Test 2: Is it maintained?

**Criteria**: Is the project status clear within 10 seconds?

**Rationale**: Developers need to know if they're adopting actively maintained software or abandonware.

### Test 3: Quickstart works

**Criteria**: Can a developer get started in 5 minutes or less?

**Rationale**: Hidden setup requirements, missing prerequisites, and unclear steps lose evaluators.

### Test 4: Runnable example exists

**Criteria**: Is there a copy-pasteable code example that works?

**Rationale**: Examples requiring undocumented adaptations waste developer time and erode trust.

### Test 5: Expected output shown

**Criteria**: Is it clear what success looks like?

**Rationale**: Developers need to know if their result matches expectations.

### Test 6: Navigation works

**Criteria**: Can users find sections in 10 seconds or less?

**Rationale**: Developers often search rather than read linearly. Clear structure serves these users.

### Test 7: License explicit

**Criteria**: Is the license explicitly stated and linked?

**Rationale**: Enterprise adoption requires clear licensing. Missing or ambiguous licenses block adoption.

### Test 8: Contribution route clear

**Criteria**: Is it obvious how to contribute?

**Rationale**: Open source thrives on contributions. Unclear paths lose potential contributors.

### Test 9: Headings hierarchical

**Criteria**: Do headings follow proper hierarchy (h1 > h2 > h3)?

**Rationale**: Accessibility requires semantic structure. Screen readers and navigation tools depend on it.

### Test 10: Scope bounded

**Criteria**: Does it link to detailed docs for advanced topics?

**Rationale**: A README that pretends to be exhaustive frustrates developers who need more detail.

## How PRD-README Differs from Typical Advice

Most README guidance focuses on what sections to include: installation, usage, API, contributing. PRD-README focuses on what outcomes to achieve. The distinction matters because section presence does not guarantee section quality.

| Typical Advice | PRD-README |
|----------------|------------|
| "Add an installation section" | "A developer can install in under 2 minutes" |
| "Include examples" | "Examples are copy-pasteable and produce visible results" |
| "Document the API" | "Developers can find any API detail in under 10 seconds" |
| "Add a contributing section" | "First-time contributors know exactly where to start" |

Perhaps most distinctively, PRD-README treats documentation as testable. Rather than offering subjective guidance about good documentation, it provides specific criteria that can be objectively verified. This approach brings software engineering discipline to documentation.

## Scoring and Prioritization

When auditing a README, issues are classified by priority:

| Priority | Severity | Examples |
|----------|----------|----------|
| **P0** | Critical | Missing quickstart, no clear description |
| **P1** | Major | Examples don't work, navigation broken |
| **P2** | Minor | Missing badges, inconsistent formatting |
| **P3** | Polish | Typos, style inconsistencies |

This prioritization helps teams focus effort where it matters most. Fixing P0 issues has more impact than perfecting P3 details.

## See Also

- [How to Generate a README](../how-to/readme-generate.md)
- [How to Audit and Fix README Issues](../how-to/readme-audit.md)
- [readme-writer Acceptance Tests Reference](../reference/readme-writer-tests.md)
