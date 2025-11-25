# How to Publish GitHub Repository to GoDaddy Domain

This guide explains multiple methods to deploy your JDR Farm website from GitHub to your GoDaddy domain.

## Method 1: GitHub Pages + GoDaddy DNS (Recommended - Free & Easy)

This is the easiest and free method. GitHub hosts your site, and GoDaddy points your domain to it.

### Step 1: Enable GitHub Pages

1. Go to your GitHub repository
2. Click **Settings** → **Pages** (in the left sidebar)
3. Under **Source**, select:
   - **Branch**: `main` (or your default branch)
   - **Folder**: `/ (root)`
4. Click **Save**
5. Wait 1-2 minutes, then visit: `https://yourusername.github.io/repository-name`

### Step 2: Configure Custom Domain in GitHub

1. In the same **Pages** settings, scroll to **Custom domain**
2. Enter your GoDaddy domain (e.g., `jdrfarm.com` or `www.jdrfarm.com`)
3. Check **Enforce HTTPS** (wait a few minutes for SSL certificate)
4. Click **Save**

### Step 3: Configure DNS in GoDaddy

1. Log in to your **GoDaddy account**
2. Go to **My Products** → **Domains** → Click **DNS** next to your domain
3. Add/Edit these DNS records:

   **For apex domain (jdrfarm.com):**
   ```
   Type: A
   Name: @
   Value: 185.199.108.153
   TTL: 600 seconds
   
   Type: A
   Name: @
   Value: 185.199.109.153
   TTL: 600 seconds
   
   Type: A
   Name: @
   Value: 185.199.110.153
   TTL: 600 seconds
   
   Type: A
   Name: @
   Value: 185.199.111.153
   TTL: 600 seconds
   ```

   **For www subdomain (www.jdrfarm.com):**
   ```
   Type: CNAME
   Name: www
   Value: yourusername.github.io
   TTL: 600 seconds
   ```

4. **Remove** any conflicting A or CNAME records
5. **Save** changes

### Step 4: Wait for DNS Propagation

- DNS changes can take 24-48 hours (usually 1-2 hours)
- Check propagation: https://www.whatsmydns.net
- Your site will be live at: `https://jdrfarm.com` and `https://www.jdrfarm.com`

---

## Method 2: GoDaddy Web Hosting + FTP Upload

If you have GoDaddy web hosting, upload files directly.

### Step 1: Get FTP Credentials from GoDaddy

1. Log in to GoDaddy
2. Go to **My Products** → **Web Hosting** → **Manage**
3. Find **FTP** section and note:
   - FTP Server/Hostname
   - FTP Username
   - FTP Password (or reset it)

### Step 2: Download Repository Files

```bash
# Clone your repository
git clone https://github.com/yourusername/your-repo-name.git
cd your-repo-name
```

### Step 3: Upload Files via FTP

**Option A: Using FileZilla (Free FTP Client)**

1. Download FileZilla: https://filezilla-project.org/
2. Open FileZilla
3. Enter FTP credentials:
   - Host: `ftp.yourdomain.com` (from GoDaddy)
   - Username: Your FTP username
   - Password: Your FTP password
   - Port: 21
4. Click **Quickconnect**
5. Navigate to `public_html` folder (or `httpdocs` on some hosts)
6. Upload all files:
   - `index.html`
   - `styles.css`
   - `script.js`
   - `logo/` folder
   - `image/` folder
7. Ensure `index.html` is in the root of `public_html`

**Option B: Using cPanel File Manager**

1. In GoDaddy hosting, open **cPanel**
2. Go to **File Manager**
3. Navigate to `public_html`
4. Upload files (zip first, then extract in cPanel)

### Step 4: Verify Domain Points to Hosting

1. In GoDaddy DNS settings, ensure:
   ```
   Type: A
   Name: @
   Value: [Your hosting IP from GoDaddy]
   
   Type: CNAME
   Name: www
   Value: yourdomain.com
   ```

---

## Method 3: Automated Deployment with GitHub Actions

Automatically deploy to GoDaddy hosting when you push to GitHub.

### Step 1: Create GitHub Actions Workflow

Create `.github/workflows/deploy.yml` in your repository:

```yaml
name: Deploy to GoDaddy

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Deploy via FTP
        uses: SamKirkland/FTP-Deploy-Action@4.3.0
        with:
          server: ${{ secrets.FTP_SERVER }}
          username: ${{ secrets.FTP_USERNAME }}
          password: ${{ secrets.FTP_PASSWORD }}
          local-dir: ./
          server-dir: /public_html/
```

### Step 2: Add GitHub Secrets

1. Go to your GitHub repo → **Settings** → **Secrets and variables** → **Actions**
2. Click **New repository secret** and add:
   - `FTP_SERVER`: Your FTP hostname
   - `FTP_USERNAME`: Your FTP username
   - `FTP_PASSWORD`: Your FTP password

### Step 3: Push Changes

```bash
git add .github/workflows/deploy.yml
git commit -m "Add automated deployment"
git push
```

Now every push to `main` will automatically deploy to GoDaddy!

---

## Method 4: Using GoDaddy Website Builder (Not Recommended)

If you're using GoDaddy Website Builder, you'll need to manually recreate the site or export/import content. This is not ideal for a GitHub-hosted static site.

---

## Troubleshooting

### Site Not Loading After DNS Changes

1. **Wait longer**: DNS can take up to 48 hours
2. **Clear browser cache**: Ctrl+F5 or Cmd+Shift+R
3. **Check DNS propagation**: https://www.whatsmydns.net
4. **Verify DNS records**: Ensure no conflicting records exist

### HTTPS/SSL Issues

- **GitHub Pages**: SSL is automatic, wait 10-30 minutes after adding custom domain
- **GoDaddy Hosting**: Enable SSL certificate in cPanel or contact GoDaddy support

### Images Not Loading

- Ensure image paths are correct (relative paths like `image/photo.jpg`)
- Check file permissions (should be 644 for files, 755 for folders)
- Verify all files uploaded correctly

### 404 Errors

- Ensure `index.html` is in the root directory (`public_html/`)
- Check `.htaccess` file if using Apache (may need to add: `DirectoryIndex index.html`)

---

## Recommended Approach

**For beginners**: Use **Method 1 (GitHub Pages)** - it's free, easy, and handles SSL automatically.

**For advanced users**: Use **Method 3 (GitHub Actions)** - automated deployments save time.

**If you already have GoDaddy hosting**: Use **Method 2 (FTP Upload)** - makes use of existing hosting.

---

## Quick Checklist

- [ ] Repository is public (for free GitHub Pages) or you have GitHub Pro
- [ ] GitHub Pages is enabled
- [ ] Custom domain is configured in GitHub Pages settings
- [ ] DNS records are updated in GoDaddy
- [ ] Waited for DNS propagation (check with whatsmydns.net)
- [ ] Tested site at both `http://` and `https://` versions
- [ ] All images and assets load correctly

---

## Need Help?

- **GitHub Pages Docs**: https://docs.github.com/en/pages
- **GoDaddy Support**: https://www.godaddy.com/help
- **DNS Check**: https://www.whatsmydns.net

---

**Note**: Replace `yourusername`, `repository-name`, and `jdrfarm.com` with your actual values throughout this guide.
