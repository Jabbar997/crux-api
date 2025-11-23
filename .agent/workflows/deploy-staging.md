---
description: Deploy application to staging environment
---

1.  **Pre-Deployment Check**:
    *   Ensure all tests pass.
    *   Ensure `main` branch is up to date.
    *   Check `package.json` version.
2.  **Backend Deploy (Render)**:
    *   Push to `main`.
    *   Render auto-deploys (if configured).
    *   Verify logs in Render dashboard.
3.  **Frontend Deploy**:
    *   Build web: `flutter build web`.
    *   Deploy to hosting (e.g., Firebase/Vercel).
    *   OR Build APK: `flutter build apk --release`.
4.  **Smoke Test**:
    *   Log in.
    *   View Deals.
    *   Create a dummy order.
