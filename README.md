# Claude Code Plugin Collection

A comprehensive collection of Claude Code extensions including specialized AI agents, 70+ development skills, project rules, custom commands, and safety hooks to streamline full-stack development.

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

## Overview

This plugin collection enhances Claude Code with:

- **17 Specialized Agents** - Domain experts for different aspects of development
- **110+ Development Skills** - Best practices, patterns, and reference documentation
- **15+ Custom Commands** - Streamlined workflows for git, planning, and communication
- **Project Rules** - Framework-specific conventions
- **Safety Hooks** - Protection against destructive operations

## Installation

1. Clone this repository:

```bash
git clone https://github.com/stephanj/claude-code.git
```

2. Copy the desired components (agents, skills, hooks, commands) to your project's `.claude/` directory or reference them in your Claude Code settings.

3. Verify installation by checking available agents and skills in Claude Code.

## Plugin Structure

```
claude-code/
├── plugin.json           # Plugin manifest (name, version, entry points)
├── settings.json         # Global settings and permissions
├── settings.local.json   # Local developer overrides (gitignored)
├── CLAUDE.md             # Instructions for Claude Code instances
├── agents/               # 17 specialized AI agent definitions
│   ├── java-architect.md
│   ├── spring-boot-engineer.md
│   ├── angular-architect.md
│   ├── mermaid-diagram-specialist.md
│   ├── ascii-ui-mockup-generator.md
│   ├── codebase-pattern-finder.md
│   ├── communication-excellence-coach.md
│   └── ... (17 agents)
├── skills/               # 110+ development practice skills
│   ├── react-expert/
│   ├── python-pro/
│   ├── kubernetes-specialist/
│   └── ... (110+ skills)
├── rules/                # Framework-specific rules
│   └── angular.md
├── commands/             # Custom Claude Code commands
│   ├── git-commit-push.md
│   ├── codex-plan.md
│   ├── compose-email.md
│   ├── viral-tweet.md
│   └── project/          # Project workflow commands
│       ├── discovery/
│       ├── planning/
│       ├── execution/
│       └── retrospectives/
└── hooks/                # Safety and automation hooks
    ├── pre-tool-use/     # Intercept before tool execution
    │   ├── block-dangerous-commands.js
    │   └── protect-secrets.js
    ├── post-tool-use/    # Actions after tool execution
    │   └── auto-stage.js
    ├── notification/     # External notifications
    │   └── notify-permission.js
    ├── utils/            # Hook development utilities
    │   └── event-logger.py
    ├── tests/            # Hook unit tests
    └── rm_to_mv_hook.sh  # Legacy rm-to-mv safety hook
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
| **java-architect** | Clean architecture, domain modeling, SOLID principles, Java 25 features | Designing domain models, architecting services |
| **spring-boot-engineer** | REST APIs, Spring configuration, integrations | Building endpoints, configuring Spring Boot |
| **postgres-pro** | SQL optimization, Liquibase migrations, schema design | Database design, writing migrations, optimizing queries |
| **firebase-auth-specialist** | Firebase Admin SDK, Spring Security, auth flows | Authentication implementation, token handling |
| **langchain4j-ai-engineer** | AI services, RAG patterns, prompt engineering | AI-powered features, embeddings, LLM integration |

#### Frontend Development

| Agent | Description | Use When |
|-------|-------------|----------|
| **angular-architect** | Angular 18, signals, reactive forms, PrimeNG | Building components, state management, form handling |
| **typescript-pro** | Type safety, branded types, discriminated unions | Type definitions, validation schemas, service patterns |
| **ui-ux-designer** | Research-backed UI/UX feedback, design critique | Honest design assessment, avoiding generic aesthetics |
| **ascii-ui-mockup-generator** | ASCII wireframes and UI mockups | Visualizing UI concepts before implementation |

#### Quality & Security

| Agent | Description | Use When |
|-------|-------------|----------|
| **test-automator** | JUnit 5, Testcontainers, Angular testing | Writing tests, improving coverage |
| **code-reviewer** | Code quality, security, best practices | Code reviews, quality checks |
| **security-auditor** | Vulnerability detection, OWASP compliance | Security reviews, penetration testing |
| **accessibility-tester** | WCAG AA compliance, keyboard navigation | Accessibility audits, a11y fixes |

#### Documentation & Visualization

| Agent | Description | Use When |
|-------|-------------|----------|
| **mermaid-diagram-specialist** | Flowcharts, sequence diagrams, ERDs, architecture | Technical documentation, system visualization |
| **codebase-pattern-finder** | Find similar implementations and patterns | Looking for code examples to model after |

#### Communication & Productivity

| Agent | Description | Use When |
|-------|-------------|----------|
| **communication-excellence-coach** | Email refinement, tone calibration, roleplay | Reviewing drafts, preparing difficult conversations |
| **general-purpose** | Default agent for complex multi-step tasks | General development work, automatic delegation |

### Agent Collaboration

Agents are designed to work together with clear ownership boundaries. For example:

- **java-architect** defines exception hierarchies; **spring-boot-engineer** implements `@ExceptionHandler`
- **angular-architect** builds components; **typescript-pro** defines type contracts
- **mermaid-diagram-specialist** documents architecture; **codebase-pattern-finder** locates implementations

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

This plugin includes **110+ specialized skills** organized by category:

#### Frontend Frameworks

| Skill | Description |
|-------|-------------|
| **angular-architect** | Components, NgRx state management, routing, RxJS patterns, testing |
| **react-expert** | Hooks patterns, React 19 features, server components, state management, performance |
| **react-native-expert** | Expo router, list optimization, platform handling, storage hooks |
| **vue-expert** | Composition API, Nuxt, TypeScript integration, state management |
| **vue-expert-js** | JSDoc typing for Vue, composables patterns, testing |
| **nextjs-developer** | App router, server components, data fetching, server actions |
| **typescript-pro** | Advanced types, configuration, patterns, type guards, utility types |
| **javascript-pro** | Async patterns, browser APIs, ES modules, Node.js essentials |

#### JVM & .NET Backend

| Skill | Description |
|-------|-------------|
| **java-architect** | Spring Boot setup, JPA optimization, WebFlux, Spring Security, testing |
| **spring-boot-engineer** | Web, data, security, cloud, testing patterns |
| **kotlin-specialist** | Coroutines/Flow, Android Compose, KMP, Ktor server, DSL idioms |
| **csharp-developer** | Modern C#, ASP.NET Core, Blazor, Entity Framework, performance |
| **dotnet-core-expert** | Clean architecture, minimal APIs, authentication, cloud-native |

#### Python Ecosystem

| Skill | Description |
|-------|-------------|
| **python-pro** | Type system, async patterns, testing, packaging, standard library |
| **django-expert** | Models/ORM, DRF serializers, authentication, viewsets, testing |
| **fastapi-expert** | Pydantic v2, async SQLAlchemy, endpoints, authentication, testing |
| **pandas-pro** | DataFrame operations, aggregation, merging, performance optimization |

#### Systems Programming

| Skill | Description |
|-------|-------------|
| **golang-pro** | Concurrency, generics, interfaces, project structure, testing |
| **rust-engineer** | Ownership, traits, async, error handling, testing |
| **cpp-pro** | Modern C++, templates, concurrency, memory/performance, build tooling |
| **swift-expert** | SwiftUI patterns, async/concurrency, protocol-oriented, testing |

#### PHP, Ruby & CMS Platforms

| Skill | Description |
|-------|-------------|
| **php-pro** | Modern PHP features, Laravel/Symfony patterns, async, testing |
| **laravel-specialist** | Eloquent, Livewire, queues, routing, testing |
| **rails-expert** | Active Record, Hotwire/Turbo, RSpec testing, background jobs, API development |
| **wordpress-pro** | Gutenberg blocks, hooks/filters, plugin/theme development, performance |
| **shopify-expert** | Liquid templating, Storefront API, app development, checkout customization |

#### Database & SQL

| Skill | Description |
|-------|-------------|
| **postgres-pro** | Extensions, JSONB, replication, performance tuning, maintenance |
| **sql-pro** | Query patterns, window functions, optimization, database design |
| **database-optimizer** | Index strategies, MySQL/PostgreSQL tuning, monitoring, query optimization |

#### DevOps & Infrastructure

| Skill | Description |
|-------|-------------|
| **devops-engineer** | CI/CD, Docker patterns, GitHub Actions, incident response, platform engineering |
| **kubernetes-specialist** | Helm charts, GitOps, service mesh, operators, networking, troubleshooting |
| **terraform-engineer** | Module patterns, state management, providers, testing, best practices |
| **cloud-architect** | AWS, Azure, GCP reference patterns and best practices |

#### Observability & SRE

| Skill | Description |
|-------|-------------|
| **monitoring-expert** | Prometheus metrics, OpenTelemetry, dashboards, alerting, structured logging |
| **sre-engineer** | SLO/SLI management, error budgets, toil automation, incident response |
| **chaos-engineer** | Experiment design, game days, Kubernetes chaos, infrastructure chaos |

#### Security

| Skill | Description |
|-------|-------------|
| **secure-code-guardian** | OWASP prevention, input validation, XSS/CSRF protection, security headers |
| **security-reviewer** | SAST tools, secret scanning, vulnerability patterns, penetration testing |

#### Testing & Quality

| Skill | Description |
|-------|-------------|
| **test-master** | TDD, unit/integration/E2E testing, QA methodology, test reports |
| **playwright-expert** | Selectors/locators, page object model, API mocking, debugging flaky tests |
| **code-reviewer** | Review checklist, feedback patterns, spec compliance, common issues |
| **debugging-wizard** | Debugging strategies, tools, systematic debugging, common patterns |

#### API & Backend Architecture

| Skill | Description |
|-------|-------------|
| **api-designer** | REST patterns, OpenAPI, pagination, versioning, error handling |
| **graphql-architect** | Schema design, resolvers, federation, subscriptions, security |
| **microservices-architect** | Decomposition, communication patterns, data management, observability |
| **websocket-engineer** | Protocol, scaling, security, patterns, alternatives (SSE, polling) |
| **nestjs-expert** | Controllers/routing, services/DI, DTOs/validation, authentication |

#### Architecture & Design

| Skill | Description |
|-------|-------------|
| **architecture-designer** | ADR templates, architecture patterns, system design, NFR checklist |
| **fullstack-guardian** | Integration patterns, security checklists, API design standards |
| **legacy-modernizer** | Strangler fig pattern, migration strategies, refactoring, legacy testing |

#### AI/ML Engineering

| Skill | Description |
|-------|-------------|
| **ml-pipeline** | Feature engineering, training pipelines, experiment tracking, model validation |
| **rag-architect** | Vector databases, chunking strategies, embedding models, retrieval optimization |
| **fine-tuning-expert** | LoRA/PEFT, dataset preparation, hyperparameter tuning, deployment |
| **prompt-engineer** | Prompt patterns, evaluation frameworks, structured outputs, system prompts |

#### Mobile, Gaming & Specialized

| Skill | Description |
|-------|-------------|
| **flutter-expert** | BLoC/Riverpod state, GoRouter navigation, widget patterns, performance |
| **game-developer** | Unity/Unreal patterns, ECS, multiplayer networking, performance optimization |
| **embedded-systems** | Microcontrollers, RTOS patterns, memory/power optimization, protocols |
| **salesforce-developer** | Apex development, LWC, SOQL/SOSL, integration patterns, DevOps |

#### Data Engineering & Tooling

| Skill | Description |
|-------|-------------|
| **spark-engineer** | RDD operations, Spark SQL/DataFrames, streaming, partitioning/caching |
| **mcp-developer** | MCP protocol, TypeScript/Python SDK, tools and resources |
| **cli-developer** | Design patterns, Go/Node/Python CLI development, UX patterns |
| **code-documenter** | API docs, docstrings, JSDoc, user guides, documentation systems |

#### Requirements & Workflow

| Skill | Description |
|-------|-------------|
| **feature-forge** | EARS syntax, acceptance criteria, specification templates, interviews |
| **spec-miner** | Analysis process, specification extraction, EARS format |
| **atlassian-mcp** | Jira queries, Confluence operations, MCP server setup, workflows |
| **jira** | Jira integration patterns and workflows |
| **qa-test-planner** | QA planning, test strategy, coverage analysis |

#### Communication & Writing

| Skill | Description |
|-------|-------------|
| **professional-communication** | Business communication, stakeholder updates |
| **difficult-workplace-conversations** | Handling sensitive discussions, conflict resolution |
| **feedback-mastery** | Giving and receiving constructive feedback |
| **crafting-effective-readmes** | Documentation best practices, README templates |
| **writing-clearly-and-concisely** | Technical writing, clarity improvements |
| **humanizer** | Making AI-generated content more natural |

#### Diagramming & Visualization

| Skill | Description |
|-------|-------------|
| **c4-architecture** | C4 model diagrams for software architecture |
| **mermaid-diagrams** | Mermaid syntax for flowcharts, sequences, ERDs |
| **draw-io** | Draw.io diagram creation and editing |
| **excalidraw** | Excalidraw whiteboard diagrams |
| **marp-slide** | Marp presentation slides from markdown |

#### Workflow & Productivity

| Skill | Description |
|-------|-------------|
| **daily-meeting-update** | Standup summaries, progress reports |
| **session-handoff** | Context handoff between sessions |
| **ship-learn-next** | Iterative shipping methodology |
| **commit-work** | Commit message crafting, git workflows |
| **dependency-updater** | Dependency management, version updates |
| **reducing-entropy** | Code simplification, complexity reduction |

#### Code Generation & Tooling

| Skill | Description |
|-------|-------------|
| **codex** | AI-powered code generation patterns |
| **command-creator** | Claude Code command development |
| **plugin-forge** | Claude Code plugin development |
| **openapi-to-typescript** | Generate TypeScript from OpenAPI specs |
| **agent-md-refactor** | Agent markdown file refactoring |
| **skill-judge** | Skill quality evaluation |

#### Analysis & Design

| Skill | Description |
|-------|-------------|
| **naming-analyzer** | Variable/function naming improvements |
| **domain-name-brainstormer** | Domain name ideation |
| **database-schema-designer** | Database schema design patterns |
| **design-system-starter** | Design system foundations |
| **requirements-clarity** | Requirements analysis and clarification |
| **game-changing-features** | Feature ideation and prioritization |

#### Tool Integrations

| Skill | Description |
|-------|-------------|
| **datadog-cli** | Datadog CLI operations |
| **gemini** | Google Gemini API integration |
| **perplexity** | Perplexity AI integration |
| **mui** | Material UI component patterns |
| **gepetto** | AI orchestration patterns |
| **web-to-markdown** | Web content to markdown conversion |

## Rules

Rules are framework-specific conventions that apply to matching file paths. They're automatically loaded when working with relevant files.

### Angular Rules

**Location:** `rules/angular.md`

**Applies to:** `src/main/webapp/app/**/*`

Key conventions enforced:

```typescript
// Standalone components (default in Angular 18+)
@Component({
  selector: 'app-example',
  // standalone: true is NOT needed - it's the default
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `...`
})

