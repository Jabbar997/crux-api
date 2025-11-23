# Git Workflow Guide

## 1. Branching Strategy
We will use a simplified **Git Flow**:

- **`main`**: Production-ready code. Protected branch.
- **`develop`**: Integration branch. All features merge here first.
- **`feature/name`**: For new features (e.g., `feature/auth-login`).
- **`fix/name`**: For bug fixes (e.g., `fix/api-timeout`).

## 2. Commit Messages
Follow **Conventional Commits**:
`type(scope): description`

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Formatting, missing semi colons, etc.
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `test`: Adding missing tests
- `chore`: Build process or auxiliary tool changes

**Examples**:
- `feat(auth): implement jwt token refresh`
- `fix(deals): correct threshold calculation logic`
- `docs(readme): update installation steps`

## 3. Workflow Steps

### Starting a Feature
```bash
git checkout develop
git pull origin develop
git checkout -b feature/my-new-feature
```

### Working
1.  Make changes.
2.  Stage changes: `git add .`
3.  Commit: `git commit -m "feat(scope): description"`

### Merging
1.  Push branch: `git push origin feature/my-new-feature`
2.  Open Pull Request (PR) to `develop`.
3.  Review and Merge.

## 4. Hooks (Recommended)
Install `husky` to enforce:
- **pre-commit**: Run linting (`npm run lint`).
- **commit-msg**: Verify commit message format.
