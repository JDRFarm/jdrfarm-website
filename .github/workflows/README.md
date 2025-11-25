# GitHub Actions Workflows

This folder contains automated workflows for deploying your website.

## Available Workflows

### 1. Deploy to GoDaddy FTP (`deploy-to-godaddy-ftp.yml`)

**Purpose:** Automatically deploy your site to GoDaddy hosting via FTP when you push to GitHub.

**When to use:** Only if you have GoDaddy Web Hosting (paid hosting plan).

**When NOT to use:** If you're using Netlify or GitHub Pages (they auto-deploy automatically).

---

## Setup Instructions for GoDaddy FTP Deployment

### Prerequisites
- ✅ GoDaddy Web Hosting plan (not just domain)
- ✅ FTP credentials from GoDaddy
- ✅ Repository on GitHub

### Step-by-Step Setup

#### 1. Get Your FTP Credentials

1. Login to GoDaddy: https://account.godaddy.com
2. Go to: **My Products** → **Web Hosting** → **Manage**
3. Find FTP credentials (or create new FTP account):
   - **FTP Server:** `ftp.jdrfarm.com` or `ftp.yoursite.com`
   - **Username:** Usually `username@jdrfarm.com`
   - **Password:** Your FTP password
   - **Server Directory:** Usually `/public_html/` or `/htdocs/`

#### 2. Add Secrets to GitHub

1. Go to your GitHub repository: https://github.com/YOUR_USERNAME/jdrfarm-website
2. Click: **Settings** (top menu)
3. In left sidebar: **Secrets and variables** → **Actions**
4. Click: **New repository secret**
5. Add these three secrets one by one:

   **Secret 1:**
   - Name: `FTP_SERVER`
   - Value: `ftp.jdrfarm.com` (your FTP server)
   - Click **Add secret**

   **Secret 2:**
   - Name: `FTP_USERNAME`
   - Value: `username@jdrfarm.com` (your FTP username)
   - Click **Add secret**

   **Secret 3:**
   - Name: `FTP_PASSWORD`
   - Value: Your FTP password (keep this secure!)
   - Click **Add secret**

#### 3. Activate the Workflow

1. Make sure `deploy-to-godaddy-ftp.yml` is in `.github/workflows/` folder
2. Push to GitHub:
   ```bash
   git add .
   git commit -m "Add GitHub Actions workflow for GoDaddy FTP"
   git push
   ```

#### 4. Test the Workflow

1. Make a small change to your site (e.g., edit `index.html`)
2. Save and commit:
   ```bash
   git add .
   git commit -m "Test auto-deploy to GoDaddy"
   git push
   ```
3. Check workflow status:
   - Go to repository → **Actions** tab
   - You should see "Deploy to GoDaddy FTP" running
   - Wait 1-2 minutes for completion
   - Check your live site: https://jdrfarm.com

---

## How It Works

### Automatic Deployment Flow

```
1. You edit files locally (index.html, styles.css, etc.)
2. Save changes
3. Commit and push to GitHub (manually or via auto-deploy script)
4. GitHub Actions detects the push
5. Workflow runs automatically:
   - Checks out your code
   - Connects to GoDaddy FTP
   - Uploads changed files
   - Completes in 1-2 minutes
6. Your site is live on jdrfarm.com!
```

### What Gets Uploaded

The workflow uploads these files:
- ✅ `index.html`
- ✅ `styles.css`
- ✅ `script.js`
- ✅ `logo/` folder (all images)
- ✅ `image/` folder (all images)

It **excludes** these files:
- ❌ `.git/` folder
- ❌ `.github/` folder
- ❌ README files (`*.md`)
- ❌ Batch scripts (`*.bat`)
- ❌ PowerShell scripts (`*.ps1`)
- ❌ `netlify.toml`
- ❌ Other development files

---

## Monitoring Deployments

### View Deployment Status

1. Go to your repository on GitHub
2. Click: **Actions** tab (top menu)
3. You'll see all workflow runs:
   - 🟢 Green checkmark = Success
   - 🔴 Red X = Failed
   - 🟡 Yellow circle = Running

### View Deployment Logs