// Use input() and output() functions
readonly item = input<ItemDTO | null>(null);
readonly submitted = output<ItemDTO>();

// Use inject() for DI
private service = inject(DataService);

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

### Available Commands

#### Git & Version Control

| Command | Description |
|---------|-------------|
| `/git-commit-push` | Create organized git commits with conventional commits and push |
| `/sync-branch` | Sync feature branch with latest main branch via rebase |

#### Planning & Documentation

| Command | Description |
|---------|-------------|
| `/codex-plan` | Create detailed implementation plans using structured reasoning |
| `/explain-changes-mental-model` | Build mental model of code changes in logical chunks |
| `/explain-pr-changes` | Generate comprehensive PR summaries and visualizations |
| `/sync-skills-readme` | Sync README with current skills inventory |

#### Communication

| Command | Description |
|---------|-------------|
| `/compose-email` | Draft professional emails using What-Why-How framework |
| `/viral-tweet` | Transform ideas into optimized viral posts for X |

#### Project Workflows

Located in `commands/project/`:

**Discovery Phase:**
- `/project/discovery/create-epic-discovery` - Start epic discovery process
- `/project/discovery/synthesize-discovery` - Synthesize discovery findings
- `/project/discovery/approve-synthesis` - Approve discovery synthesis

**Planning Phase:**
- `/project/planning/create-epic-plan` - Create epic-level plan
- `/project/planning/create-implementation-plan` - Create detailed implementation plan

