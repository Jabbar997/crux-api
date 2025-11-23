# CRUX Project: Restructuring Guide

## 1. Current vs. Proposed Structure

### Current Structure (Mixed)
```
/
├── package.json (Backend)
├── src/ (Backend)
├── prisma/ (Backend)
├── crux_flutter_app/ (Frontend)
└── ...
```

### Proposed Structure (Monorepo)
```
/
├── backend/           <-- MOVED (was root)
│   ├── package.json
│   ├── src/
│   ├── prisma/
│   └── ...
├── frontend/          <-- RENAMED (was crux_flutter_app)
│   ├── pubspec.yaml
│   ├── lib/
│   └── ...
├── .agent/            <-- NEW
│   ├── rules.md
│   └── workflows/
├── docs/              <-- NEW
└── README.md          <-- NEW (Project Root)
```

## 2. Migration Plan (Step-by-Step)

### Phase 1: Preparation
1.  **Commit all changes**: Ensure `git status` is clean.
    ```bash
    git add .
    git commit -m "chore: backup before restructuring"
    ```

### Phase 2: Move Backend
1.  Create `backend` directory.
    ```bash
    mkdir backend
    ```
2.  Move backend files.
    ```bash
    mv package.json package-lock.json tsconfig.json tsconfig.node.json src prisma .env backend/
    ```
    *(Note: Check for other backend-specific files like `.gitignore` - you might need to merge root .gitignore with backend .gitignore)*

### Phase 3: Move/Rename Frontend
1.  Rename `crux_flutter_app` to `frontend`.
    ```bash
    mv crux_flutter_app frontend
    ```

### Phase 4: Root Cleanup
1.  Create a root `README.md` describing the project.
2.  Create a root `.gitignore` that ignores `node_modules` in subfolders, etc.

### Phase 5: Verify
1.  Test Backend:
    ```bash
    cd backend
    npm install
    npm run dev
    ```
2.  Test Frontend:
    ```bash
    cd ../frontend
    flutter pub get
    flutter run
    ```

## 3. Checklist
- [ ] Backup current state (Git commit)
- [ ] Create `backend` folder
- [ ] Move backend files
- [ ] Rename `crux_flutter_app` to `frontend`
- [ ] Update IDE workspace settings (if applicable)
- [ ] Verify both apps start
