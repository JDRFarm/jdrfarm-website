# 🚀 Deploy to GoDaddy Domain - Quick Start Guide

This guide will help you deploy your website to your GoDaddy domain. Choose the method that matches your setup.

---

## ⚡ Quick Decision Guide

**Do you have GoDaddy Web Hosting?**
- ✅ **YES** → Use **Method 1: FTP Deployment** (Automated)
- ❌ **NO** (Only domain) → Use **Method 2: GitHub Pages** (Free hosting)

---

## Method 1: Automated FTP Deployment (GoDaddy Hosting)

If you have GoDaddy Web Hosting, this will automatically deploy your site whenever you push to GitHub.

### Step 1: Get Your FTP Credentials from GoDaddy

1. Log in to **GoDaddy Account**
2. Go to **My Products** > **Web Hosting** > **Manage**
3. Click **cPanel Admin**
4. Scroll to **Files** section > Click **FTP Accounts**
5. Note down or create an FTP account:
   - **FTP Server:** Usually `ftp.yourdomain.com` or `yourdomain.com`
   - **FTP Username:** Your FTP username
   - **FTP Password:** Your FTP password

### Step 2: Add Secrets to GitHub

1. Go to your **GitHub Repository**
2. Click **Settings** (top menu)
3. Click **Secrets and variables** > **Actions** (left sidebar)
4. Click **New repository secret** and add these 3 secrets:

   **Secret 1:**
   - **Name:** `FTP_SERVER`
   - **Value:** Your FTP server (e.g., `ftp.jdrfarm.com` or `jdrfarm.com`)

   **Secret 2:**
   - **Name:** `FTP_USERNAME`
   - **Value:** Your FTP username

   **Secret 3:**
   - **Name:** `FTP_PASSWORD`
   - **Value:** Your FTP password

### Step 3: Deploy!

The workflow file (`.github/workflows/deploy-godaddy.yml`) is already created. Now:

1. **Push to GitHub:**
   ```bash
   git add .
   git commit -m "Setup GoDaddy deployment"
   git push
   ```

2. **Check Deployment:**
   - Go to your GitHub repo
   - Click **Actions** tab
   - You should see "Deploy to GoDaddy" workflow running
   - Wait 1-2 minutes for it to complete

3. **Visit Your Site:**
   - Go to `https://jdrfarm.com` (or your domain)
   - Your site should be live! 🎉

### Future Deployments

Every time you push to the `main` branch, your site will automatically deploy to GoDaddy!

---

## Method 2: GitHub Pages + GoDaddy Domain (Free Hosting)

If you only have a domain (no hosting), use GitHub Pages for free hosting.

### Step 1: Enable GitHub Pages

1. Go to your **GitHub Repository**
2. Click **Settings** (top menu)
3. Click **Pages** (left sidebar)
4. Under **Build and deployment**:
   - **Source:** Select `Deploy from a branch`
   - **Branch:** Select `main` (or `master`)
   - **Folder:** Select `/ (root)`
5. Click **Save**

### Step 2: Add Custom Domain

1. Still in **Settings > Pages**
2. Under **Custom domain**, enter: `www.jdrfarm.com`
3. Click **Save**
4. GitHub will show a warning about DNS - that's normal!

### Step 3: Configure GoDaddy DNS

1. Log in to **GoDaddy**
2. Go to **My Products** > **Domains**
3. Click on your domain (e.g., `jdrfarm.com`)
4. Click **DNS** (or **Manage DNS**)

5. **Update A Records:**
   - Find existing `A` records with `@` or blank name
   - Delete old ones (or update them)
   - Add these 4 new A records:
     
     | Type | Name | Value | TTL |
     |------|------|-------|-----|
     | A | @ | 185.199.108.153 | 600 |
     | A | @ | 185.199.109.153 | 600 |
     | A | @ | 185.199.110.153 | 600 |
     | A | @ | 185.199.111.153 | 600 |

6. **Update CNAME Record:**
   - Find existing `CNAME` record with name `www`
   - Update it (or create if missing):
     
     | Type | Name | Value | TTL |
     |------|------|-------|-----|
     | CNAME | www | YOUR_USERNAME.github.io | 600 |
     
     *Replace `YOUR_USERNAME` with your actual GitHub username*

7. **Save** all changes

### Step 4: Wait and Verify

1. **Wait 15-60 minutes** for DNS to propagate
2. Go back to **GitHub Settings > Pages**
3. You should see a green checkmark next to your domain
4. Check the **"Enforce HTTPS"** box (may take a few hours to appear)
5. Visit `https://www.jdrfarm.com` - your site should be live! 🎉

---

## 🆘 Troubleshooting

### FTP Deployment Issues

**"FTP connection failed"**
- Double-check your FTP credentials in GitHub Secrets
- Verify FTP server address (try with/without `ftp.` prefix)
- Make sure your FTP account is active in GoDaddy cPanel

**"Files not appearing on website"**
- Check if files are in `/public_html` directory
- Verify file permissions in cPanel File Manager
- Clear browser cache (Ctrl+F5)

### GitHub Pages Issues

**"DNS not configured correctly"**
- Wait longer (DNS can take up to 48 hours)
- Verify A records point to GitHub IPs (185.199.108.153, etc.)
- Verify CNAME points to `yourusername.github.io`
- Use [DNS Checker](https://dnschecker.org) to verify propagation

**"Site shows 404"**
- Make sure `index.html` is in the root of your repository
- Verify GitHub Pages is enabled and source branch is correct
- Check GitHub Pages build logs in Settings > Pages

---

## ✅ Success Checklist

### For FTP Deployment:
- [ ] FTP secrets added to GitHub
- [ ] Workflow file exists (`.github/workflows/deploy-godaddy.yml`)
- [ ] Pushed to GitHub
- [ ] GitHub Actions workflow completed successfully
- [ ] Site is live at your domain

### For GitHub Pages:
- [ ] GitHub Pages enabled
- [ ] Custom domain added
- [ ] DNS A records configured (4 records)
- [ ] DNS CNAME record configured
- [ ] DNS propagated (checked with DNS checker)
- [ ] HTTPS enforced
- [ ] Site is live at your domain

---

## 🎉 You're Done!

Your website should now be live at your GoDaddy domain. Every time you push changes to GitHub, your site will automatically update!

**Need help?** Check the detailed guide in `GODADDY_SETUP.md`