**Execution Phase:**
- `/project/execution/execute-ticket` - Execute a ticket/task
- `/project/execution/complete-ticket` - Mark ticket as complete

**Retrospectives:**
- `/project/retrospectives/complete-sprint` - Complete sprint retrospective
- `/project/retrospectives/complete-epic` - Complete epic retrospective

### Command Example: git-commit-push

**Invocation:** `/git-commit-push`

**What it does:**
1. Reviews current git status and diff
2. Checks recent commit history for style consistency
3. Creates logical, descriptive commits with conventional commit prefixes
4. Pushes all commits to remote

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

Hooks intercept tool calls and can modify, allow, or block them. They provide safety mechanisms, workflow automation, and external notifications.

All hooks log to `~/.claude/hooks-logs/YYYY-MM-DD.jsonl` for debugging and auditing.

### Pre-Tool-Use Hooks

These hooks run **before** a tool executes and can block dangerous operations.

#### block-dangerous-commands.js

**Location:** `hooks/pre-tool-use/block-dangerous-commands.js`

**Matcher:** `Bash`

**Purpose:** Blocks dangerous shell commands before execution

**Safety Levels:**
| Level | Blocks |
|-------|--------|
| `critical` | rm -rf ~, dd to disk, fork bombs, mkfs |
| `high` | + force push main, git reset --hard, chmod 777, secrets exposure |
| `strict` | + any force push, sudo rm, docker prune |

