---
name: java-best-practices
description: Provides Java patterns for type-first development with records, sealed classes, value objects, and exception handling. Use when reading or writing Java files.
---

# Java Best Practices

## Type-First Development

Types define the contract before implementation. Follow this workflow:

1. **Define data models** - records, sealed classes, and interfaces first
2. **Define method signatures** - parameter types, return types, and exceptions
3. **Implement to satisfy types** - let the compiler guide completeness
4. **Validate at boundaries** - runtime checks where data enters the system

### Make Illegal States Unrepresentable

Use Java's type system to prevent invalid states at compile time.

**Records for immutable data:**

```java
// Define the data model first
public record User(UserId id, String email, String name, Instant createdAt) {}

public record CreateUserRequest(String email, String name) {}

// Records are immutable by default - no accidental mutation
```

**Sealed classes for discriminated unions:**

```java
// Good: only valid states possible
public sealed interface RequestState<T> permits Idle, Loading, Success, Failure {
  record Idle<T>() implements RequestState<T> {}

  record Loading<T>() implements RequestState<T> {}

  record Success<T>(T data) implements RequestState<T> {}

  record Failure<T>(Exception error) implements RequestState<T> {}
}

// Exhaustive pattern matching
public String handleState(RequestState<String> state) {
  return switch (state) {
    case Idle<String> idle -> "idle";
    case Loading<String> loading -> "loading...";
    case Success<String>(var data) -> "data: " + data;
    case Failure<String>(var error) -> "error: " + error.getMessage();
  };
}

// Bad: allows invalid combinations
public class RequestState<T> {

  private boolean loading;
  private T data; // null when loading?
  private Exception error; // set with data?
}
```

**Value objects for domain primitives:**

```java
// CFP Example: Distinct types prevent mixing up IDs
public record ProposalId(Long value) {
  public ProposalId {
    if (value == null || value <= 0) {
      throw new IllegalArgumentException("ProposalId must be positive");
    }
  }
}

public record SpeakerId(Long value) {
  public SpeakerId {
    if (value == null || value <= 0) {
      throw new IllegalArgumentException("SpeakerId must be positive");
    }
  }
}

// Compiler prevents passing SpeakerId where ProposalId expected
public Proposal getProposal(ProposalId id) {
  // implementation
}
```

**Enums with behavior:**

```java
public enum Status {
  ACTIVE("processing"),
  INACTIVE("skipped"),
  PENDING("waiting");

  private final String action;

  Status(String action) {
    this.action = action;
  }

  public String getAction() {
    return action;
  }
}

// Exhaustive switch with pattern matching
public String processStatus(Status status) {
  return switch (status) {
    case ACTIVE -> "processing";
    case INACTIVE -> "skipped";
    case PENDING -> "waiting";
    // Compiler warns if case is missing
  };
}
```

**Builder pattern with required fields:**

```java
public record ServerConfig(int port, String host, Duration timeout, boolean tlsEnabled) {
  public static Builder builder(String host) {
    return new Builder(host);
  }

  public static final class Builder {

    private final String host; // required
    private int port = 8080;
    private Duration timeout = Duration.ofSeconds(30);
    private boolean tlsEnabled = false;

    private Builder(String host) {
      this.host = Objects.requireNonNull(host, "host is required");
    }

    public Builder port(int port) {
      this.port = port;
      return this;
    }

    public Builder timeout(Duration timeout) {
      this.timeout = timeout;
      return this;
    }

    public Builder tlsEnabled(boolean tlsEnabled) {
      this.tlsEnabled = tlsEnabled;
      return this;
    }

    public ServerConfig build() {
      return new ServerConfig(port, host, timeout, tlsEnabled);
    }
  }
}

// Usage: ServerConfig.builder("localhost").port(3000).build()
```

**Optional for nullable values:**

```java
// Good: explicit nullability
public Optional<User> findById(UserId id) {
    // return Optional.empty() if not found
}

// Caller must handle absence
findById(id)
    .map(User::name)
    .orElse("Unknown");

// Bad: null return
public User findById(UserId id) {
    return null; // NPE waiting to happen
}
```

## Module Structure

