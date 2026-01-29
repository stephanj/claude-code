# Accessibility Checklist

**Standard:** WCAG 2.1 AA (required for all speaker-facing components)

## Forms

- [ ] Every input has an associated `<label>` with `for` attribute
- [ ] Validation errors use `aria-describedby` to link to error message
- [ ] Error messages use `aria-live="polite"` for dynamic announcements
- [ ] Required fields marked with `aria-required="true"`
- [ ] Form submission feedback announced to screen readers

**Pattern:**

```html
<label for="title">Proposal Title <span aria-hidden="true">*</span></label>
<input id="title" formControlName="title" aria-required="true" aria-describedby="title-error" [attr.aria-invalid]="titleHasError()" />
@if (titleHasError()) {
<div id="title-error" role="alert" aria-live="polite">{{ titleErrorMessage() }}</div>
}
```

## Keyboard Navigation

- [ ] All interactive elements focusable via Tab key
- [ ] Focus order follows logical reading order
- [ ] Focus indicator visible (minimum 3:1 contrast)
- [ ] No keyboard traps (can always Tab away)
- [ ] Escape key closes modals/dropdowns
- [ ] Enter/Space activates buttons and links

## Screen Reader Support

- [ ] Page has single `<main>` landmark
- [ ] Sections use appropriate landmarks (`<nav>`, `<aside>`, `<footer>`)
- [ ] Headings follow hierarchy (`h1` → `h2` → `h3`, no skips)
- [ ] Images have meaningful `alt` text or `alt=""`
- [ ] Icons have `aria-label` or are `aria-hidden="true"`
- [ ] Dynamic content changes announced via `aria-live`

## Progress Indicators

**Pattern:**

```html
<div role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" aria-label="Profile completion">
  <span class="sr-only">Profile 75% complete</span>
</div>
```

## Status Updates

**Pattern:**

```html
<!-- For important updates -->
<div aria-live="polite" class="sr-only">{{ statusMessage }}</div>

<!-- For urgent alerts -->
<div role="alert" aria-live="assertive">{{ errorMessage }}</div>
```

## Color and Contrast

- [ ] Text contrast minimum 4.5:1 (normal text)
- [ ] Text contrast minimum 3:1 (large text, 18px+ or 14px+ bold)
- [ ] UI component contrast minimum 3:1
- [ ] Information not conveyed by color alone
- [ ] Focus indicators have 3:1 contrast

## Rich Text Editors

- [ ] Toolbar buttons have `aria-label`
- [ ] Formatting state announced (bold, italic active)
- [ ] Keyboard shortcuts documented and functional
- [ ] Content area has `role="textbox"` and `aria-multiline="true"`

## File Uploads

- [ ] Drag-and-drop has keyboard alternative
- [ ] File input accessible via keyboard
- [ ] Upload progress announced
- [ ] Error states clearly communicated

## Testing Checklist

- [ ] Navigate entire form using only keyboard
- [ ] Test with screen reader (VoiceOver on Mac, NVDA on Windows)
- [ ] Verify color contrast with browser dev tools
- [ ] Check focus visibility in all states
- [ ] Validate heading structure with accessibility tree
