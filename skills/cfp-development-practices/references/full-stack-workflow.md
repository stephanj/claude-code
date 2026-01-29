# Full-Stack Feature Workflow

## Overview

When adding a new feature to the CFP application, follow this systematic approach to ensure consistency across backend and frontend.

## Backend Implementation

### Step 1: Database Migration (if needed)

**Location:** `src/main/resources/config/liquibase/changelog/`

**File naming:** `YYYYMMDDHHMMSS_description.xml`

```xml
<?xml version="1.0" encoding="utf-8" ?>
<databaseChangeLog
  xmlns="http://www.liquibase.org/xml/ns/dbchangelog"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.liquibase.org/xml/ns/dbchangelog
        http://www.liquibase.org/xml/ns/dbchangelog/dbchangelog-latest.xsd"
>
  <changeSet id="20240115120000-1" author="developer">
    <addColumn tableName="proposal">
      <column name="draft_saved_at" type="timestamp" />
    </addColumn>
  </changeSet>
</databaseChangeLog>
```

**Register in:** `change-log-master.xml`

### Step 2: Entity Update

**Location:** `src/main/java/com/devoxx/cfp/domain/`

```java
@Entity
@Table(name = "proposal")
public class Proposal {

  // Add new field
  @Column(name = "draft_saved_at")
  private Instant draftSavedAt;

  // Getters and setters
}
```

### Step 3: DTOs

**Location:** `src/main/java/com/devoxx/cfp/web/rest/dto/`

```java
// Request DTO
public record SaveDraftRequest(@NotBlank String title, String description) {}

// Response DTO
public record ProposalDTO(Long id, String title, String description, Instant draftSavedAt) {
  public static ProposalDTO from(Proposal entity) {
    return new ProposalDTO(entity.getId(), entity.getTitle(), entity.getDescription(), entity.getDraftSavedAt());
  }
}
```

### Step 4: Service Layer

**Location:** `src/main/java/com/devoxx/cfp/service/`

```java
@Service
@Transactional(readOnly = true)
public class ProposalService {

  private final ProposalRepository repository;

  @Transactional
  public ProposalDTO saveDraft(Long id, SaveDraftRequest request) {
    Proposal proposal = repository.findById(id).orElseThrow(() -> new ProposalNotFoundException(id));

    proposal.setTitle(request.title());
    proposal.setDescription(request.description());
    proposal.setDraftSavedAt(Instant.now());

    return ProposalDTO.from(repository.save(proposal));
  }
}
```

### Step 5: Controller Endpoint

**Location:** `src/main/java/com/devoxx/cfp/web/rest/`

```java
@RestController
@RequestMapping("/api/proposals")
public class ProposalController {

  private final ProposalService service;

  @PatchMapping("/{id}/draft")
  public ResponseEntity<ProposalDTO> saveDraft(@PathVariable Long id, @Valid @RequestBody SaveDraftRequest request) {
    return ResponseEntity.ok(service.saveDraft(id, request));
  }
}
```

## Frontend Implementation

### Step 1: TypeScript Model

**Location:** `src/main/webapp/app/shared/model/`

```typescript
export interface Proposal {
  id: number;
  title: string;
  description: string;
  draftSavedAt?: Date;
}

export interface SaveDraftRequest {
  title: string;
  description: string;
}
```

### Step 2: Service Method

**Location:** `src/main/webapp/app/callforpaper/`

```typescript
@Injectable({ providedIn: 'root' })
export class ProposalService {
  private http = inject(HttpClient);

  saveDraft(id: number, request: SaveDraftRequest): Observable<Proposal> {
    return this.http.patch<Proposal>(`/api/proposals/${id}/draft`, request);
  }
}
```

### Step 3: Component

**Location:** `src/main/webapp/app/callforpaper/`

```typescript
@Component({
  selector: 'cfp-proposal-form',
  standalone: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [ReactiveFormsModule /* ... */],
  template: `/* ... */`,
})
export class ProposalFormComponent {
  private service = inject(ProposalService);

  // Signals for state
  private savingDraft = signal(false);
  readonly isSaving = this.savingDraft.asReadonly();

  saveDraft(): void {
    this.savingDraft.set(true);
    this.service
      .saveDraft(this.proposalId, this.form.value)
      .pipe(finalize(() => this.savingDraft.set(false)))
      .subscribe({
        next: updated => this.onDraftSaved(updated),
        error: err => this.handleError(err),
      });
  }
}
```

### Step 4: Tests

**Backend Unit Test:**

```java
@Test
void saveDraft_updatesProposal() {
  // Arrange
  var request = new SaveDraftRequest("Updated Title", "Description");

  // Act
  var result = service.saveDraft(proposalId, request);

  // Assert
  assertThat(result.title()).isEqualTo("Updated Title");
  assertThat(result.draftSavedAt()).isNotNull();
}
```

**Frontend Test:**

```typescript
it('should save draft and update state', () => {
  // Arrange
  const mockResponse = { id: 1, title: 'Test', draftSavedAt: new Date() };
  httpMock.expectOne('/api/proposals/1/draft').flush(mockResponse);

  // Act
  component.saveDraft();

  // Assert
  expect(component.isSaving()).toBeFalse();
});
```

## CFP-Specific Examples

### Adding Proposal Rating

1. **DB:** Add `rating` column to `proposal` table
2. **Entity:** Add `rating` field to `Proposal`
3. **DTO:** Create `RateProposalRequest` and update `ProposalDTO`
4. **Service:** Add `rateProposal(id, rating)` method
5. **Controller:** Add `POST /api/proposals/{id}/rating`
6. **Frontend Model:** Update `Proposal` interface
7. **Frontend Service:** Add `rateProposal()` method
8. **Component:** Add rating UI with accessibility support

### Adding Speaker Photo Upload

1. **Storage:** Configure file storage (local/cloud)
2. **Entity:** Add `photoUrl` to `Speaker`
3. **DTO:** Create `UploadPhotoResponse`
4. **Service:** Add file validation and storage logic
5. **Controller:** Add `POST /api/speakers/{id}/photo` multipart endpoint
6. **Frontend:** File input with drag-drop, preview, progress indicator
7. **Accessibility:** Keyboard-accessible upload, progress announcements