1. Click on any workflow run
2. Click on "Deploy to GoDaddy via FTP" job
3. Expand steps to see detailed logs
4. Useful for troubleshooting

---

## Troubleshooting

### ❌ "Authentication failed"
**Problem:** FTP credentials are incorrect

**Solution:**
1. Verify credentials in GoDaddy cPanel
2. Update GitHub Secrets with correct values
3. Common issues:
   - Wrong username format (should be `user@domain.com`)
   - Incorrect password
   - FTP server address wrong

### ❌ "Connection timeout"
**Problem:** Can't connect to FTP server

**Solution:**
1. Verify FTP server address in GitHub Secrets
2. Check if GoDaddy FTP is working (test with FileZilla)
3. Ensure firewall allows FTP connections
4. Try using IP address instead of domain name

### ❌ "Directory not found"
**Problem:** `/public_html/` directory doesn't exist

**Solution:**
1. Edit `deploy-to-godaddy-ftp.yml`
2. Change `server-dir: /public_html/` to:
   - `/htdocs/` or
   - `/www/` or
   - `/` (root)
3. Check your GoDaddy hosting structure via FTP

### ❌ "Deployment succeeded but site not updating"
**Problem:** Files uploaded to wrong directory

**Solution:**
1. Connect via FTP client (FileZilla)
2. Find where `index.html` should be
3. Update `server-dir` in workflow file
4. Commit and push again

### ❌ "Workflow not running"
**Problem:** Workflow file not detected

**Solution:**
1. Ensure file is at: `.github/workflows/deploy-to-godaddy-ftp.yml`
2. Check file extension is `.yml` not `.yaml` or `.txt`
3. Push to `main` branch (workflow triggers on main only)
4. Check Actions tab for any errors

---

## Disabling the Workflow

If you switch to Netlify or GitHub Pages and don't need FTP deployment:

### Option 1: Delete the workflow file
```bash
git rm .github/workflows/deploy-to-godaddy-ftp.yml
git commit -m "Remove GoDaddy FTP workflow (using Netlify now)"
git push
```

### Option 2: Disable in GitHub
1. Go to repository → **Actions** tab
2. Click on "Deploy to GoDaddy FTP" workflow
3. Click "..." (three dots) → **Disable workflow**

---

## Manual Trigger

You can manually run the workflow without pushing code:

1. Go to repository → **Actions** tab
2. Click on "Deploy to GoDaddy FTP" workflow
3. Click "Run workflow" button
4. Select branch: `main`
5. Click "Run workflow"

Useful for:
- Testing the workflow
- Re-deploying without code changes
- Forcing a fresh deployment

---

## Customization

### Change Upload Directory
Edit `deploy-to-godaddy-ftp.yml`:
```yaml
server-dir: /your-directory/
```

### Exclude More Files
Edit the `exclude:` section:
```yaml
exclude: |
  **/.git*
  **/your-file-to-exclude.txt
```

### Change Trigger
Edit the `on:` section:
```yaml
on:
  push:
    branches:
      - main
      - production  # Add more branches
```

---

## Cost

**GitHub Actions:** Free for public repositories, 2,000 minutes/month for private repositories

This workflow uses ~1-2 minutes per deployment, so you can deploy hundreds of times per month for free!

---

## Support

- **GitHub Actions Docs:** https://docs.github.com/actions
- **FTP-Deploy-Action:** https://github.com/SamKirkland/FTP-Deploy-Action
- **GoDaddy Support:** https://www.godaddy.com/help

---

## Alternative: Use Netlify Instead!

If you don't have GoDaddy hosting yet, consider using **Netlify** instead:

✅ Easier setup (no FTP needed)
✅ Faster deployment (1 minute vs 2-3 minutes)
✅ Better performance (global CDN)
✅ Free SSL certificate
✅ Free hosting (unlimited bandwidth)

See: `QUICK_GODADDY_SETUP.md` for Netlify setup instructions.

---

**Questions?** Check the main guides:
- `GODADDY_DEPLOYMENT_GUIDE.md` - Full deployment guide
- `DEPLOYMENT_COMPARISON.md` - Compare all options
