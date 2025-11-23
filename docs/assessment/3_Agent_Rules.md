# CRUX Project Rules & Context

## 1. Business Context
**Project**: CRUX (B2B Marketplace for Construction Materials)
**Target Market**: Saudi Arabia (KSA)
**Key Features**:
- **Group Buying**: Aggregating demand to unlock tier-based discounts.
- **Logistics**: Cross-docking support.
- **Currency**: Saudi Riyal (SAR).
- **Language**: Arabic (RTL) & English.

## 2. Technical Standards

### Backend (Node.js/TypeScript)
- **Framework**: Express.js
- **ORM**: Prisma (PostgreSQL)
- **Structure**: Modular (`src/modules/{feature}/{controller,service,routes,types}.ts`)
- **Style**:
  - Strict TypeScript (no `any`).
  - Async/Await with `try/catch` in controllers.
  - Service layer handles business logic.
  - Controller layer handles HTTP request/response.

### Frontend (Flutter)
- **State Management**: Riverpod (Generator syntax preferred).
- **Navigation**: GoRouter.
- **Architecture**: Feature-first (`lib/features/{feature}/{data,domain,presentation}`).
- **Style**:
  - Use `const` constructors.
  - Extract widgets for reusability.
  - Use `AppTheme` for colors/fonts (no hardcoded values).

### Database
- **Naming**: snake_case for tables/columns.
- **Safety**: Never commit `.env`. Use migrations for changes.

## 3. Coding Conventions
- **Naming**:
  - Variables/Functions: `camelCase`
  - Classes/Components: `PascalCase`
  - Files: `snake_case` (backend) / `snake_case` (flutter)
- **Comments**: JSDoc/DartDoc for public methods. Explain "Why", not "What".

## 4. Saudi-Specific Requirements
- **Currency**: Display as `SAR 1,234.56` or `1,234.56 ر.س`.
- **Phone**: Validate KSA format (`+966` or `05...`).
- **VAT**: Calculate 15% VAT on all transactions.
- **Language**: Support RTL layout for all screens.

## 5. Security Rules
- **Auth**: JWT for API access.
- **Validation**: Validate all inputs (Zod for backend).
- **Secrets**: Never log sensitive data.

## 6. Testing Requirements
- **Backend**: Unit tests for Services (Jest).
- **Frontend**: Widget tests for critical UI components.
