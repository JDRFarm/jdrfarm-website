# 🔍 Netlify Issue Diagnostic Guide

## Common Netlify Issues & Solutions

### Issue 1: "Site not found" or 404 Error

**Symptoms:**
- Getting "Site not found" error
- 404 page when visiting your domain

**Possible Causes:**
1. Site doesn't exist in Netlify
2. Domain not properly configured
3. DNS not pointing to Netlify
4. Site was deleted

**How to Check:**
1. Go to: https://app.netlify.com
2. Check if your site appears in the sites list
3. If not, you need to create it

**Solution:**
- See: `FIX_NETLIFY_404_ERROR.md`

---

### Issue 2: Build/Deployment Failing

**Symptoms:**
- Deployments show red X (failed)
- Error messages in deployment logs

**How to Check:**
1. Netlify → Your site → **Deploys** tab
2. Click on failed deployment
3. Read the error message

**Common Errors:**

#### Error: "No publish directory found"
**Cause:** Netlify doesn't know where your files are

**Solution:**
1. Site settings → **Build & deploy** → **Build settings**
2. Set **Publish directory:** `/` or `.`
3. Save and redeploy

#### Error: "index.html not found"
**Cause:** `index.html` is not in the root directory

**Solution:**
1. Check GitHub: Is `index.html` in root? (not in a subfolder)
2. If in subfolder, either:
   - Move to root, OR
   - Set publish directory to that subfolder

#### Error: "Build command failed"
**Cause:** Build command is trying to run something that doesn't exist

**Solution:**
1. Site settings → **Build & deploy** → **Build settings**
2. Set **Build command:** (leave empty for static sites)
3. Save and redeploy

#### Error: "File too large"
**Cause:** File exceeds Netlify's 100MB limit

**Solution:**
1. Compress large images (use TinyPNG.com)
2. Remove unnecessary large files
3. Redeploy

---

### Issue 3: GitHub Not Connected

**Symptoms:**
- Changes pushed to GitHub but Netlify doesn't deploy
- No automatic deployments

**How to Check:**
1. Netlify → Site settings → **Build & deploy** → **Continuous Deployment**
2. Should show: ✅ **GitHub** connected

**If NOT connected:**
1. Click: **"Link repository"**
2. Select: **GitHub**
3. Choose: `jdrfarm-website`
4. Configure:
   - Branch: `main`
   - Build command: (empty)
   - Publish directory: `/`
5. Save

---

### Issue 4: Domain Not Working

**Symptoms:**
- Site works on `your-site.netlify.app`
- But `jdrfarm.com` doesn't work

**How to Check:**
1. Netlify → Site settings → **Domain management**
2. Check if `jdrfarm.com` is listed
3. Check status: Should be "Active" or "Provisioning"

**If not listed:**
1. Click: **"Add custom domain"**
2. Enter: `jdrfarm.com`
3. Follow DNS instructions

**If shows error:**
1. Check DNS in GoDaddy
2. Verify A record points to Netlify IP
3. Wait for DNS propagation (1-2 hours)

---

### Issue 5: SSL Certificate Issues

**Symptoms:**
- "Not secure" warning
- SSL certificate errors
- HTTPS not working

**How to Check:**
1. Netlify → Site settings → **Domain management** → **HTTPS**
2. Check certificate status

**If "Provisioning":**
- Wait 5-24 hours (usually 2-4 hours)
- Certificate issues automatically after DNS propagates

**If "Error":**
1. Verify DNS is correct
2. Click: **"Renew certificate"**
3. Wait 10-30 minutes

---

### Issue 6: Auto-Deploy Not Working

**Symptoms:**
- Push to GitHub but no deployment starts
- Manual deploy works but auto doesn't

**How to Check:**
1. **Auto-publish enabled?**
   - Site settings → **Build & deploy**
   - Toggle should be **ON**

2. **Branch name matches?**
   - Netlify tracks: `main`
   - You're pushing to: `main`
   - Must match!

3. **GitHub webhook working?**
   - GitHub → Repository → **Settings** → **Webhooks**
   - Should see Netlify webhook
   - Check "Recent Deliveries" for errors

**Solution:**
- Enable auto-publish if off
- Reconnect repository if webhook missing
- Verify branch name matches

---

## 🔍 Step-by-Step Diagnostic

### Step 1: Check Site Exists
```
1. Go to: https://app.netlify.com
2. Sign in
3. Do you see your site in the list?
   - YES → Go to Step 2
   - NO → Create site (Import from GitHub)
```

