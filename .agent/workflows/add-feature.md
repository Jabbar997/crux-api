---
description: Add a new feature to the application
---

# Add Feature Workflow

## Planning Phase:

1. **Requirements Document**
   - Write user story
   - Define acceptance criteria
   - Identify affected modules
   - Create task breakdown

2. **Design**
   - Update ERD if database changes needed
   - Design API contract
   - Design UI mockups (if frontend)
   - Identify security concerns

## Implementation Phase:

3. **Database Changes**
   - Create Prisma migration
   - Update schema
   - Add seed data for testing

4. **Backend**
   - Create/update models
   - Implement services
   - Create controllers
   - Add validation

5. **Frontend** (if applicable)
   - Create new screens/widgets
   - Implement state management (Riverpod)
   - Add navigation routes
   - Handle loading/error states

6. **Testing**
   - Write unit tests
   - Write integration tests
   - Manual testing checklist
   - Test with Arabic data
   - Test RTL layouts

7. **Documentation**
   - Update API docs
   - Update user guide
   - Add code comments
   - Update README if needed

## Review Phase:

8. **Code Review Checklist**
   - [ ] All tests pass
   - [ ] No console.logs left
   - [ ] No hardcoded values
   - [ ] Error handling complete
   - [ ] Arabic translations added
   - [ ] Security reviewed
   - [ ] Performance acceptable

9. **Deployment Prep**
   - Update environment variables
   - Update deployment guide
   - Prepare rollback plan
