# CRUX Git Workflow

## Branches
- `main`: Production-ready code
- `develop`: Integration branch for features
- `feature/*`: New features
- `fix/*`: Bug fixes
- `refactor/*`: Code improvements

## Workflow
1. Create branch from `develop`
2. Make changes
3. Commit with conventional format
4. Push and create PR
5. Pass CI checks
6. Code review
7. Merge to `develop`
8. Deploy to staging
9. After testing, merge to `main`

## Commit Format
```
type(scope): description

[optional body]

[optional footer]
```

Types: feat, fix, refactor, test, docs, chore
Scope: module name (deals, auth, orders, etc.)

Examples:
- `feat(deals): add auto-extension logic`
- `fix(auth): correct JWT expiry validation`
- `test(deals): add integration tests`
