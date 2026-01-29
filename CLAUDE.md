# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Claude Code Plugin** for the Devoxx Call-for-Papers (CFP) application. It provides 12 specialized AI agents, development skills, rules, and commands for full-stack development with Java 25, Spring Boot 3, Angular 18, PostgreSQL, Firebase, and LangChain4j.

This repository contains plugin configuration files, not the CFP application source code itself.

## Repository Structure

```
├── agents/           # 12 specialized AI agent definitions
├── skills/           # Development practice skills with reference docs
├── rules/            # Project-specific coding rules (e.g., Angular patterns)
├── commands/         # Custom Claude Code commands (e.g., git-commit-push)
├── hooks/            # Safety hooks (rm → mv interceptor)
├── plugin.json       # Plugin manifest
└── settings.json     # Plugin settings and permissions
```

## Available Agents

| Agent | Focus Area |
|-------|------------|
| java-architect | Clean architecture, domain modeling, SOLID, Java 25 features |
| spring-boot-engineer | REST APIs, Spring configuration, Firebase integration |
| angular-architect | Components, signals, reactive forms, PrimeNG, accessibility |
| firebase-auth-specialist | Token validation, auth flows, Spring Security integration |
| langchain4j-ai-engineer | AI services, RAG patterns, embeddings |
| postgres-pro | SQL optimization, Liquibase migrations, schema design |
| test-automator | JUnit 5, TestContainers, Angular testing |
| code-reviewer | Quality, security, conventions enforcement |
| typescript-pro | Type safety, reactive patterns, signals |
| security-auditor | Vulnerability detection, secure patterns |
| ui-ux-designer | UI components, design systems, accessibility |
| accessibility-tester | WCAG AA compliance, keyboard nav, screen readers |

## Skills

- **cfp-development-practices** - Full-stack workflow, domain patterns, test strategies, accessibility requirements
- **java-best-practices** - Type-first development, records, sealed classes, error handling
- **typescript-best-practices** - Discriminated unions, branded types, Zod validation

## Key CFP Development Commands

```bash
# Environment & Dev
mise run env:setup           # Initial environment setup
mise run dev:start           # Start dev servers

# Testing
mise run test                # All tests
mise run test --unit         # Backend unit tests (fast, no Docker)
mise run test --integration  # Backend integration tests (Docker/TestContainers)
mise run test --frontend     # Angular tests
mise run test --include='Pattern*'  # Filter by pattern

# Code Quality
mise run code:fmt            # Format code
mise run code:lint           # Lint check

# Database
mise run dev:db:sql          # Interactive psql session
```

## CFP Tech Stack Reference

**Backend:** Java 25, Spring Boot 3, Spring Security, Firebase Admin SDK, LangChain4j, PostgreSQL, Liquibase
**Frontend:** Angular 18 (standalone components, signals), TypeScript strict, PrimeNG, Firebase JS SDK
**Testing:** JUnit 5, TestContainers, AssertJ (backend); Angular testing utilities (frontend)

## CFP Directory Conventions

| Layer | Backend Path | Frontend Path |
|-------|--------------|---------------|
| Controllers/Components | `src/main/java/.../web/rest/` | `src/main/webapp/app/callforpaper/` |
| Services | `src/main/java/.../service/` | `src/main/webapp/app/**/` |
| Entities/Models | `src/main/java/.../domain/` | `src/main/webapp/app/shared/model/` |
| DTOs | `src/main/java/.../web/rest/dto/` | - |
| Config | `src/main/resources/application.yml` | `src/main/webapp/environments/` |
| DB Migrations | `src/main/resources/config/liquibase/changelog/` | - |

## Commit Convention

Use conventional commits: `<type>(scope): description`

Types: `feat:`, `fix:`, `docs:`, `style:`, `refactor:`, `test:`, `chore:`

## Critical Angular Rules (from rules/angular.md)

- Standalone components only (no NgModules), don't set `standalone: true` (it's default in Angular v20+)
- Use `input()` and `output()` functions, not decorators
- Use signals for state, `computed()` for derived state
- Use native control flow (`@if`, `@for`, `@switch`)
- Set `changeDetection: ChangeDetectionStrategy.OnPush`
- Use `host` object instead of `@HostBinding`/`@HostListener`
- WCAG AA accessibility required - must pass AXE checks

## Critical Java Patterns

- Constructor injection with `final` fields (no `@Autowired`)
- Records for DTOs
- `@Transactional(readOnly = true)` default, override with `@Transactional` for writes
- Sealed classes for domain events with exhaustive pattern matching
