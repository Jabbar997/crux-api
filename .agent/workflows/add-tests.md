---
description: Add tests to existing code
---

# Add Tests Workflow

## 1. Identify Test Gaps
- Run coverage report: `npm run test:coverage`
- Identify untested files/functions
- Prioritize critical business logic

## 2. Unit Tests
Location: `backend/src/modules/[module]/__tests__/[file].test.ts`

Structure:
```typescript
describe('[Module] - [Function/Class]', () => {
  describe('[specific function]', () => {
    it('should [expected behavior] when [condition]', () => {
      // Arrange
      // Act
      // Assert
    });
  });
});
```

## 3. Integration Tests
Location: `backend/src/modules/[module]/__tests__/[module].integration.test.ts`

Test:
- API endpoints end-to-end
- Database operations
- Authentication/Authorization
- Error responses

## 4. E2E Tests (Future)
- Will use Playwright/Cypress
- Test complete user flows
- Test on real browser

## 5. Run Tests
```bash
npm test                    # Run all
npm test -- --coverage      # With coverage
npm test -- [module]        # Specific module
```

Target: 80%+ coverage
