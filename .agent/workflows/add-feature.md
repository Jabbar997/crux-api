---
description: Add a new full-stack feature
---

1.  **Plan**:
    *   Define requirements in `task.md`.
    *   Update `implementation_plan.md`.
2.  **Backend**:
    *   Update Prisma schema if needed (`npx prisma migrate dev`).
    *   Run `create-api-endpoint` workflow for necessary APIs.
3.  **Frontend**:
    *   Create feature folder: `lib/features/{feature_name}`.
    *   Create `data/repository.dart` to call the API.
    *   Create `domain/models` for data types.
    *   Create `presentation/controllers` (Riverpod).
    *   Create `presentation/screens` (UI).
4.  **Integrate**:
    *   Connect UI to Controller to Repository.
5.  **Test**:
    *   Run backend tests.
    *   Run frontend widget tests.
    *   Manual verification.
