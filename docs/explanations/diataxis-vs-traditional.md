# Understanding Diataxis vs Traditional Documentation

## Two Philosophies for Organizing Knowledge

When building documentation for a software project, you face a fundamental question: how should information be organized? The answer significantly impacts how effectively users find what they need and whether your documentation scales with your product's complexity. Two dominant philosophies have emerged: the Diataxis framework and traditional linear documentation.

## What is the Diataxis Framework?

Diataxis, from the Greek meaning "a fourfold arrangement," is a documentation framework developed by Daniele Procida that categorizes all technical documentation into four distinct types based on user needs along two axes: study versus work, and acquisition versus application.

### The Four Quadrants

```
                    PRACTICAL
                        │
         Tutorials      │      How-To Guides
      (Learning by      │    (Accomplishing
          doing)        │       a task)
                        │
  STUDY ────────────────┼──────────────── WORK
                        │
       Explanations     │      Reference
     (Understanding     │    (Looking up
       concepts)        │      information)
                        │
                   THEORETICAL
```

**Tutorials** occupy the learning-oriented, practical quadrant. They take users by the hand through a series of steps to complete a project. A tutorial's goal is not to explain concepts but to provide a successful first experience. Think of baking a cake with someone guiding you through each step without explaining the chemistry of leavening.

**How-To Guides** serve users who need to accomplish a specific task. Unlike tutorials, these assume the reader already understands the basics and needs goal-oriented directions. They answer questions like "How do I deploy to production?" or "How do I add authentication?" They are recipes for experienced cooks.

**Explanations** provide understanding-oriented content. They discuss concepts, provide background, illuminate the "why" behind decisions, and help users build a mental model of the system. This document itself is an explanation.

**Reference** documentation is information-oriented and describes the machinery. API documentation, configuration options, and command-line flags belong here. Reference material is accurate, complete, and terse.

### The Key Insight

The power of Diataxis lies in recognizing that these four types have different purposes and should not be mixed. A tutorial that pauses to explain underlying theory loses its learning momentum. Reference documentation that includes tutorials becomes bloated and hard to navigate.

## What is Traditional Documentation?

Traditional documentation follows a linear, progressive structure that guides readers from introduction through mastery. This approach mirrors how textbooks are organized.

### The Typical Structure

| Section | Purpose |
|---------|---------|
| **Overview** | Explains what the project is and why it exists |
| **Getting Started** | Combines installation with first-use example |
| **Core Concepts** | Explains fundamental ideas and architecture |
| **API Reference** | Documents all interfaces and methods |
| **Examples** | Demonstrates common use cases |
| **FAQ** | Addresses common questions |
| **Troubleshooting** | Helps when things go wrong |

This structure feels intuitive because it follows how we naturally think about teaching: introduce, explain, demonstrate, reference.

## When to Choose Diataxis

Diataxis excels in these situations:

### Multiple Distinct Audiences

A database might serve application developers, database administrators, and system architects, each needing different information types. Diataxis lets each audience navigate directly to relevant content.

### Complex Products

Products with many features benefit from Diataxis because the four-quadrant structure prevents documentation from becoming an unwieldy blob. As the product grows, new tutorials, guides, explanations, and references slot into established categories.

### Open-Source Projects with Many Contributors

The clear taxonomy helps contributors understand what type of documentation to write and where it belongs.

### Mature Products Undergoing Documentation Overhaul

Diataxis provides a restructuring framework for accumulated content that has become difficult to navigate.

## When to Choose Traditional

Traditional documentation works well in these cases:

### Simpler Projects

CLI tools, small libraries, and focused utilities often do not need the overhead of four separate documentation types. A single README with linear sections suffices.

### Single-Audience Products

When everyone follows roughly the same learning path, a linear progression feels natural. There's no need to serve different user types differently.

### Rapid Prototypes and Early-Stage Projects

Traditional documentation is faster to write and easier to maintain when the product is still evolving significantly.

### Internal Tools with Dedicated Training

When users receive guided onboarding rather than self-directed learning, comprehensive self-service documentation matters less.

## Tradeoffs Comparison

| Aspect | Diataxis | Traditional |
|--------|----------|-------------|
| **Initial setup effort** | Higher: requires categorizing all content | Lower: follows natural writing flow |
| **Scalability** | Excellent: new content has clear home | Can become unwieldy at scale |
| **Multiple audiences** | Excellent: each type serves different needs | Challenging: assumes one audience |
| **Navigation** | Users choose their path | Users follow prescribed path |
| **Contributor guidance** | Clear: content types are well-defined | Ambiguous: where does new content go? |
| **Maintenance burden** | Moderate: four areas to keep updated | Lower initially, higher at scale |
| **Time to first doc** | Longer: structure decisions upfront | Shorter: just start writing |

## Decision Criteria

Use these questions to guide your choice:

1. **Does your product serve multiple distinct audiences?**
   - Yes → Lean toward Diataxis
   - No → Either can work

2. **Is the project complex with many features?**
   - Yes → Diataxis scales better
   - No → Traditional is simpler

3. **Is documentation expected to grow significantly?**
   - Yes → Diataxis provides structure for growth
   - No → Traditional avoids unnecessary overhead

4. **Do you have multiple documentation contributors?**
   - Yes → Diataxis taxonomy reduces confusion
   - No → Either works

5. **Do users approach with different goals?**
   - Learning, doing, understanding, looking up → Diataxis
   - Linear progression → Traditional

## How doc-master Supports Both

The doc-master plugin recognizes that both frameworks have merit. When you run `/doc-master:setup`, you choose your documentation standard:

- **Diataxis** - Agents produce content tagged by quadrant
- **Traditional** - Agents produce cohesive sections that flow linearly

You can also choose **Custom** to provide your own standards if your organization has established documentation guidelines.

The key insight is that good documentation serves users, not philosophies. Understanding both approaches lets you choose deliberately rather than defaulting to whatever structure you encounter first.

## See Also

- [How to Set Up doc-master](../how-to/doc-master-setup.md)
- [How to Generate Documentation](../how-to/doc-master-generate.md)
- [doc-master Agents Reference](../reference/doc-master-agents.md)
