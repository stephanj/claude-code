# Test Commands Reference

## Unified Mise Interface (Recommended)

```bash
# Run all tests
mise run test

# Backend tests only
mise run test --unit        # Unit tests (fast, no Docker)
mise run test --integration # Integration tests (requires Docker)

# Frontend tests only
mise run test --frontend
mise run test --frontend --watch # Watch mode for development

# Combined with filtering
mise run test --include='Pattern*' # Filter both unit + integration
mise run test --unit --include='ProposalService*'
mise run test --integration --include='*ControllerIT'
mise run test --frontend --include='proposal'

# Coverage
mise run test --coverage # All tests with coverage report

# Clean builds
mise run test --no-cache  # Disable build cache
mise run build --no-cache # Clean build
```

## Direct Maven Commands (Alternative)

```bash
# Unit tests
mvnd test                             # All unit tests
mvnd test -Dtest=ClassName            # Specific test class
mvnd test -Dtest=ClassName#methodName # Specific test method
mvnd test -Dtest='*Service*'          # Pattern matching

# Integration tests
mvnd verify                                    # All integration tests
mvnd verify -Dit.test=ClassNameIT              # Specific integration test
mvnd verify -Dit.test='*ProposalIT,*SpeakerIT' # Multiple patterns

# Skip tests
mvnd package -DskipTests    # Skip all tests
mvnd verify -DskipUnitTests # Skip unit, run integration
```

## Direct PNPM Commands (Alternative)

```bash
# All frontend tests
pnpm test

# Specific tests
pnpm test --include='**/proposal-form.component.spec.ts'
pnpm test --include='**/proposal*.spec.ts'
pnpm test --include='**/speaker*.spec.ts'
pnpm test --include='**/*.service.spec.ts'

# Watch mode
pnpm test --watch

# Coverage
pnpm test --coverage
```

## CFP-Specific Test Examples

| Component          | Unit Test                   | Integration Test       |
| ------------------ | --------------------------- | ---------------------- |
| Proposal Service   | `ProposalServiceTest`       | `ProposalControllerIT` |
| Speaker Profile    | `SpeakerProfileServiceTest` | `SpeakerControllerIT`  |
| Authentication     | `AuthenticationServiceTest` | `AuthenticationIT`     |
| Database Migration | -                           | `DatabaseMigrationIT`  |

## Test Naming Conventions

- **Backend Unit:** `*Test.java` (e.g., `ProposalServiceTest.java`)
- **Backend Integration:** `*IT.java` (e.g., `ProposalControllerIT.java`)
- **Frontend:** `*.spec.ts` (e.g., `proposal-form.component.spec.ts`)
