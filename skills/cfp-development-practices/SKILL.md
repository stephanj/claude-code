---
name: cfp-development-practices
description: CFP project development workflow, domain patterns, and quality practices. Use when planning features, implementing full-stack workflows, reviewing code, or needing test strategies. Covers planning approach with phases/tasks, memory workflow, commit conventions, proposal/speaker domain patterns, backend-frontend integration, test organization, accessibility requirements, and security practices. Complements java-best-practices and typescript-best-practices skills.
---

# CFP Development Practices

This skill covers project-level development practices for the Devoxx Call for Papers application. For language-specific patterns, see `java-best-practices` and `typescript-best-practices` skills.

## Workflow and Planning

### Plan Structure

Organize implementation plans into numbered phases with specific tasks:

```
## Phase 1: Setup
### Task 1.1: Create database migration
### Task 1.2: Add entity and repository

## Phase 2: Backend Implementation
### Task 2.1: Create DTOs
### Task 2.2: Implement service layer
```

**Checklist format:**

- `- [ ]` for pending tasks
- `- [x]` for completed tasks

**Plan location:** `docs/plans/<feature-name>/`

**Success criteria:** Every plan ends with measurable completion criteria.

### Task Tracking

When working through a plan:

1. Mark task as in-progress before starting
2. Complete the task fully before marking done
3. Update the plan file as you progress
4. Tasks with tests are not complete until tests pass

### Memory Workflow

**Before implementing:** Search memory for related concepts

```
search_nodes({"query": "proposal management"})
search_nodes({"query": "speaker profile"})
search_nodes({"query": "authentication"})
```

**After implementing:** Update memory with new knowledge

- Create entities for new components/features
- Add atomic observations (max 15 words)
- Link related entities with relations

**Entity types:** Components, Features, Patterns, Practices, Technologies

### Conventional Commits

Use these prefixes for commit messages:

| Type        | Use Case                    |
| ----------- | --------------------------- |
| `feat:`     | New functionality           |
| `fix:`      | Bug fixes                   |
| `docs:`     | Documentation only          |
| `style:`    | Formatting, no logic change |
| `refactor:` | Code restructuring          |
| `test:`     | Test additions/changes      |
| `chore:`    | Maintenance, dependencies   |

**Format:** `<type>(scope): <description>`

**Example:** `feat(proposal): add draft auto-save functionality`

## CFP Domain Patterns

### Technology Decision Tree

```
New Feature?
├── Backend API → Java + Spring Boot + PostgreSQL
├── Frontend UI → Angular + PrimeNG + TypeScript
├── Database Change → Liquibase migration
├── Auth Feature → Firebase integration
└── AI Features → LangChain4j integration
```

### Full-Stack Feature Workflow

**Backend Steps:**

1. **DTO** → Create request/response records in `web/rest/dto/`
2. **Controller** → Add endpoint in `web/rest/`
3. **Service** → Business logic with `@Transactional`
4. **Repository** → Data access in `repository/`
5. **Database** → Liquibase changelog if schema changes

**Frontend Steps:**

1. **Model** → TypeScript interfaces
2. **Service** → HTTP client methods
3. **Component** → Standalone with OnPush strategy
4. **Routing** → Route configuration
5. **Tests** → Component and service specs

See `references/full-stack-workflow.md` for detailed examples.

### Key Domain Flows

**Proposal Submission:**

- Speaker creates/edits proposal via Angular form
- Backend validates and persists via `ProposalService`
- Status transitions: DRAFT → SUBMITTED → UNDER_REVIEW → ACCEPTED/REJECTED
- Draft auto-save with debouncing

**Speaker Profile:**

- Firebase authentication for login
- Profile data in PostgreSQL (`SpeakerEntity`)
- Photo upload to storage with validation
- Bio/company/social links management

**Admin Review:**

- Paginated proposal list with filters
- Bulk actions (accept, reject, request changes)
- Rating and feedback system
- Export capabilities

### API Integration Patterns

**Firebase Auth Token Handling:**

```typescript
// Frontend: Attach token to requests
const token = await auth.currentUser?.getIdToken();
headers.set('Authorization', `Bearer ${token}`);
```

**Pagination Pattern:**

```java
// Backend: Return Page<DTO> for lists
@GetMapping
ResponseEntity<Page<ProposalDTO>> getAll(Pageable pageable) {
  return ResponseEntity.ok(service.findAll(pageable));
}
```

**Error Response Pattern:**

