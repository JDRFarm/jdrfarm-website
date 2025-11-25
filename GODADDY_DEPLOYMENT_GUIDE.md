# 🚀 How to Publish GitHub Repo to GoDaddy Domain

This guide shows you how to deploy your JDR Farm website from GitHub to your GoDaddy domain (jdrfarm.com).

## 📋 Overview of Options

You have **3 main options** to connect your GitHub repo to your GoDaddy domain:

1. **Option 1: Netlify + GoDaddy Domain** (Recommended - Easiest & Free)
2. **Option 2: GitHub Pages + GoDaddy Domain** (Free & Simple)
3. **Option 3: GoDaddy Web Hosting** (Traditional Hosting)

---

## ✅ Option 1: Netlify + GoDaddy Domain (RECOMMENDED)

This is the easiest and most modern approach. Your site auto-deploys when you push to GitHub!

### Step 1: Deploy to Netlify

1. **Go to Netlify:**
   - Visit: https://app.netlify.com
   - Sign up/login with GitHub

2. **Import Your Repository:**
   - Click "Add new site" → "Import an existing project"
   - Choose "Deploy with GitHub"
   - Select your repository: `jdrfarm-website`
   - Build settings:
     - Build command: (leave empty)
     - Publish directory: `/` or `.` (root directory)
   - Click "Deploy site"

3. **Wait for Deployment:**
   - Your site will deploy in 1-2 minutes
   - You'll get a temporary URL like: `random-name-123.netlify.app`

### Step 2: Connect Your GoDaddy Domain

1. **Get Netlify DNS Settings:**
   - In Netlify, go to: **Site settings** → **Domain management**
   - Click "Add custom domain"
   - Enter: `jdrfarm.com`
   - Netlify will show you DNS records to configure

2. **Update GoDaddy DNS Settings:**
   - Login to GoDaddy: https://account.godaddy.com
   - Go to: **My Products** → **Domains**
   - Click on `jdrfarm.com` → **DNS** → **Manage DNS**

3. **Add Netlify DNS Records:**
   
   **Option A: Use Netlify DNS (Easiest):**
   - In Netlify: Copy the Netlify nameservers (e.g., `dns1.p03.nsone.net`)
   - In GoDaddy: Click "Change" next to Nameservers
   - Select "Custom" and paste Netlify nameservers
   - Save changes
   - **Wait 24-48 hours for DNS propagation**

   **Option B: Keep GoDaddy DNS (Faster):**
   - In GoDaddy DNS settings, add these records:
   
   | Type  | Name | Value | TTL |
   |-------|------|-------|-----|
   | A     | @    | 75.2.60.5 | 600 |
   | CNAME | www  | [your-site].netlify.app | 600 |

   - Replace `[your-site]` with your Netlify subdomain
   - Save changes
   - **Wait 1-2 hours for DNS propagation**

4. **Enable HTTPS:**
   - In Netlify: Go to **Domain settings** → **HTTPS**
   - Click "Verify DNS configuration"
   - Enable "Force HTTPS"
   - SSL certificate will be issued automatically (free!)

### Step 3: Test Your Site
- Visit: https://jdrfarm.com
- Visit: https://www.jdrfarm.com
- Both should work with HTTPS! ✅

### ✨ Benefits of Option 1:
- ✅ Free hosting with unlimited bandwidth
- ✅ Auto-deploy on every GitHub push
- ✅ Free SSL certificate (HTTPS)
- ✅ CDN for fast global loading
- ✅ No server maintenance needed

---

## 🌐 Option 2: GitHub Pages + GoDaddy Domain

Free hosting directly from GitHub!

### Step 1: Enable GitHub Pages

1. **Go to Your Repository:**
   - Visit: https://github.com/YOUR_USERNAME/jdrfarm-website
   - Go to: **Settings** → **Pages**

2. **Configure GitHub Pages:**
   - Source: `Deploy from a branch`
   - Branch: Select `main` and `/` (root)
   - Click "Save"

3. **Wait for Deployment:**
   - GitHub will deploy your site in 1-2 minutes
   - Your site will be at: `https://YOUR_USERNAME.github.io/jdrfarm-website`

### Step 2: Add Custom Domain

1. **In GitHub Pages Settings:**
   - Under "Custom domain", enter: `jdrfarm.com`
   - Click "Save"
   - Check "Enforce HTTPS" (after DNS is configured)