### Step 2: Check Deployment Status
```
1. Click on your site
2. Go to: "Deploys" tab
3. Check latest deployment:
   - ✅ Green = Success → Go to Step 3
   - ❌ Red = Failed → Click on it, read error
   - 🟡 Yellow = Building → Wait
```

### Step 3: Check GitHub Connection
```
1. Site settings → Build & deploy → Continuous Deployment
2. Should show: ✅ GitHub connected
   - YES → Go to Step 4
   - NO → Link repository
```

### Step 4: Check Domain
```
1. Site settings → Domain management
2. Should see: jdrfarm.com
   - YES → Check status (Active/Provisioning/Error)
   - NO → Add custom domain
```

### Step 5: Check Build Settings
```
1. Site settings → Build & deploy → Build settings
2. Verify:
   - Build command: (empty)
   - Publish directory: /
   - Branch: main
```

---

## 🛠️ Quick Fixes

### Fix 1: Reset Build Settings
1. Site settings → **Build & deploy** → **Build settings**
2. Set:
   - **Build command:** (empty)
   - **Publish directory:** `/`
   - **Branch:** `main`
3. **Save**
4. **Trigger deploy** → **Deploy site**

### Fix 2: Reconnect GitHub
1. Site settings → **Build & deploy** → **Continuous Deployment**
2. Click: **"Link to a different repository"**
3. Select: **GitHub**
4. Choose: `jdrfarm-website`
5. **Save**

### Fix 3: Manual Deploy
1. **Deploys** tab
2. Click: **"Trigger deploy"** → **"Deploy site"**
3. Wait for completion

### Fix 4: Clear Cache and Redeploy
1. **Deploys** tab
2. Click: **"Trigger deploy"** → **"Clear cache and deploy site"**
3. Wait for completion

---

## 📋 Diagnostic Checklist

Use this to identify your specific issue:

- [ ] **Site exists in Netlify?**
  - Check: https://app.netlify.com
  - If no → Create site

- [ ] **Latest deployment successful?**
  - Check: Deploys tab
  - If failed → Read error message

- [ ] **GitHub connected?**
  - Check: Site settings → Build & deploy
  - If no → Link repository

- [ ] **Build settings correct?**
  - Build command: (empty)
  - Publish directory: /
  - If wrong → Fix settings

- [ ] **Domain added?**
  - Check: Site settings → Domain management
  - If no → Add custom domain

- [ ] **DNS configured?**
  - Check: GoDaddy DNS
  - A record: @ → 75.2.60.5
  - If wrong → Fix DNS

- [ ] **Auto-publish enabled?**
  - Check: Site settings → Build & deploy
  - Toggle should be ON
  - If off → Enable it

- [ ] **Branch name matches?**
  - Netlify: main
  - GitHub: main
  - If different → Fix branch

---

## 🚨 Most Common Issues (Quick Reference)

| Issue | Symptom | Quick Fix |
|-------|---------|-----------|
| Site not found | 404 error | Create site in Netlify |
| Build failed | Red X in deploys | Check build settings, set publish to `/` |
| No auto-deploy | Push doesn't trigger | Link GitHub repository |
| Domain not working | Works on .netlify.app but not custom domain | Add domain, configure DNS |
| SSL error | Certificate issues | Wait 24 hours, renew certificate |
| Files not found | index.html not found | Ensure files in root, set publish to `/` |

---

## 📞 Get Specific Help

### What Information to Gather:

1. **Screenshot of:**
   - Netlify dashboard (sites list)
   - Failed deployment (error message)
   - Build settings
   - Domain management

2. **Error messages:**
   - Copy exact error text from deployment logs
   - Any error codes shown

3. **Current status:**
   - Does site exist in Netlify?
   - Is GitHub connected?
   - What does latest deployment show?

### Where to Get Help:

1. **Netlify Support:**
   - https://www.netlify.com/support/
   - Include error messages and screenshots

2. **Netlify Community:**
   - https://answers.netlify.com
   - Search for similar issues

3. **Deployment Logs:**
   - Netlify → Deploys → Click deployment → View logs
   - Look for red error messages

---

## ✅ Success Indicators

You're fixed when:
- ✅ Site appears in Netlify dashboard
- ✅ Latest deployment shows "Published" (green)
- ✅ GitHub shows as connected
- ✅ Domain shows as "Active"
- ✅ `https://jdrfarm.com` works
- ✅ Changes deploy automatically after `git push`

---

**Run the diagnostic script or follow the checklist above to identify your specific issue!**