Prefer smaller, focused classes: one responsibility per class. Split when a class handles multiple concerns or exceeds ~300 lines. Keep tests in `src/test/java` mirroring the source structure. Package boundaries define the API; use package-private visibility for implementation details.

## Functional Patterns

- Prefer `final` for local variables and fields; use immutable collections (`List.of()`, `Set.of()`, `Map.of()`).
- Use Stream API for transformations (`map`, `filter`, `reduce`); avoid mutating state in lambdas.
- Write pure methods for business logic; isolate side effects at service boundaries.
- Avoid mutable shared state; pass data explicitly rather than relying on field mutation.

```java
// Good: functional pipeline
public List<String> getActiveUserEmails(List<User> users) {
  return users.stream().filter(User::isActive).map(User::email).sorted().toList(); // immutable list
}

// Bad: imperative mutation
public List<String> getActiveUserEmails(List<User> users) {
  List<String> result = new ArrayList<>();
  for (User user : users) {
    if (user.isActive()) {
      result.add(user.email());
    }
  }
  Collections.sort(result);
  return result;
}
```

## Error Handling Guidelines

- Throw descriptive exceptions for unsupported cases; every code path returns a value or throws. Explicit failures are debuggable.
- Wrap exceptions with context; catching requires re-throwing with cause or returning a meaningful result. Swallowed exceptions hide root causes.
- Handle edge cases explicitly: empty collections, null inputs, boundary values. Include default branches in switch statements.
- Prefer unchecked exceptions for programming errors; use checked exceptions for recoverable conditions at API boundaries.
- Use try-with-resources for I/O; prefer `java.nio` and explicit charsets. Resource leaks cause production issues.
- Add or update unit tests when touching logic; prefer minimal repros that isolate the failure.

## Examples

Explicit failure for unimplemented logic:

```java
public Widget buildWidget(String widgetType) {
  throw new UnsupportedOperationException("buildWidget not implemented for type: " + widgetType);
}
```

Wrap exceptions with context to preserve the chain:

```java
public Config loadConfig(Path path) {
  try {
    String content = Files.readString(path, StandardCharsets.UTF_8);
    return parseConfig(content);
  } catch (IOException e) {
    throw new ConfigLoadException("failed to load config from: " + path, e);
  }
}
```

Exhaustive switch with pattern matching:

```java
public String processStatus(String status) {
  return switch (status) {
    case "active" -> "processing";
    case "inactive" -> "skipped";
    case null, default -> throw new IllegalArgumentException("unhandled status: " + status);
  };
}
```

Structured logging with SLF4J:

```java
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class WidgetService {

  private static final Logger log = LoggerFactory.getLogger(WidgetService.class);

  public Widget createWidget(String name) {
    log.debug("creating widget: {}", name);
    Widget widget = new Widget(UUID.randomUUID(), name);
    log.debug("created widget id={}", widget.id());
    return widget;
  }
}
```

## Exception Handling

- Define specific exception types for distinct failure modes; avoid generic `Exception` throws.
- Always preserve the cause chain when wrapping exceptions.
- Never catch `Throwable` or `Error` except at the outermost boundary.

Custom exception hierarchy:

```java
public sealed class ConfigException extends RuntimeException permits ConfigNotFoundException, ConfigParseException {

  public ConfigException(String message) {
    super(message);
  }

  public ConfigException(String message, Throwable cause) {
    super(message, cause);
  }
}

public final class ConfigNotFoundException extends ConfigException {

  public ConfigNotFoundException(Path path) {
    super("config file not found: " + path);
  }
}

public final class ConfigParseException extends ConfigException {

  public ConfigParseException(String message, Throwable cause) {
    super(message, cause);
  }
}
```

## Configuration

- Load config from environment variables at startup; validate required values before use. Missing config should fail immediately.
- Define a config record as single source of truth; avoid `System.getenv` scattered throughout code.
- Use sensible defaults for development; require explicit values for production secrets.

### Examples

Typed config with record:

```java
public record AppConfig(
    int port,
    String databaseUrl,
    String apiKey,
    String env
) {
    public AppConfig {
        if (databaseUrl == null || databaseUrl.isBlank()) {
            throw new IllegalArgumentException("DATABASE_URL is required");
        }
        if (apiKey == null || apiKey.isBlank()) {
            throw new IllegalArgumentException("API_KEY is required");
        }
    }

    public static AppConfig fromEnvironment() {
        return new AppConfig(
            parsePort(System.getenv("PORT"), 3000),
            System.getenv("DATABASE_URL"),
            System.getenv("API_KEY"),
            getOrDefault(System.getenv("ENV"), "development")
        );
    }

    private static int parsePort(String value, int defaultPort) {
        if (value == null || value.isBlank()) {
            return defaultPort;
        }
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("invalid PORT: " + value, e);
        }
    }

    private static String getOrDefault(String value, String defaultValue) {
        return value != null && !value.isBlank() ? value : defaultValue;
    }
}

// Access config values (not System.getenv directly)
AppConfig config = AppConfig.fromEnvironment();
server.start(config.port());
dataSource.connect(config.databaseUrl());
```

## Optional: Modern Java Features (Java 21+)

### Pattern Matching for switch

```java
// Type-based switching with exhaustive handling
public String describe(Object obj) {
  return switch (obj) {
    case String s -> "string: " + s;
    case Integer i -> "integer: " + i;
    case List<?> list -> "list of size: " + list.size();
    case null -> "null value";
    default -> "unknown: " + obj.getClass();
  };
}
```

### Record Patterns

```java
// Destructure nested records
public record Point(int x, int y) {}

public record Line(Point start, Point end) {}

public boolean isHorizontal(Line line) {
  return switch (line) {
    case Line(Point(var x1, var y1), Point(var x2, var y2)) when y1 == y2 -> true;
    default -> false;
  };
}
```

### Virtual Threads

```java
// Lightweight threads for I/O-bound workloads
try (var executor = Executors.newVirtualThreadPerTaskExecutor()) {
    List<Future<Result>> futures = tasks.stream()
        .map(task -> executor.submit(() -> processTask(task)))
        .toList();

    for (Future<Result> future : futures) {
        handleResult(future.get());
    }
}
```

### Structured Concurrency (Preview)

```java
try (var scope = new StructuredTaskScope.ShutdownOnFailure()) {
    Subtask<User> user = scope.fork(() -> fetchUser(userId));
    Subtask<Order> order = scope.fork(() -> fetchOrder(orderId));

    scope.join().throwIfFailed();

    return new UserOrder(user.get(), order.get());
}
```

## Optional: JSpecify for Nullability

For compile-time null safety, annotate packages with [JSpecify](https://jspecify.dev/):

```java
// package-info.java
@NullMarked
package com.example.myapp;

import org.jspecify.annotations.NullMarked;
```

```java
// All parameters and return types are non-null by default
public User getUser(UserId id) {
  /* ... */
}

// Explicit nullable where needed
public @Nullable User findUser(UserId id) {
  // may return null
}
```

Configure with static analysis tools (Error Prone, NullAway, IntelliJ) to catch null violations at compile time.

## Testing

- Use JUnit 5 for tests; prefer `@ParameterizedTest` for multiple inputs.
- Keep tests focused: one behavior per test method.
- Use AssertJ for fluent, readable assertions.
- Prefer in-memory fakes over mocks when possible; mock only external boundaries.

### Examples

Parameterized test:

```java
@ParameterizedTest
@CsvSource({ "active, processing", "inactive, skipped", "pending, waiting" })
void processStatus_returnsExpectedAction(String status, String expected) {
  assertThat(processStatus(status)).isEqualTo(expected);
}
```

AssertJ assertions:

```java
@Test
void createUser_setsCreatedAt() {
  User user = userService.create(new CreateUserRequest("test@example.com", "Test"));

  assertThat(user.id()).isNotNull();
  assertThat(user.email()).isEqualTo("test@example.com");
  assertThat(user.createdAt()).isCloseTo(Instant.now(), within(1, ChronoUnit.SECONDS));
}
```

Exception testing:

```java
@Test
void getUser_throwsWhenNotFound() {
  UserId unknownId = new UserId("unknown");

  assertThatThrownBy(() -> userService.getUser(unknownId))
    .isInstanceOf(UserNotFoundException.class)
    .hasMessageContaining("unknown");
}
```
