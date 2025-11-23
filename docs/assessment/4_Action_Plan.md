# CRUX Project: Action Plan

## Phase 1: Immediate Actions (Week 1)
**Goal**: Stabilize the foundation and secure the code.

| Priority | Action | Description |
|----------|--------|-------------|
| **P0** | **Git Baseline** | Commit all current changes immediately to `main`. |
| **P0** | **Restructure** | Move backend to `backend/` and frontend to `frontend/`. |
| **P0** | **Agent Setup** | Create `.agent/rules.md` and workflows. |
| **P1** | **CI Setup** | Create basic GitHub Actions for linting. |
| **P1** | **Fix Types** | Remove `any` from backend error handling. |

## Phase 2: Core Completion (Week 2)
**Goal**: Complete the "Happy Path" for Group Buying.

| Priority | Action | Description |
|----------|--------|-------------|
| **P1** | **Deals Tests** | Add unit tests for `deals.logic.ts`. |
| **P1** | **Integration** | Connect Frontend "Join Deal" to Backend API. |
| **P2** | **Auth Polish** | Implement JWT refresh and secure storage (Flutter). |
| **P2** | **Validation** | Add Zod validation to all Backend endpoints. |

## Phase 3: Localization & Logistics (Week 3)
**Goal**: Make it ready for the Saudi market.

| Priority | Action | Description |
|----------|--------|-------------|
| **P1** | **Localization** | Implement `flutter_localizations` and Arabic strings. |
| **P2** | **RTL Check** | Verify all screens in RTL mode. |
| **P2** | **Logistics** | Implement "Cross-docking" logic in Orders service. |

## Phase 4: Production Prep (Week 4)
**Goal**: Deployable artifact.

| Priority | Action | Description |
|----------|--------|-------------|
| **P1** | **Deployment** | Dockerize Backend. Setup Render/DigitalOcean. |
| **P1** | **E2E Test** | Run a full "Register -> Join Deal -> Pay" flow. |
| **P2** | **Docs** | Write API documentation (Swagger). |
