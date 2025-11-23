# CRUX Project Rules & Context

## 1. Business Context
- **Project**: CRUX (B2B Marketplace for Construction Materials)
- **Target Market**: Saudi Arabia (KSA)
- **Users**: Contractors (المقاولون) and Suppliers (الموردون)
- **Core Value**: Group Buying + Cross-docking logistics

## 2. Technical Standards

### Backend (Node.js/TypeScript/Prisma)
- **Currency**: All amounts in SAR (Saudi Riyal). Format: `1234.56` (no thousands separator).
- **Phone**: `+966 5X XXX XXXX` format.
- **Identity**: Iqama/National ID must be 10 digits.
- **Dates**: All dates in ISO 8601.
- **Error Responses**:
  ```typescript
  {
    success: false,
    error: {
      code: "ERROR_CODE",
      message: "User-friendly message (Arabic)",
      details?: any
    }
  }
  ```

### Frontend (Flutter)
- **Primary Language**: Arabic (العربية).
- **Layout**: RTL support mandatory.
- **Design**: Material Design 3, Responsive (mobile-first).
- **Offline**: Offline-first where possible.
- **Errors**: User-facing error messages must be in Arabic.

### Database (PostgreSQL + Prisma)
- **IDs**: Use UUID for all IDs.
- **Deletes**: Soft deletes (`deletedAt` field).
- **Timestamps**: `createdAt`, `updatedAt` on all tables.
- **Text**: Arabic text fields must support full Unicode.
- **Indexes**: Required on `userId`, `dealId`, `status` fields.

## 3. Business Rules to Code

### Group Buying (Deals)
- **Phase 1 (Collection)**: 0-49% of target.
- **Phase 2 (Building)**: 50-69% of target (auto-extend by 3 days).
- **Phase 3 (Active)**: 70%+ of target (can close early).
- **Auto-close**: If not reaching 50% before deadline.
- **Price Tiers**: Based on total quantity.
- **Min Participants**: 3 (configurable).
- **Duration**: 7-30 days.

### Orders & Logistics
- **Status Flow**: `PENDING` → `CONFIRMED` → `PREPARING` → `IN_TRANSIT` → `DELIVERED` → `COMPLETED`.
- **Cross-docking**: Orders grouped by supplier + delivery zone.
- **Time Slots**: 8-12, 12-4, 4-8.
- **Driver Assignment**: Algorithm based on location/load.

## 4. Security Requirements
- **Auth**: JWT tokens (15min access, 7d refresh).
- **Passwords**: Bcrypt (rounds: 12).
- **Rate Limiting**: 100 req/15min per IP.
- **Validation**: Input validation on ALL endpoints using Zod.
- **SQL Injection**: Use Prisma parameterized queries (default).
- **Verification**: Supplier/Contractor verification mandatory.
- **Audit**: Log all financial transactions.

## 5. Testing Requirements
- **Coverage**: Unit tests 80%+.
- **Integration**: Tests for all API endpoints.
- **E2E**: Critical flows (Register → Login, Browse → Join, Order → Track).
- **Data**: Test with Arabic data and RTL layouts.
- **Edge Cases**: Deal expiry, concurrent joins.

## 6. Code Style
- **TypeScript**: Strict mode.
- **Linting**: ESLint + Prettier.
- **Max Line Length**: 100.
- **Types**: No `any` (use `unknown` if needed).
- **Naming**: Descriptive variable names.
- **Comments**: English for code, Arabic for user-facing strings.

## 7. Git Workflow
- **Branches**: `feature/description`, `fix/description`, `refactor/description`.
- **Commits**: Conventional Commits (`type(scope): description`).
  - Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`.
- **Never Commit**: `.env`, `node_modules/`, build artifacts, secrets.

## 8. Documentation
- **Modules**: Every module must have a `README.md`.
- **API**: OpenAPI/Swagger format.
- **Functions**: JSDoc for all public functions.
- **Database**: Schema documented with ERD.
- **Deployment**: Step-by-step instructions.
