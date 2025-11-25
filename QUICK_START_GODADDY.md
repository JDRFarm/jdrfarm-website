# Quick Start: Deploy to GoDaddy Domain (5 Minutes)

## Easiest Method: GitHub Pages + GoDaddy DNS

### Step 1: Enable GitHub Pages (2 minutes)

1. Open your GitHub repository
2. Go to **Settings** → **Pages**
3. Under **Source**, select:
   - Branch: `main`
   - Folder: `/ (root)`
4. Click **Save**
5. Copy the GitHub Pages URL (e.g., `https://username.github.io/repo-name`)

### Step 2: Add Custom Domain in GitHub (1 minute)

1. Still in **Pages** settings, scroll to **Custom domain**
2. Type your domain: `jdrfarm.com` (or `www.jdrfarm.com`)
3. Check **Enforce HTTPS**
4. Click **Save**

### Step 3: Update GoDaddy DNS (2 minutes)

1. Log in to **GoDaddy** → **My Products** → **Domains** → Click **DNS**

2. **Add these 4 A records** (for apex domain):
   ```
   Type: A | Name: @ | Value: 185.199.108.153
   Type: A | Name: @ | Value: 185.199.109.153
   Type: A | Name: @ | Value: 185.199.110.153
   Type: A | Name: @ | Value: 185.199.111.153
   ```

3. **Add CNAME record** (for www):
   ```
   Type: CNAME | Name: www | Value: yourusername.github.io
   ```
   *(Replace `yourusername` with your actual GitHub username)*

4. **Remove** any old A or CNAME records that conflict
5. **Save** all changes

### Step 4: Wait & Test

- Wait 5-30 minutes for DNS to propagate
- Visit: `https://jdrfarm.com`
- If it doesn't work, wait up to 24 hours (usually much faster)

### ✅ Done!

Your site is now live at your GoDaddy domain!

---

## Troubleshooting

**Site shows GitHub 404?**
- Wait longer (DNS takes time)
- Check DNS propagation: https://www.whatsmydns.net
- Verify custom domain is set correctly in GitHub Pages

**SSL/HTTPS not working?**
- Wait 10-30 minutes after adding custom domain
- GitHub automatically provisions SSL certificates

**Need more help?**
- See full guide: `GODADDY_DEPLOYMENT_GUIDE.md`