**Blocked Patterns (examples):**
```bash
rm -rf ~/                    # 🚨 BLOCKED: rm targeting home directory
git push --force main        # ⛔ BLOCKED: force push to main/master
curl ... | sh                # ⛔ BLOCKED: piping URL to shell (RCE risk)
chmod 777 file               # ⛔ BLOCKED: chmod 777 is a security risk
```

---

#### protect-secrets.js

**Location:** `hooks/pre-tool-use/protect-secrets.js`

**Matcher:** `Read|Edit|Write|Bash`

**Purpose:** Prevents reading, modifying, or exfiltrating sensitive files

**Protected Files:**
| Level | Files |
|-------|-------|
| `critical` | `.env`, `.ssh/id_*`, `.aws/credentials`, `.kube/config`, `*.pem`, `*.key` |
| `high` | `credentials.json`, `secrets.yaml`, service accounts, `.netrc`, `.npmrc` |
| `strict` | `database.yml`, `.gitconfig`, `.curlrc` |

**Blocked Operations:**
```bash
cat .env                      # 🔐 BLOCKED: .env file contains secrets
scp id_rsa user@host:         # 🛡️ BLOCKED: Copying private key
curl -d @.env http://...      # 🛡️ BLOCKED: Uploading secrets via curl
```

**Allowlist:** Template files like `.env.example`, `.env.template` are always allowed.

