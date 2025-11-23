---
description: Create a new REST API endpoint with tests
---

# Create API Endpoint Workflow

## Steps:

1. **Define Route**
   - Add route to appropriate router file
   - Use clear, RESTful naming (plural nouns)
   - Example: `POST /api/v1/deals/:id/join`

2. **Create Controller**
   - In `backend/src/modules/[module]/[module].controller.ts`
   - Validate request with Zod schema
   - Call service layer
   - Handle errors gracefully
   - Return consistent response format

3. **Create Service**
   - In `backend/src/modules/[module]/[module].service.ts`
   - Implement business logic
   - Use Prisma for database operations
   - Handle transactions if needed
   - Log important actions

4. **Add Validation Schema**
   - Create Zod schema in `[module].validation.ts`
   - Validate: body, params, query
   - Custom validators for: phone, iqama, amount

5. **Write Tests**
   - Unit tests for service logic
   - Integration tests for endpoint
   - Test success cases
   - Test error cases (validation, business rules)
   - Test edge cases
   - Mock external dependencies

6. **Document API**
   - Add OpenAPI/Swagger annotations
   - Include example request/response
   - Document error codes
   - Update Postman collection

7. **Update CHANGELOG**
   - Add entry under "Unreleased"
   - Format: `- Added [endpoint name] ([PR number])`
