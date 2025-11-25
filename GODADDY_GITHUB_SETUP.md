# Publishing GitHub Repo to GoDaddy Domain

This guide explains how to connect your GitHub repository to your GoDaddy domain (jdrfarm.com).

---

## 🎯 Overview

There are **two main methods** to publish your GitHub repo on your GoDaddy domain:

| Method | Pros | Cons |
|--------|------|------|
| **GitHub Pages + GoDaddy DNS** | Free hosting, automatic deployments | Limited to static sites |
| **GoDaddy Web Hosting** | Full server control | Monthly hosting cost |

**Recommended:** Use **GitHub Pages** (free) and point your GoDaddy domain to it.

---

## Method 1: GitHub Pages + GoDaddy DNS (Recommended) ⭐

### Step 1: Enable GitHub Pages

1. Go to your GitHub repository
2. Click **Settings** → **Pages** (in the left sidebar)
3. Under **Source**, select:
   - Branch: `main` (or your default branch)
   - Folder: `/ (root)`
4. Click **Save**

Your site will be live at: `https://yourusername.github.io/repositoryname/`

### Step 2: Add Custom Domain in GitHub

1. Still in **Settings** → **Pages**
2. Under **Custom domain**, enter: `jdrfarm.com`
3. Click **Save**
4. ✅ Check **Enforce HTTPS** (recommended for security)

### Step 3: Create CNAME File

Create a file named `CNAME` (no extension) in your repository root with your domain:

```
jdrfarm.com
```

### Step 4: Configure GoDaddy DNS

1. Log in to your [GoDaddy account](https://www.godaddy.com)
2. Go to **My Products** → Find your domain → Click **DNS**
3. **Delete** any existing A records or CNAME for `@` and `www`

#### Add A Records (for apex domain - jdrfarm.com):

Add these 4 A records pointing to GitHub's servers:

| Type | Name | Value | TTL |
|------|------|-------|-----|
| A | @ | 185.199.108.153 | 600 |
| A | @ | 185.199.109.153 | 600 |
| A | @ | 185.199.110.153 | 600 |
| A | @ | 185.199.111.153 | 600 |

#### Add CNAME Record (for www subdomain):

| Type | Name | Value | TTL |
|------|------|-------|-----|
| CNAME | www | yourusername.github.io | 600 |

> Replace `yourusername` with your actual GitHub username

### Step 5: Wait for DNS Propagation

- DNS changes can take **10 minutes to 48 hours** to propagate worldwide
- Check status at: https://dnschecker.org

### Step 6: Verify HTTPS

1. Go back to GitHub → **Settings** → **Pages**
2. Wait for the DNS check to complete (green checkmark)
3. Enable **Enforce HTTPS** if not already enabled

---

## Method 2: GoDaddy Web Hosting (Alternative)

If you have GoDaddy hosting (paid), you can upload files directly:

### Option A: Using File Manager

1. Log in to GoDaddy → **My Products** → **Web Hosting** → **Manage**
2. Click **File Manager**
3. Navigate to `public_html` folder
4. Upload all your files:
   - `index.html`
   - `styles.css`
   - `script.js`
   - `logo/` folder
   - `image/` folder

### Option B: Using FTP/SFTP

1. Get FTP credentials from GoDaddy:
   - Go to **Hosting** → **Manage** → **Settings** → **FTP/SFTP**
   - Note your hostname, username, and password
2. Use an FTP client (FileZilla, Cyberduck)
3. Connect and upload files to `public_html`

### Option C: Using Git Deploy (Advanced)

1. SSH into your GoDaddy hosting
2. Clone your repository:
   ```bash
   cd public_html
   git clone https://github.com/yourusername/your-repo.git .
   ```
3. Set up a webhook or cron job for auto-updates

---

## 🔧 Troubleshooting

### Domain not working?

1. **Check DNS propagation**: https://dnschecker.org
2. **Verify CNAME file** exists in repo root
3. **Clear browser cache** and try incognito mode
4. **Wait 24-48 hours** for full DNS propagation

### HTTPS not working?

1. Ensure all 4 A records are correct
2. Remove any conflicting DNS records
3. Wait for GitHub to issue SSL certificate (can take up to 24 hours)
4. Check **Settings** → **Pages** for any error messages

### "Site not found" error?

1. Verify GitHub Pages is enabled
2. Check the branch and folder settings
3. Ensure `index.html` exists in the root

### Mixed content warnings?

Update all URLs in your HTML to use `https://` instead of `http://`

---

## 📋 Quick Checklist

### GitHub Setup:
- [ ] GitHub Pages enabled
- [ ] Custom domain entered: `jdrfarm.com`
- [ ] CNAME file created in repo
- [ ] Enforce HTTPS enabled

### GoDaddy DNS Setup:
- [ ] A record: `@` → `185.199.108.153`
- [ ] A record: `@` → `185.199.109.153`
- [ ] A record: `@` → `185.199.110.153`
- [ ] A record: `@` → `185.199.111.153`
- [ ] CNAME record: `www` → `yourusername.github.io`

### Verification:
- [ ] DNS propagated (check dnschecker.org)
- [ ] Site loads at `https://jdrfarm.com`
- [ ] Site loads at `https://www.jdrfarm.com`
- [ ] HTTPS working (padlock icon in browser)

---

## 🚀 Automatic Deployments

With GitHub Pages, every push to your main branch **automatically updates** your live site!

```bash
# Make changes to your code
git add .
git commit -m "Update website"
git push origin main
# Site updates automatically in 1-2 minutes!
```

---

## 📞 Need Help?

- **GitHub Pages Docs**: https://docs.github.com/en/pages
- **GoDaddy DNS Help**: https://www.godaddy.com/help/manage-dns-680
- **DNS Propagation Check**: https://dnschecker.org

---

## Summary

**Fastest Setup (5-10 minutes):**

1. Enable GitHub Pages (Settings → Pages → Main branch)
2. Add custom domain: `jdrfarm.com`
3. Create `CNAME` file with `jdrfarm.com`
4. In GoDaddy DNS, add 4 A records + 1 CNAME record
5. Wait for DNS propagation
6. Enable HTTPS

Your site will be live at **https://jdrfarm.com** with free hosting and automatic deployments! 🎉
