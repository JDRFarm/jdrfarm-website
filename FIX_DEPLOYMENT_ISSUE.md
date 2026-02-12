# 🔧 Fix: Repository Not Deploying to Domain

## Problem
Your repository is not automatically deploying to jdrfarm.com via Netlify.

## 🎯 Root Causes & Solutions

### Issue 1: Netlify Not Connected to GitHub

**Symptoms:**
- Changes pushed to GitHub but site doesn't update
- No deployments showing in Netlify

**Solution:**
1. Go to: **https://app.netlify.com**
2. Sign in to your account
3. Click on your site (or create one if it doesn't exist)
4. Go to: **Site settings** → **Build & deploy** → **Continuous Deployment**
5. Click: **"Link repository"** or **"Connect to Git provider"**
6. Select: **GitHub**
7. Authorize Netlify (if prompted)
8. Select repository: **`jdrfarm-website`**
9. Configure:
   - **Branch to deploy:** `main`
   - **Build command:** (leave empty)
   - **Publish directory:** `/` or `.`
10. Click: **"Save"**

**Verify:**
- Should see: ✅ **GitHub** connected
- Should see: Repository name `jdrfarm-website`
- Should see: Branch `main`

---

### Issue 2: Site Doesn't Exist in Netlify

**Symptoms:**
- Getting 404 error
- Can't find site in Netlify dashboard

**Solution:**
1. Go to: **https://app.netlify.com**
2. Click: **"Add new site"** → **"Import an existing project"**
3. Select: **"Deploy with GitHub"**
4. Authorize GitHub (if needed)
5. Select repository: **`jdrfarm-website`**
6. Configure build settings:
   - **Branch:** `main`
   - **Build command:** (empty)
   - **Publish directory:** `/`
7. Click: **"Deploy site"**
8. Wait for first deployment (1-2 minutes)

**After deployment:**
- Note your site URL: `https://your-site-name.netlify.app`
- This is needed for DNS configuration

---

### Issue 3: Domain Not Connected

**Symptoms:**
- Site works on `your-site.netlify.app`
- But `jdrfarm.com` shows 404 or doesn't work

**Solution:**
1. In Netlify: **Site settings** → **Domain management**
2. Click: **"Add custom domain"**
3. Enter: `jdrfarm.com`
4. Click: **"Verify"**
5. Netlify will show DNS instructions:
   - **A record:** `@` → `75.2.60.5` (or IP shown)
   - **CNAME:** `www` → `your-site-name.netlify.app`

6. **Configure DNS in GoDaddy:**
   - Login: https://account.godaddy.com
   - Go to: **My Products** → **Domains** → **jdrfarm.com** → **DNS**
   - **Delete old records** (if any)
   - **Add new records:**
     ```
     Type: A
     Name: @
     Value: 75.2.60.5
     TTL: 600 seconds
     
     Type: CNAME
     Name: www
     Value: your-site-name.netlify.app
     TTL: 600 seconds
     ```
   - **Save** changes

7. **Wait for DNS propagation:**
   - Takes 1-2 hours (sometimes up to 48 hours)
   - Check: https://dnschecker.org
   - Enter: `jdrfarm.com`
   - Should show Netlify IP everywhere

---

### Issue 4: Auto-Deploy Not Triggering

**Symptoms:**
- You push to GitHub
- Netlify doesn't deploy automatically

**Check:**
1. **GitHub Webhook:**
   - GitHub → Repository → **Settings** → **Webhooks**
   - Should see Netlify webhook
   - Check "Recent Deliveries" for errors

2. **Branch Name:**
   - Netlify tracks: `main` (or `master`)
   - You're pushing to: `main` (or `master`)
   - **They must match!**

3. **Auto-Publish:**
   - Netlify → Site settings → **Build & deploy**
   - **Auto-publish** toggle should be **ON**

**Fix:**
- If webhook missing: Reconnect repository in Netlify
- If branch wrong: Change branch in Netlify settings
- If auto-publish off: Enable it

---

### Issue 5: Build/Deployment Failing

**Symptoms:**
- Deployments show as "Failed" in Netlify
- Red X in Deploys tab

**Check Deployment Logs:**
1. Netlify → **Deploys** tab
2. Click on failed deployment
3. Read error message

**Common Errors:**

**Error: "No publish directory found"**
- **Fix:** Site settings → Build & deploy → Publish directory → Set to `/`

**Error: "index.html not found"**
- **Fix:** Ensure `index.html` is in root of repository (not in subfolder)

**Error: "Build command failed"**
- **Fix:** For static sites, build command should be **empty**

**Error: "File too large"**
- **Fix:** Compress large images (use TinyPNG.com)

---

## 🚀 Quick Fix Checklist

Use this checklist to fix your deployment:

- [ ] **Netlify account exists and logged in**
  - Visit: https://app.netlify.com
  - Sign in or create account

- [ ] **Site exists in Netlify**
  - If not, create it (Import from GitHub)

- [ ] **GitHub repository connected**
  - Site settings → Build & deploy → Continuous Deployment
  - Should show: ✅ GitHub connected

- [ ] **Correct branch selected**
  - Should be: `main` (or `master`)

- [ ] **Build settings correct**
  - Build command: (empty)
  - Publish directory: `/`

- [ ] **Auto-publish enabled**
  - Toggle should be ON

- [ ] **Domain added in Netlify**
  - Site settings → Domain management
  - Should see: `jdrfarm.com`

- [ ] **DNS configured in GoDaddy**
  - A record: `@` → `75.2.60.5`
  - CNAME: `www` → `your-site.netlify.app`

- [ ] **DNS propagated**
  - Check: https://dnschecker.org
  - Should show Netlify IP globally

- [ ] **Latest code pushed to GitHub**
  - All changes committed
  - Pushed to `main` branch

- [ ] **Deployment successful**
  - Netlify → Deploys tab
  - Latest deployment shows: ✅ Published

---

## 🔍 Diagnostic Steps

### Step 1: Check Netlify Status

1. **Open Netlify Dashboard:**
   ```
   https://app.netlify.com
   ```

2. **Check if site exists:**
   - Look for your site in the list
   - If missing → Create it (see Issue 2)

3. **Check deployment status:**
   - Click on your site
   - Go to **Deploys** tab
   - Check latest deployment:
     - ✅ Green = Success
     - ❌ Red = Failed (check logs)
     - 🟡 Yellow = Building

### Step 2: Check GitHub Connection

1. **In Netlify:**
   - Site settings → **Build & deploy** → **Continuous Deployment**
   - Should see: ✅ **GitHub** connected
   - Should see: Repository name

2. **If not connected:**
   - Click: **"Link repository"**
   - Select: **GitHub**
   - Choose: `jdrfarm-website`
   - Save

### Step 3: Check Domain Configuration

1. **In Netlify:**
   - Site settings → **Domain management**
   - Check if `jdrfarm.com` is listed
   - Status should be: ✅ **Active** or 🟡 **Provisioning**

2. **If not listed:**
   - Add it (see Issue 3)

3. **If shows error:**
   - Check DNS configuration (see Issue 3)

### Step 4: Test Deployment

1. **Make a small change:**
   - Edit `index.html` (add a comment)
   - Commit and push to GitHub

2. **Watch Netlify:**
   - Go to Netlify → Deploys tab
   - Should see new deployment starting automatically
   - Wait 1-2 minutes for completion

3. **If deployment doesn't start:**
   - Check webhook (see Issue 4)
   - Check branch name matches

---

## 🛠️ Manual Deployment (If Auto-Deploy Fails)

If auto-deploy isn't working, you can manually trigger:

1. **In Netlify:**
   - Go to: **Deploys** tab
   - Click: **"Trigger deploy"** → **"Deploy site"**
   - Wait for completion

2. **Or via Netlify CLI:**
   ```bash
   netlify login
   netlify deploy --prod
   ```

---

## 📞 Still Not Working?

### Gather Information:
- ✅ Netlify site name
- ✅ GitHub repository name
- ✅ Latest deployment status (screenshot)
- ✅ Error messages from deployment logs
- ✅ DNS configuration (screenshot from GoDaddy)

### Get Help:
- **Netlify Support:** https://www.netlify.com/support/
- **Netlify Community:** https://answers.netlify.com
- **Check Logs:** Netlify → Deploys → Click deployment → View logs

---

## ✅ Success Indicators

You're fixed when:
- ✅ Site appears in Netlify dashboard
- ✅ GitHub shows as connected
- ✅ Domain shows as "Active" in Netlify
- ✅ `git push` triggers Netlify deployment automatically
- ✅ Latest deployment shows "Published"
- ✅ `https://jdrfarm.com` works (after DNS propagates)
- ✅ Changes appear on live site within 1-2 minutes

---

**Run the diagnostic script:** `CHECK_NETLIFY_DEPLOYMENT.ps1` to check your current status!

