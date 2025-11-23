---
description: Create a new API endpoint in the backend
---

1.  **Identify Module**: Determine which module the endpoint belongs to (e.g., `auth`, `deals`). If new, create the folder structure.
2.  **Define Route**: Add the route in `{module}.routes.ts`.
3.  **Create Controller**: Add the method in `{module}.controller.ts`.
    *   Use `try/catch`.
    *   Validate input using Zod.
    *   Call the service.
    *   Return appropriate HTTP status (200, 201, 400, etc.).
4.  **Implement Service**: Add business logic in `{module}.service.ts`.
    *   Interact with Prisma.
    *   Handle exceptions.
5.  **Add Tests**: Create a test file `{module}.test.ts` and add unit tests for the service method.
6.  **Verify**: Run the server and test with `curl` or Postman.