---

#### rm_to_mv_hook.sh (Legacy)

**Location:** `hooks/rm_to_mv_hook.sh`

**Matcher:** `Bash`

**Purpose:** Transforms `rm` commands to `mv` for safe file deletion

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

---

### Post-Tool-Use Hooks

These hooks run **after** a tool executes successfully.

#### auto-stage.js

**Location:** `hooks/post-tool-use/auto-stage.js`

**Matcher:** `Edit|Write`

**Purpose:** Automatically stages files after Claude modifies them

**Benefits:**
- `git status` shows exactly what Claude modified
- Easy to review changes before committing
- No manual staging needed

**Behavior:**
- Only stages files in git repositories
- Relies on `.gitignore` to exclude sensitive files
- Silent failures (non-blocking)

---

### Notification Hooks

These hooks send external notifications when Claude needs attention.

#### notify-permission.js

**Location:** `hooks/notification/notify-permission.js`

**Matcher:** `permission_prompt|idle_prompt|elicitation_dialog`

**Purpose:** Sends Slack alerts when Claude needs user input

**Notification Types:**
| Type | Emoji | When |
|------|-------|------|
| `permission_prompt` | 🔐 | Claude needs permission (Bash, Write, Edit) |
| `idle_prompt` | 💤 | Claude is waiting for user response |
| `elicitation_dialog` | 🔧 | Claude needs a choice (MCP, options) |

**Setup:**
```bash
export CCH_SLA_WEBHOOK="https://hooks.slack.com/services/..."
```

