---
description: Add tests to existing code
---

1.  **Identify Target**: Choose a file/module that lacks coverage.
2.  **Backend (Jest)**:
    *   Create `__tests__` folder or `*.test.ts` file.
    *   Mock dependencies (e.g., Prisma client).
    *   Write test cases for success and failure scenarios.
    *   Run `npm test`.
3.  **Frontend (Flutter)**:
    *   Create `test/{feature}_test.dart`.
    *   Use `testWidgets` for UI components.
    *   Use `test` for pure Dart logic/repositories.
    *   Run `flutter test`.
