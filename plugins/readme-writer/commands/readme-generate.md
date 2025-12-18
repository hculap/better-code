---
description: Generate a README following PRD-README v1 standard
argument-hint: [target-directory]
allowed-tools: Read, Glob, Grep, Bash(git:*, ls:*, cat:*, find:*, head:*, test:*)
---

Generate a perfect README.md following the PRD-README v1 standard.

## Target Directory

Target: $ARGUMENTS (use current directory if not specified)

## Step 1: Analyze Codebase

Perform full codebase analysis to auto-detect project context:

### Package Manifest
Read the primary package manifest file:
- package.json (Node.js)
- pyproject.toml / setup.py (Python)
- Cargo.toml (Rust)
- go.mod (Go)
- pom.xml / build.gradle (Java)
- Gemfile / *.gemspec (Ruby)

Extract: name, description, version, dependencies, scripts/commands, keywords, author, license

### Project Structure
Analyze directory structure to determine project type:
- CLI tool: bin/ directory, CLI entry point
- Library: src/index.* with exports
- API/Server: src/server.*, api/ directory
- Frontend: src/components/, src/pages/
- Plugin: plugin manifest files

### Configuration Files
Check for:
- .env.example → required environment variables
- config/ or *.config.* → configuration options
- docker-compose.yml → deployment context
- .github/workflows/ → CI/CD setup

### Existing Documentation
Read existing README.md if present to understand:
- Current positioning and style
- Existing examples that work
- Gaps to fill

### Git Information
Gather repository context:
- Remote URL for repository links
- Recent tags for versioning
- Commit activity for status assessment

## Step 2: Determine Step 0 Values

Based on analysis, determine:

```
Primary user: [derived from tech stack and project type]
Primary job: [derived from main functionality]
Success in 5 minutes: [derived from quickstart possibilities]
```

## Step 3: Generate README

Create README.md following this exact section order:

### Title and Value Proposition
```markdown
# ProjectName

One-sentence value proposition: what it does + for whom + differentiator.
```

### Status Line
```markdown
Status: [active|beta|stable|deprecated] | [Docs](link) | [Changelog](link) | [Issues](link)
```

Use badges sparingly (only build status, version, license if applicable).

### Why/Motivation (if needed)
Brief explanation of why this project exists (2-3 sentences max).

### Quickstart Section
Include ALL of:
1. Prerequisites with explicit versions
2. Install command (one-liner)
3. Run/Use command (minimal example)
4. Expected output shown in code block

Ensure commands are copy/pasteable with zero modifications.

### Usage Section
Include 2-3 common workflows:
- Most frequent use case
- Second most frequent use case
- Each with: explanation (1-3 sentences), code block, pitfall note if applicable

### Configuration (if applicable)
Document key configuration options. Link to detailed docs if extensive.

### Contributing Section
Either link to CONTRIBUTING.md or state contribution policy.

### Support Section
Document:
- Where to ask questions
- How to report bugs
- What info to include in issues

### Security Section
Link to SECURITY.md or provide vulnerability reporting instructions.

### License Section
State license name and link to LICENSE file.

## Step 4: Validate Output

Before presenting README, verify:
- [ ] Value proposition answers "what is it" in 10 seconds
- [ ] Status is clear
- [ ] Quickstart is executable (no placeholders needing user edits)
- [ ] At least one runnable example exists
- [ ] Expected output is shown
- [ ] License is explicit
- [ ] Headings follow hierarchy (no skipping levels)

## Output Format

Present the generated README in a code block, ready to save.

If existing README.md exists, show a diff summary of changes or offer to show the complete new version.
