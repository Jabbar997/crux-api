---
description: Deploy to staging environment
---

# Deploy to Staging Workflow

## Pre-Deployment Checklist:
- [ ] All tests pass locally
- [ ] Branch merged to `develop`
- [ ] Environment variables verified
- [ ] Database migrations prepared
- [ ] Rollback plan documented

## Deployment Steps:

1. **Prepare**
```bash
   git checkout develop
   git pull origin develop
   npm run build
   npm test
```

2. **Database Migration** (if needed)
```bash
   cd backend
   npx prisma migrate deploy
```

3. **Deploy Backend**
```bash
   # SSH to staging server
   ssh user@staging-server
   cd /opt/crux-backend
   git pull origin develop
   npm install
   npm run build
   pm2 restart crux-api
```

4. **Deploy Frontend** (Future - when mobile)
   - Build APK/IPA
   - Upload to TestFlight/Internal Testing

5. **Verify Deployment**
   - [ ] Health check: `curl https://staging.crux-api.com/health`
   - [ ] Test critical endpoints
   - [ ] Check logs: `pm2 logs crux-api`
   - [ ] Test one full flow (register → join deal)

6. **Rollback** (if issues)
```bash
   git checkout [previous-commit]
   npm install
   npm run build
   pm2 restart crux-api
```

## Post-Deployment:
- Update deployment log
- Notify team on Slack
- Monitor for 1 hour