2. **This creates a CNAME file in your repo**

### Step 3: Configure GoDaddy DNS

1. **Login to GoDaddy:**
   - Go to: https://account.godaddy.com
   - Navigate to: **My Products** → **Domains** → `jdrfarm.com`
   - Click **DNS** → **Manage DNS**

2. **Add DNS Records:**

   | Type  | Name | Value | TTL |
   |-------|------|-------|-----|
   | A     | @    | 185.199.108.153 | 600 |
   | A     | @    | 185.199.109.153 | 600 |
   | A     | @    | 185.199.110.153 | 600 |
   | A     | @    | 185.199.111.153 | 600 |
   | CNAME | www  | YOUR_USERNAME.github.io | 600 |

3. **Save and Wait:**
   - DNS propagation takes 1-24 hours
   - Check status: https://dnschecker.org

### Step 4: Test Your Site
- Visit: https://jdrfarm.com
- Should show your website! ✅

### ✨ Benefits of Option 2:
- ✅ Completely free
- ✅ Auto-deploy from GitHub
- ✅ Free SSL certificate
- ✅ Simple setup

### ⚠️ Limitations:
- ❌ No server-side processing
- ❌ Limited to static sites only
- ❌ 1GB storage limit

---

## 🖥️ Option 3: GoDaddy Web Hosting

Traditional hosting using GoDaddy's servers.

### Prerequisites:
- You need a **GoDaddy Web Hosting plan** (not just domain)
- Plans start at $5.99/month for shared hosting
- If you don't have hosting yet: https://www.godaddy.com/hosting/web-hosting

### Step 1: Access Your Hosting

1. **Login to GoDaddy:**
   - Go to: https://account.godaddy.com
   - Navigate to: **My Products** → **Web Hosting**

2. **Access cPanel or File Manager:**
   - Click "Manage" next to your hosting plan
   - Click "cPanel Admin" or "File Manager"

### Step 2: Upload Your Files

**Method A: Using File Manager (Web-based)**

1. In cPanel/File Manager:
   - Navigate to: `public_html` folder
   - Delete any default files (index.html, etc.)

2. Upload your files:
   - Click "Upload"
   - Upload all files from your project:
     - `index.html`
     - `styles.css`
     - `script.js`
     - `logo/` folder
     - `image/` folder

**Method B: Using FTP (Recommended)**

1. **Get FTP Credentials:**
   - In GoDaddy cPanel, find "FTP Accounts"
   - Create or note your FTP credentials:
     - Host: `ftp.jdrfarm.com` or IP address
     - Username: `username@jdrfarm.com`
     - Password: Your FTP password
     - Port: 21

2. **Install FTP Client:**
   - Download FileZilla: https://filezilla-project.org
   - Or use WinSCP (Windows) or Cyberduck (Mac)

3. **Connect via FTP:**
   - Open FileZilla
   - Enter your FTP credentials
   - Click "Quickconnect"

4. **Upload Files:**
   - On left: Your local computer
   - On right: GoDaddy server
   - Navigate to `public_html` folder on server
   - Drag and drop all your files from local to server:
     - `index.html`
     - `styles.css`
     - `script.js`
     - `logo/` folder (with all images)
     - `image/` folder (with all images)

### Step 3: Configure Domain

1. **Check Domain Connection:**
   - In GoDaddy: **My Products** → **Domains**
   - Ensure `jdrfarm.com` points to your hosting
   - Usually automatic if hosting and domain are both on GoDaddy

2. **If domain is not connected:**
   - Go to Domain DNS settings
   - Add A record pointing to hosting IP address
   - Contact GoDaddy support for hosting IP

### Step 4: Test Your Site
- Visit: https://jdrfarm.com
- Your website should be live! ✅

### 🔄 Keeping Site Updated

Since you're using FTP, updates are manual:

**Option A: Manual FTP Upload**
- Edit files locally
- Upload changed files via FTP

**Option B: Automated Script** (Advanced)
- Use GitHub Actions to auto-deploy to FTP
- Create `.github/workflows/deploy.yml` in your repo:

```yaml
name: Deploy to GoDaddy FTP

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    
    - name: FTP Deploy
      uses: SamKirkland/FTP-Deploy-Action@4.3.0
      with:
        server: ftp.jdrfarm.com
        username: ${{ secrets.FTP_USERNAME }}
        password: ${{ secrets.FTP_PASSWORD }}
        local-dir: ./
        server-dir: /public_html/
```

Then add FTP credentials as GitHub secrets:
- Repository → Settings → Secrets → New secret
- Add: `FTP_USERNAME` and `FTP_PASSWORD`

### ✨ Benefits of Option 3:
- ✅ Full control over server
- ✅ Can use PHP, databases, etc.
- ✅ Traditional hosting approach
- ✅ GoDaddy support available

### ⚠️ Disadvantages:
- ❌ Costs money (hosting plan required)
- ❌ Manual updates (unless you set up automation)
- ❌ Need to manage server security
- ❌ Slower than CDN-based solutions

---

## 🎯 Which Option Should You Choose?

### Choose **Option 1 (Netlify)** if:
- ✅ You want the easiest setup
- ✅ You want automatic deployments from GitHub
- ✅ You want free hosting and SSL
- ✅ You want best performance (CDN)
- ✅ **RECOMMENDED for your case!**

### Choose **Option 2 (GitHub Pages)** if:
- ✅ You want everything completely free
- ✅ You want simple GitHub integration
- ✅ You don't need server-side code

### Choose **Option 3 (GoDaddy Hosting)** if:
- ✅ You already have GoDaddy hosting
- ✅ You need server-side features (PHP, databases)
- ✅ You prefer traditional hosting
- ✅ You need email hosting from same provider

---

## 🆘 Troubleshooting

### "Domain not working after DNS changes"
- **Wait:** DNS propagation takes 1-48 hours
- **Check:** Use https://dnschecker.org to verify DNS
- **Clear cache:** Clear browser cache or try incognito mode

### "SSL certificate not working"
- **Wait:** Certificate issuance takes 1-24 hours
- **Verify:** DNS must be pointing to hosting first
- **Force HTTPS:** Enable in Netlify/GitHub Pages settings

### "Images not loading"
- **Check paths:** Ensure image paths are correct in HTML
- **Case sensitive:** Linux servers are case-sensitive (`Logo.jpeg` ≠ `logo.jpeg`)
- **Upload all files:** Make sure all image folders are uploaded

### "Site shows old version"
- **Clear cache:** Hard refresh with Ctrl+F5
- **Check deployment:** Verify latest code is on GitHub
- **Wait:** Netlify/GitHub Pages need 1-2 minutes to deploy

### "Email not working"
- GoDaddy domain used for Netlify/GitHub Pages won't have email automatically
- **Solution:** Keep GoDaddy email hosting separate
- Configure email MX records in DNS (won't affect website)

---

## 📝 Quick Start Recommendations

For your JDR Farm website, I recommend **Option 1: Netlify + GoDaddy Domain**

### Why?
1. ✅ **Automatic deployments** - Your auto-deploy scripts already work with GitHub
2. ✅ **Free** - No hosting costs
3. ✅ **Fast** - CDN makes site load fast globally
4. ✅ **SSL included** - Free HTTPS certificate
5. ✅ **Easy updates** - Just push to GitHub, site auto-updates!

### 5-Minute Setup:
1. Sign up: https://app.netlify.com
2. Import your GitHub repo
3. Add custom domain: `jdrfarm.com`
4. Update GoDaddy DNS to point to Netlify
5. Done! Your site is live 🎉

---

## 📞 Need Help?

- **Netlify Support:** https://www.netlify.com/support/
- **GoDaddy Support:** https://www.godaddy.com/help
- **GitHub Pages Docs:** https://docs.github.com/pages
- **DNS Checker:** https://dnschecker.org

---

## ✅ Final Checklist

- [ ] Choose deployment method (Netlify/GitHub Pages/GoDaddy Hosting)
- [ ] Set up hosting account (if needed)
- [ ] Configure domain DNS in GoDaddy
- [ ] Wait for DNS propagation (1-48 hours)
- [ ] Verify site loads at jdrfarm.com
- [ ] Enable HTTPS/SSL
- [ ] Test all pages and images
- [ ] Set up automatic deployments
- [ ] Clear old cached versions

---

**Good luck with your deployment! 🚀**

Your JDR Farm website will be live on jdrfarm.com soon!