**Slack Message Format:**
- Header with notification type and project name
- Session ID for context
- Message details and working directory
- Timestamp

---

### Utilities

#### event-logger.py

**Location:** `hooks/utils/event-logger.py`

**Purpose:** Debug utility for inspecting hook event payloads

**Usage:** When building custom hooks, add this to any event to see the exact data structure:

```json
{
  "hooks": {
    "PreToolUse": [{"hooks": [{"type": "command", "command": "python /path/to/event-logger.py"}]}]
  }
}
```

**Supported Events (13 total):**
`SessionStart`, `SessionEnd`, `UserPromptSubmit`, `PreToolUse`, `PostToolUse`, `PostToolUseFailure`, `PermissionRequest`, `SubagentStart`, `SubagentStop`, `Stop`, `PreCompact`, `Setup`, `Notification`

**View logs:**
```bash
# Today's events
cat ~/.claude/hooks-logs/$(date +%Y-%m-%d).jsonl | jq

# Live tail
tail -f ~/.claude/hooks-logs/$(date +%Y-%m-%d).jsonl | jq

# Filter by event type
cat ~/.claude/hooks-logs/*.jsonl | jq 'select(.hook_event_name=="PreToolUse")'
```

---

### Hook Tests

Unit tests for all hooks are in `hooks/tests/`:

```
hooks/tests/
├── pre-tool-use/
│   ├── block-dangerous-commands.test.js
│   └── protect-secrets.test.js
├── post-tool-use/
│   └── auto-stage.test.js
└── notification/
    └── notify-permission.test.js
```

Run tests with Node.js test runner or your preferred test framework.

## Configuration Files

### plugin.json

The plugin manifest defining metadata and entry points:

```json
{
  "name": "claude-code-plugin",
  "version": "1.0.0",
  "description": "Comprehensive Claude Code plugin with agents, skills, hooks, and commands",
  "author": {
    "name": "Stephan Janssen",
    "url": "https://github.com/stephanj"
  },
  "keywords": ["claude-code", "agents", "skills", "hooks", "development"],
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
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          { "type": "command", "command": "node /path/to/hooks/pre-tool-use/block-dangerous-commands.js" }
        ]
      },
      {
        "matcher": "Read|Edit|Write|Bash",
        "hooks": [
          { "type": "command", "command": "node /path/to/hooks/pre-tool-use/protect-secrets.js" }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          { "type": "command", "command": "node /path/to/hooks/post-tool-use/auto-stage.js" }
        ]
      }
    ],
    "Notification": [
      {
        "matcher": "permission_prompt|idle_prompt|elicitation_dialog",
        "hooks": [
          { "type": "command", "command": "node /path/to/hooks/notification/notify-permission.js" }
        ]
      }
    ]
  }
}
```

**Permissions:** Pre-allows `mise` commands without prompts

**Hooks:**
- **PreToolUse:** Blocks dangerous commands and protects secrets before execution
- **PostToolUse:** Auto-stages modified files for git tracking
- **Notification:** Sends Slack alerts when Claude needs attention

### settings.local.json

Local developer overrides (should be gitignored). Use this for:
- Additional permissions for your workflow
- Disabling hooks during debugging
- Custom tool configurations

## Usage Examples

### Invoking an Agent

Ask Claude Code to use a specific agent:

```
Use the java-architect agent to design a domain model for user management
```

```
Ask the angular-architect to create a form with validation
```

```
Have the test-automator write integration tests for the UserController
```

### Running Commands

```
/git-commit-push
```

### Using Skills

Skills are typically loaded automatically based on context, but you can reference them:

```
Using the react-expert skill, implement a dashboard component
```

```
Apply kubernetes-specialist patterns to deploy this service
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
3. Reference WCAG guidelines for compliance

**Deploying to Kubernetes:**
1. Use `devops-engineer` for CI/CD setup
2. Use `kubernetes-specialist` for manifests and Helm charts
3. Use `terraform-engineer` for infrastructure as code

## Contributing

1. Fork the repository
2. Create a feature branch
3. Follow the conventional commits format
4. Ensure all agents and skills are properly documented
5. Submit a pull request

## License

MIT License - see [LICENSE](LICENSE) for details.

---

**Created by [Stephan Janssen](https://github.com/stephanj)**