```java
// Centralized error handling via @ControllerAdvice
@ExceptionHandler(ProposalNotFoundException.class)
ResponseEntity<ErrorResponse> handleNotFound(ProposalNotFoundException ex) {
  return ResponseEntity.status(NOT_FOUND).body(new ErrorResponse(ex.getMessage()));
}
```

## Quality and Testing

### Test Organization

| Test Type           | Naming       | Command                       |
| ------------------- | ------------ | ----------------------------- |
| Backend Unit        | `*Test.java` | `mise run test --unit`        |
| Backend Integration | `*IT.java`   | `mise run test --integration` |
| Frontend            | `*.spec.ts`  | `mise run test --frontend`    |

**Filtering:**

```bash
mise run test --unit --include='ProposalService*'
mise run test --integration --include='*ControllerIT'
mise run test --frontend --include='proposal'
```

**Full command reference:** See `references/test-commands.md`

### Test Patterns

**Backend Unit Tests:**

- Use JUnit 5 with `@ParameterizedTest` for multiple inputs
- AssertJ for fluent assertions
- Mock external dependencies only

**Integration Tests:**

- `@SpringBootTest(webEnvironment = RANDOM_PORT)`
- Testcontainers for PostgreSQL
- Test full request/response cycle

**Frontend Tests:**

- Arrange-Act-Assert pattern
- Test component behavior, not implementation
- Mock HTTP calls with `HttpClientTestingModule`

### Accessibility Requirements

**WCAG 2.1 AA is required for all speaker-facing components.**

**Core Requirements:**

1. **Semantic HTML** → Use `button`, `nav`, `main`, `section`, proper heading hierarchy
2. **Keyboard Navigation** → All interactive elements keyboard-accessible
3. **Screen Reader Support** → ARIA labels, live regions, text alternatives

**Form Pattern:**

```html
<label for="title">Proposal Title</label>
<input id="title" aria-describedby="title-error" />
<div id="title-error" aria-live="polite">{{ validationMessage }}</div>
```

**Full checklist:** See `references/accessibility-checklist.md`

### Security Practices

**Input Validation:**

- Jakarta Validation on all DTOs (`@NotBlank`, `@Valid`, `@Size`)
- Sanitize user input before storage
- Validate file uploads (type, size, content)

**XSS Prevention:**

- Use Angular's built-in sanitization
- Avoid `innerHTML` for user content
- Escape dynamic content in templates

**Secrets Management:**

- Store in `.env` and `secrets/` (never commit)
- Use `@ConfigurationProperties` for typed config
- Validate required secrets at startup

**Logging Guidelines:**

- Use SLF4J for structured logging
- Never log sensitive data (emails, passwords, tokens)
- Include context (speakerId, proposalId) for traceability

## Quick References

### File Locations

| Category    | Backend                                          | Frontend                                    |
| ----------- | ------------------------------------------------ | ------------------------------------------- |
| Controllers | `src/main/java/.../web/rest/`                    | -                                           |
| Services    | `src/main/java/.../service/`                     | `src/main/webapp/app/**/`                   |
| Entities    | `src/main/java/.../domain/`                      | -                                           |
| Components  | -                                                | `src/main/webapp/app/callforpaper/`         |
| Admin       | -                                                | `src/main/webapp/app/callforpaper/admin-*/` |
| Config      | `src/main/resources/application.yml`             | `src/main/webapp/environments/`             |
| Migrations  | `src/main/resources/config/liquibase/changelog/` | -                                           |

### Key Commands

```bash
# Environment
mise run env:setup # Setup environment
mise run dev:start # Start dev servers

# Testing
mise run test               # All tests
mise run test --unit        # Backend unit (fast, no Docker)
mise run test --integration # Backend integration
mise run test --frontend    # Frontend tests

# Code Quality
mise run code:fmt  # Format code
mise run code:lint # Lint code

# Database
mise run dev:db:sql                  # Interactive psql
mise run dev:db:sql -- -c "SELECT 1" # Run query
```

### Debugging Patterns

**Backend:**

```bash
# Enable debug logging
-Dlogging.level.com.devoxx.cfp=DEBUG

# SQL logging
-Dlogging.level.org.hibernate.SQL=DEBUG

# Remote debugging
-Dagentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005
```

**Frontend:**

```bash
# Source maps for debugging
ng serve --source-map

# Verbose build output
ng build --verbose
```

**Common Issues:**

- Proposal submission fails → Check Firebase token validity
- Speaker profile errors → Verify file upload permissions
- Admin pagination issues → Check query parameters
- Database errors → Validate Liquibase changelog syntax
