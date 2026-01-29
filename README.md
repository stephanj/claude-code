# Devoxx CFP Claude Code Plugin

A comprehensive Claude Code plugin for developing the Devoxx Call-for-Papers (CFP) application. This plugin provides 12 specialized AI agents, development skills, project rules, custom commands, and safety hooks to streamline full-stack development.

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Plugin Structure](#plugin-structure)
- [Agents](#agents)
- [Skills](#skills)
- [Rules](#rules)
- [Commands](#commands)
- [Hooks](#hooks)
- [Configuration Files](#configuration-files)
- [Usage Examples](#usage-examples)
- [CFP Tech Stack](#cfp-tech-stack)

## Overview

This plugin transforms Claude Code into a specialized development assistant for the Devoxx CFP application. It includes:

- **12 Specialized Agents** - Domain experts for different aspects of development
- **3 Development Skills** - Best practices and workflows
- **Project Rules** - Framework-specific conventions
- **Custom Commands** - Streamlined workflows like git commit & push
- **Safety Hooks** - Protection against destructive operations

## Installation

1. Clone this repository into your Claude Code plugins directory:

```bash
git clone https://github.com/stephanj/Devoxx-Claude-Plugin.git
```

2. The plugin is automatically loaded by Claude Code when you work in a project that references it.

3. Verify installation by checking available agents in Claude Code.

## Plugin Structure

```
devoxx-claude-plugin/
├── plugin.json           # Plugin manifest (name, version, entry points)
├── settings.json         # Global settings and permissions
├── settings.local.json   # Local developer overrides (gitignored)
├── CLAUDE.md             # Instructions for Claude Code instances
├── agents/               # 12 specialized AI agent definitions
│   ├── java-architect.md
│   ├── spring-boot-engineer.md
│   ├── angular-architect.md
│   ├── firebase-auth-specialist.md
│   ├── langchain4j-ai-engineer.md
│   ├── postgres-pro.md
│   ├── test-automator.md
│   ├── code-reviewer.md
│   ├── typescript-pro.md
│   ├── security-auditor.md
│   ├── ui-ux-designer.md
│   └── accessibility-tester.md
├── skills/               # Development practice skills
│   ├── cfp-development-practices/
│   │   ├── SKILL.md
│   │   └── references/
│   │       ├── accessibility-checklist.md
│   │       ├── full-stack-workflow.md
│   │       └── test-commands.md
│   ├── java-best-practices/
│   │   └── SKILL.md
│   └── typescript-best-practices/
│       └── SKILL.md
├── rules/                # Framework-specific rules
│   └── angular.md
├── commands/             # Custom Claude Code commands
│   └── git-commit-push.md
└── hooks/                # Safety hooks
    └── rm_to_mv_hook.sh
```

## Agents

Agents are specialized AI personas with domain expertise, specific tools, and contextual knowledge. Each agent is defined in a markdown file with frontmatter metadata.

### Agent Structure

```yaml
---
name: agent-name
description: What this agent specializes in
tools: Read, Write, Edit, Bash, Glob, Grep
---

# Agent instructions and patterns...
```

### Available Agents

#### Backend Development

| Agent | Description | Use When |
|-------|-------------|----------|
| **java-architect** | Clean architecture, domain modeling, SOLID principles, Java 25 features | Designing domain models, architecting services, using records/sealed classes |
| **spring-boot-engineer** | REST APIs, Spring configuration, Firebase/LangChain4j integration | Building endpoints, configuring Spring Boot, transaction management |
| **postgres-pro** | SQL optimization, Liquibase migrations, schema design, query tuning | Database design, writing migrations, optimizing queries |

#### Frontend Development

| Agent | Description | Use When |
|-------|-------------|----------|
| **angular-architect** | Angular 18, signals, reactive forms, PrimeNG, accessibility | Building components, state management, form handling |
| **typescript-pro** | Type safety, branded types, discriminated unions, Zod validation | Type definitions, validation schemas, service patterns |
| **ui-ux-designer** | UI components, design systems, accessibility patterns | Design system work, UI improvements, visual consistency |

#### Cross-Cutting Concerns

| Agent | Description | Use When |
|-------|-------------|----------|
| **firebase-auth-specialist** | Full-stack Firebase auth, Spring Security, Angular auth state | Authentication flows, token handling, route guards |
| **langchain4j-ai-engineer** | AI services, RAG patterns, prompt engineering, async processing | AI features, embeddings, proposal analysis |
| **test-automator** | JUnit 5, Testcontainers, Angular testing, test strategies | Writing tests, improving coverage, test infrastructure |
| **code-reviewer** | Code quality, security, best practices enforcement | Code reviews, quality checks, convention compliance |
| **security-auditor** | Vulnerability detection, secure patterns, input validation | Security reviews, penetration testing, compliance |
| **accessibility-tester** | WCAG AA compliance, keyboard navigation, screen readers | Accessibility audits, a11y fixes, compliance testing |

### Agent Collaboration

Agents are designed to work together with clear ownership boundaries. For example:

- **java-architect** defines exception hierarchies; **spring-boot-engineer** implements `@ExceptionHandler`
- **angular-architect** builds components; **typescript-pro** defines type contracts
- **firebase-auth-specialist** handles auth; **security-auditor** reviews for vulnerabilities

## Skills

Skills provide domain knowledge and best practices that can be invoked when needed. They contain patterns, examples, and reference documentation.

### Skill Structure

```yaml
---
name: skill-name
description: When to use this skill
---

# Skill content with patterns and examples...
```

### Available Skills

#### cfp-development-practices

**Location:** `skills/cfp-development-practices/`

Project-level development workflow covering:

- **Plan Structure** - Organizing implementation plans into phases and tasks
- **Full-Stack Workflow** - Step-by-step feature implementation (DB → Backend → Frontend)
- **Domain Patterns** - Proposal submission, speaker profile, admin review flows
- **Test Organization** - Test types, naming conventions, commands
- **Accessibility Requirements** - WCAG AA checklist
- **Security Practices** - Input validation, XSS prevention, secrets management

**Reference Files:**
- `references/full-stack-workflow.md` - Detailed backend/frontend implementation steps
- `references/test-commands.md` - Complete test command reference
- `references/accessibility-checklist.md` - WCAG AA compliance checklist

#### java-best-practices

**Location:** `skills/java-best-practices/`

Java patterns for type-first development:

- **Records for DTOs** - Immutable data transfer objects
- **Sealed Classes** - Discriminated unions with exhaustive pattern matching
- **Value Objects** - Domain primitives like `ProposalId`, `SpeakerId`
- **Optional Usage** - Explicit nullability
- **Builder Pattern** - Required vs optional fields
- **Exception Hierarchy** - Custom exception types
- **Modern Java Features** - Pattern matching, virtual threads, structured concurrency
- **Testing Patterns** - JUnit 5, parameterized tests, AssertJ

#### typescript-best-practices

**Location:** `skills/typescript-best-practices/`

TypeScript patterns for robust frontend code:

- **Discriminated Unions** - Type-safe state management
- **Branded Types** - Distinct types for IDs
- **Const Assertions** - Literal unions
- **Zod Validation** - Runtime validation with type inference
- **Functional Patterns** - Immutability, pure functions
- **Configuration** - Typed config with validation

## Rules

Rules are framework-specific conventions that apply to matching file paths. They're automatically loaded when working with relevant files.

### Angular Rules

**Location:** `rules/angular.md`

**Applies to:** `src/main/webapp/app/**/*`

Key conventions enforced:

```typescript
// Standalone components (default in Angular 18+)
@Component({
  selector: 'cfp-example',
  // standalone: true is NOT needed - it's the default
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `...`
})

// Use input() and output() functions
readonly proposal = input<ProposalDTO | null>(null);
readonly submitted = output<ProposalDTO>();

// Use inject() for DI
private service = inject(ProposalService);

// Use signals for state
private loading = signal(false);
readonly isLoading = this.loading.asReadonly();

// Use computed() for derived state
readonly hasError = computed(() => this.form.invalid && this.form.touched);

// Use native control flow
@if (isLoading()) { <spinner /> }
@for (item of items(); track item.id) { <card [item]="item" /> }

// Use host object, NOT @HostBinding/@HostListener
@Component({
  host: {
    '[class.active]': 'isActive()',
    '(click)': 'onClick()'
  }
})
```

**Accessibility Requirements:**
- Must pass all AXE checks
- WCAG AA compliance mandatory
- Proper form label associations
- Keyboard navigation support

## Commands

Commands are custom Claude Code workflows defined in markdown files. They're invoked with the `/command-name` syntax.

### git-commit-push

**Location:** `commands/git-commit-push.md`

**Invocation:** `/git-commit-push`

**Description:** Creates organized git commits using conventional commits format and pushes to remote.

**What it does:**
1. Reviews current git status and diff
2. Checks recent commit history for style consistency
3. Creates logical, descriptive commits with conventional commit prefixes
4. Pushes all commits to remote

**Allowed Tools:**
- `Bash(git add:*)`
- `Bash(git status:*)`
- `Bash(git commit:*)`
- `Bash(git push:*)`

**Conventional Commit Types:**
```
feat:     New functionality
fix:      Bug fixes
docs:     Documentation only
style:    Formatting, no logic change
refactor: Code restructuring
test:     Test additions/changes
chore:    Maintenance, dependencies
```

## Hooks

Hooks intercept tool calls and can modify, allow, or block them. They provide safety mechanisms and workflow automation.

### rm_to_mv_hook.sh

**Location:** `hooks/rm_to_mv_hook.sh`

**Type:** `preToolUse` hook for `Bash` tool

**Purpose:** Safety net against accidental file deletion

**How it works:**
1. Intercepts any `rm` command in Bash
2. Transforms it to `mv <files> /tmp/rm_trash_<timestamp>/`
3. Files can be recovered from `/tmp/` if needed
4. **Blocks dangerous commands** like `rm -rf /`, `rm -rf /*`, `rm -rf ~`

**Example transformation:**
```bash
# Original command
rm -rf src/old-module

# Transformed to
mkdir -p /tmp/rm_trash_20240115_143022 && mv src/old-module /tmp/rm_trash_20240115_143022/
```

**Requirements:** `jq` must be installed

## Configuration Files

### plugin.json

The plugin manifest defining metadata and entry points:

```json
{
  "name": "devoxx-cfp",
  "version": "1.0.0",
  "description": "Claude Code plugin for the Devoxx CFP application...",
  "author": {
    "name": "Devoxx",
    "url": "https://devoxx.com"
  },
  "keywords": ["devoxx", "cfp", "java", "spring-boot", "angular", "firebase"],
  "license": "MIT",
  "agents": "agents/",
  "skills": "skills/",
  "commands": "commands/",
  "rules": "rules/"
}
```

### settings.json

Global plugin settings including permissions and hooks:

```json
{
  "permissions": {
    "allow": ["Bash(mise *)"]
  },
  "hooks": {
    "preToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "/path/to/hooks/rm_to_mv_hook.sh"
          }
        ]
      }
    ]
  }
}
```

**Permissions:** Pre-allows `mise` commands without prompts

**Hooks:** Configures the rm-to-mv safety hook for all Bash commands

### settings.local.json

Local developer overrides (should be gitignored). Use this for:
- Additional permissions for your workflow
- Disabling hooks during debugging
- Custom tool configurations

## Usage Examples

### Invoking an Agent

Ask Claude Code to use a specific agent:

```
Use the java-architect agent to design a domain model for conference sessions
```

```
Ask the angular-architect to create a proposal submission form with validation
```

```
Have the test-automator write integration tests for the ProposalController
```

### Running Commands

```
/git-commit-push
```

### Using Skills

Skills are typically loaded automatically based on context, but you can reference them:

```
Following the cfp-development-practices skill, implement a new speaker profile feature
```

```
Apply java-best-practices patterns to refactor the ProposalService
```

### Typical Workflows

**Adding a new feature:**
1. Use `java-architect` to design the domain model
2. Use `spring-boot-engineer` to implement the API
3. Use `postgres-pro` for database migration
4. Use `angular-architect` to build the UI
5. Use `test-automator` to write tests
6. Use `code-reviewer` for final review
7. Run `/git-commit-push` to commit

**Fixing an accessibility issue:**
1. Use `accessibility-tester` to identify issues
2. Use `angular-architect` to implement fixes
3. Reference `references/accessibility-checklist.md` for compliance

**Implementing authentication:**
1. Use `firebase-auth-specialist` for full-stack guidance
2. Covers backend (Spring Security) and frontend (Angular) in one workflow

## CFP Tech Stack

This plugin is designed for projects using:

**Backend:**
- Java 25 with modern features (records, sealed classes, pattern matching)
- Spring Boot 3 with Spring Security
- PostgreSQL with Liquibase migrations
- Firebase Admin SDK for authentication
- LangChain4j for AI features

**Frontend:**
- Angular 18 with standalone components
- TypeScript with strict mode
- Signals for state management
- PrimeNG UI components
- Firebase JS SDK

**Build & Test:**
- Maven (backend) with mvnd for speed
- pnpm (frontend)
- Mise for unified task running
- JUnit 5 + Testcontainers (backend)
- Jasmine/Karma (frontend)
- GitHub Actions (CI/CD)

## Key Commands Reference

```bash
# Environment setup
mise run env:setup
mise run dev:start

# Testing
mise run test                          # All tests
mise run test --unit                   # Backend unit (fast)
mise run test --integration            # Backend IT (Docker)
mise run test --frontend               # Angular tests
mise run test --include='Pattern*'     # Filter tests
mise run test --coverage               # With coverage

# Code quality
mise run code:fmt                      # Format code
mise run code:lint                     # Lint check

# Database
mise run dev:db:sql                    # Interactive psql
mise run dev:db:sql -- -c "SELECT 1"   # Run query
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Follow the conventional commits format
4. Ensure all agents and skills are properly documented
5. Submit a pull request

## License

MIT License - see [LICENSE](LICENSE) for details.

---

**Created for the Devoxx community by [Stephan Janssen](https://github.com/stephanj)**
