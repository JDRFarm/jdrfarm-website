# 🔧 Troubleshooting Guide

Common issues and solutions when deploying JDR Farm to jdrfarm.com

---

## 🚨 Quick Diagnosis

### Is your site not loading?

Use this decision tree:

```
Site not loading at jdrfarm.com?
│
├─ Can you access your-site.netlify.app? 
│  │
│  ├─ YES → DNS issue (see section A)
│  └─ NO → Netlify/hosting issue (see section B)
│
└─ Getting SSL/HTTPS error?
   └─ See section C
```

---

## 📍 Section A: DNS Issues

### Problem: Site loads at netlify.app but not jdrfarm.com

**Symptoms:**
- ✅ `your-site.netlify.app` works
- ❌ `jdrfarm.com` doesn't work
- ❌ `www.jdrfarm.com` doesn't work

**Cause:** DNS not configured or not propagated yet

**Solutions:**

#### 1. Check DNS Configuration

**Verify in GoDaddy:**
1. Login to GoDaddy: https://account.godaddy.com
2. Go to: My Products → Domains → jdrfarm.com → DNS
3. Confirm these records exist:

   | Type  | Name | Value |
   |-------|------|-------|
   | A     | @    | 75.2.60.5 |
   | CNAME | www  | your-site.netlify.app |

**If records are wrong:**
- Delete existing A records for @
- Add correct records as shown above
- Save changes
- **Wait 1-2 hours** for DNS propagation

#### 2. Check DNS Propagation

**Use DNS checker:**
1. Visit: https://dnschecker.org
2. Enter: `jdrfarm.com`
3. Select: `A` record type
4. Check results:
   - ✅ Green checkmarks = DNS propagated
   - ❌ Red X = Not propagated yet
   - 🟡 Mixed = Still propagating

**If not propagated:**
- Wait longer (can take up to 48 hours)
- Clear browser cache
- Try different device/network
- Use incognito/private mode

#### 3. Clear DNS Cache

**On your computer:**

**Windows:**
```cmd
ipconfig /flushdns
```

**Mac:**
```bash
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
```

**Linux:**
```bash
sudo systemd-resolve --flush-caches
```

**In your browser:**
- Chrome: chrome://net-internals/#dns → Clear host cache
- Firefox: Clear cache in Settings → Privacy
- Safari: Clear history & website data

#### 4. Test with Different DNS

**Use Google DNS temporarily:**
1. Change computer DNS to: 8.8.8.8 and 8.8.4.4
2. Test if site loads
3. If yes, problem is your ISP's DNS cache

**How to change DNS (Windows):**
1. Control Panel → Network → Change adapter settings
2. Right-click network → Properties
3. Select "Internet Protocol Version 4"
4. Properties → Use these DNS servers:
   - Preferred: 8.8.8.8
   - Alternate: 8.8.4.4

#### 5. Common DNS Mistakes

**❌ Wrong:**
```
A @ 192.168.1.1 (private IP)
CNAME www your-site.com (without .netlify.app)
```

**✅ Correct:**
```
A @ 75.2.60.5
CNAME www your-site.netlify.app
```

**❌ Common mistakes:**
- Typo in Netlify subdomain
- Using IP instead of domain for CNAME
- Multiple conflicting A records
- Forgot to save DNS changes

---

## 📍 Section B: Netlify/Hosting Issues

### Problem: Site doesn't load on netlify.app subdomain

**Symptoms:**
- ❌ `your-site.netlify.app` doesn't work
- ❌ 404 or blank page
- ❌ Build failed

**Solutions:**

#### 1. Check Deployment Status

**In Netlify:**
1. Go to: https://app.netlify.com
2. Select your site
3. Click: "Deploys" tab
4. Check latest deployment:
   - 🟢 Published = Success
   - 🔴 Failed = Build error
   - 🟡 Building = In progress

**If failed:**
- Click on failed deployment
- Read error message
- See "Build Errors" section below

#### 2. Verify Repository Connection

**Check GitHub connection:**
1. In Netlify: Site settings → Build & deploy → Build settings
2. Verify:
   - ✅ Repository: Correct repo selected
   - ✅ Branch: `main` or correct branch
   - ✅ Build command: Empty (for static site)
   - ✅ Publish directory: `/` or `.`

**If disconnected:**
- Site settings → Build & deploy → Link to repository
- Reconnect GitHub account
- Select correct repository

#### 3. Check File Structure

**Verify in GitHub:**
1. Go to your repository
2. Confirm `index.html` is in root (not in subfolder)
3. Confirm file structure:
   ```
   /
   ├── index.html (must be here!)
   ├── styles.css
   ├── script.js
   ├── logo/
   └── image/
   ```

**If index.html is in subfolder:**
- Move to root, or
- Change publish directory in Netlify to match

#### 4. Manual Deployment

**Force redeploy:**
1. In Netlify: Deploys tab
2. Click: "Trigger deploy" → "Deploy site"
3. Wait for deployment to complete

#### 5. Check Build Logs

**Review logs:**
1. In Netlify: Deploys → Click deployment
2. Expand: "Deploy log"
3. Look for errors (red text)
4. Common issues:
   - Missing files
   - Wrong publish directory
   - Large file size errors

---

## 📍 Section C: SSL/HTTPS Issues

### Problem: "Not Secure" or SSL certificate errors

**Symptoms:**
- ⚠️ "Not secure" in browser
- ❌ SSL certificate error
- ❌ Mixed content warning
- ❌ HTTPS not working

**Solutions:**

#### 1. Wait for Certificate Issuance

**How long it takes:**
- After DNS propagates: 5-24 hours
- Usually: Within 2-4 hours

**Check status in Netlify:**
1. Site settings → Domain management → HTTPS
2. Status should show:
   - ✅ "Certificate active" = Working
   - 🟡 "Provisioning certificate" = In progress
   - ❌ "Certificate error" = Problem

**If provisioning:**
- Just wait (can take up to 24 hours)
- Make sure DNS is correctly configured
- Try "Renew certificate" button

#### 2. Verify DNS Configuration

**Certificate needs correct DNS:**
1. DNS must point to Netlify
2. Both A and CNAME records must be correct
3. Use https://dnschecker.org to verify
4. All regions should show Netlify IP

**If DNS wrong:**
- Fix DNS records first
- Wait for propagation
- Certificate will auto-issue after

#### 3. Force SSL Certificate Renewal

**In Netlify:**
1. Site settings → Domain management → HTTPS
2. Click: "Verify DNS configuration"
3. If verified, click: "Renew certificate"
4. Wait 10-30 minutes

#### 4. Enable Force HTTPS

**After certificate is active:**
1. Site settings → Domain management → HTTPS
2. Enable: "Force HTTPS"
3. This redirects HTTP → HTTPS automatically

#### 5. Mixed Content Errors

**Problem:** Page loads but some content blocked

**Cause:** Your page loads HTTPS but references HTTP resources

**Find the issue:**
1. Open browser console (F12)
2. Look for "Mixed content" warnings
3. Find which resources use HTTP

**Fix:**
1. Change `http://` to `https://` in your HTML/CSS
2. Or use protocol-relative URLs: `//example.com/file.js`
3. Example:
   ```html
   <!-- ❌ Wrong -->
   <script src="http://example.com/script.js"></script>
   
   <!-- ✅ Correct -->
   <script src="https://example.com/script.js"></script>
   ```

---

## 📍 Section D: Build & Deployment Errors

### Problem: Netlify build fails

**Common errors:**

#### Error: "Deploy did not succeed: Failed during build"

**Cause:** Usually file not found or wrong publish directory

**Solution:**
1. Check Netlify build settings
2. Set publish directory to: `/` or `.`
3. Ensure `index.html` is in root of repo

#### Error: "No publish directory found"

**Solution:**
```
Site settings → Build & deploy → Build settings
→ Publish directory: change to "/"
```

#### Error: "index.html not found"

**Solution:**
1. Check GitHub repo: Is `index.html` in root?
2. Check filename: Is it exactly `index.html`? (lowercase)
3. Not: `Index.html` or `index.htm`

#### Error: "File too large"

**Netlify limits:**
- Max file size: 100MB
- Max site size: 500MB (free plan)

**Solution:**
1. Compress large images
2. Remove unnecessary files
3. Use image optimization tools

**Compress images:**
- TinyPNG: https://tinypng.com
- Squoosh: https://squoosh.app
- ImageOptim (Mac)

---

## 📍 Section E: GitHub Issues

### Problem: Auto-deploy not working

**Symptoms:**
- You push to GitHub
- Netlify doesn't deploy automatically
- Manual trigger works

**Solutions:**

#### 1. Check GitHub Webhook

**In Netlify:**
1. Site settings → Build & deploy → Build hooks
2. Should see GitHub webhook configured

**In GitHub:**
1. Repository → Settings → Webhooks
2. Should see Netlify webhook
3. Check "Recent Deliveries" for errors

**If webhook missing:**
- Reconnect repository in Netlify
- Site settings → Build & deploy → Link repository

#### 2. Check Branch Name

**Verify:**
1. In Netlify: Check which branch is tracked
2. In GitHub: Check which branch you're pushing to
3. They must match!

**Common issue:**
- Netlify tracks `main`
- You push to `master`
- No deployment triggered

**Fix:**
```bash
# Check current branch
git branch

# If on master, rename to main
git branch -m master main
git push -u origin main
```

#### 3. GitHub Repository Access

**Verify Netlify has access:**
1. GitHub → Settings → Applications
2. Find: Netlify
3. Ensure it has access to your repo

**If not:**
- In Netlify: Site settings → Build & deploy
- Click: "Link to a different repository"
- Re-authorize GitHub access

---

## 📍 Section F: Page Display Issues

### Problem: Page loads but looks broken

**Symptoms:**
- Page loads but no styling
- Images don't show
- Layout broken

**Solutions:**

#### 1. CSS Not Loading

**Check in browser (F12 → Network tab):**
- Is `styles.css` loading?
- 404 error? File not found
- 200 OK? File loads successfully

**If 404:**
```html
<!-- ❌ Wrong path -->
<link rel="stylesheet" href="/stylesheets/styles.css">

<!-- ✅ Correct path -->
<link rel="stylesheet" href="styles.css">
```

**Fix:**
1. Verify file location in GitHub repo
2. Update path in `index.html`
3. Use relative paths, not absolute

#### 2. Images Not Loading

**Check image paths:**
```html
<!-- ❌ Wrong (absolute path) -->
<img src="/Users/you/Desktop/image/product.jpg">

<!-- ❌ Wrong (Windows path) -->
<img src="C:\Users\you\image\product.jpg">

<!-- ✅ Correct (relative path) -->
<img src="image/product.jpg">
```

**Case sensitivity:**
- ❌ `<img src="Image/Product.jpg">` (wrong case)
- ✅ `<img src="image/product.jpg">` (matches folder/file)

**Remember:** Linux servers (Netlify) are case-sensitive!

#### 3. JavaScript Not Working

**Check console (F12):**
- Look for JavaScript errors
- Common issues:
  - File path wrong
  - Syntax errors
  - Missing dependencies

**Fix:**
```html
<!-- ❌ Wrong -->
<script src="/js/script.js"></script>

<!-- ✅ Correct -->
<script src="script.js"></script>
```

---

## 📍 Section G: Performance Issues

### Problem: Site loads slowly

**Solutions:**

#### 1. Optimize Images

**Current image sizes:**
- Check file sizes of images in your repo
- Large images (>500KB) slow down site

**Compress images:**
1. Use: https://tinypng.com
2. Compress all images in `image/` and `logo/`
3. Replace in repo
4. Push to GitHub

**Target sizes:**
- Product images: <100KB
- Logo: <50KB
- Background images: <200KB

#### 2. Enable Caching

**Already configured!**
- Your `netlify.toml` file sets up caching
- Browsers cache CSS/JS/images for 1 year
- Return visitors load instantly

#### 3. Check Netlify Analytics

**In Netlify:**
1. Go to: Analytics tab
2. Check:
   - Load times
   - Slow pages
   - Large assets

---

## 📍 Section H: Domain-Specific Issues

### Problem: www vs non-www issues

**Symptoms:**
- `jdrfarm.com` works but `www.jdrfarm.com` doesn't
- Or vice versa

**Solution:**

**Ensure both DNS records exist:**
```
A     @    75.2.60.5
CNAME www  your-site.netlify.app
```

**In Netlify:**
1. Add both domains:
   - `jdrfarm.com`
   - `www.jdrfarm.com`
2. Set one as primary
3. Other will redirect automatically

### Problem: GoDaddy parking page shows

**Symptoms:**
- See GoDaddy "parked domain" page
- Not your website

**Cause:** DNS still pointing to GoDaddy hosting

**Solution:**
1. Check DNS records in GoDaddy
2. Make sure A record points to: `75.2.60.5`
3. Not pointing to GoDaddy IP
4. Clear browser cache
5. Wait for DNS propagation

---

## 📍 Section I: FTP/GoDaddy Hosting Issues

### Problem: FTP deployment fails (GitHub Actions)

**Error: "Authentication failed"**

**Solution:**
1. Verify FTP credentials in GoDaddy
2. Update GitHub Secrets:
   - `FTP_SERVER`
   - `FTP_USERNAME`
   - `FTP_PASSWORD`
3. Make sure no typos
4. Username format: `user@jdrfarm.com`

**Error: "Connection timeout"**

**Solution:**
1. Check FTP server address
2. Try IP address instead of domain
3. Test with FileZilla first
4. Verify port 21 is accessible

**Error: "Directory not found"**

**Solution:**
1. Check correct upload directory
2. Common paths:
   - `/public_html/`
   - `/htdocs/`
   - `/www/`
3. Update in workflow file

---

## 📍 Section J: Email Issues

### Problem: Email stopped working after DNS change

**Symptoms:**
- Website works fine
- Email bounces or doesn't receive

**Cause:** MX records may have been deleted

**Solution:**

**Restore MX records in GoDaddy DNS:**
1. Go to GoDaddy DNS management
2. Check if MX records exist
3. If missing, add GoDaddy email MX records:

   | Type | Name | Priority | Value |
   |------|------|----------|-------|
   | MX   | @    | 0        | smtp.secureserver.net |
   | MX   | @    | 10       | mailstore1.secureserver.net |

**Important:** Website (A/CNAME) and Email (MX) records are independent!
- You can host website on Netlify
- And email on GoDaddy
- Both work together

---

## 🔍 Diagnostic Tools

### Essential Tools for Troubleshooting

**1. DNS Checker**
- URL: https://dnschecker.org
- Use: Check DNS propagation worldwide
- Enter: jdrfarm.com

**2. SSL Checker**
- URL: https://www.sslshopper.com/ssl-checker.html
- Use: Verify SSL certificate is valid
- Enter: https://jdrfarm.com

**3. Website Speed Test**
- URL: https://pagespeed.web.dev
- Use: Check site performance
- Enter: https://jdrfarm.com

**4. Browser DevTools**
- Press: F12 (Chrome/Firefox/Edge)
- Console tab: See JavaScript errors
- Network tab: See loading issues
- Elements tab: Inspect HTML/CSS

**5. What's My DNS**
- URL: https://whatsmydns.net
- Use: Check DNS records globally
- Enter: jdrfarm.com

---

## 📞 Getting Help

### Still stuck? Here's what to do:

#### 1. Gather Information

Before asking for help, collect:
- ✅ Your domain name
- ✅ Which deployment method (Netlify/GitHub Pages/GoDaddy)
- ✅ Error messages (exact text or screenshots)
- ✅ What you've already tried
- ✅ When the problem started

#### 2. Check Documentation

- **Netlify:** https://docs.netlify.com
- **GitHub Pages:** https://docs.github.com/pages
- **GoDaddy:** https://www.godaddy.com/help

#### 3. Community Support

- **Netlify Community:** https://answers.netlify.com
- **GitHub Community:** https://github.community
- **Stack Overflow:** Tag: netlify, github-pages, dns

#### 4. Official Support

- **Netlify Support:** https://www.netlify.com/support/
- **GoDaddy Support:** https://www.godaddy.com/help
  - Phone: 1-480-505-8877
  - Chat: Available in GoDaddy account

---

## ✅ Quick Checklist

Use this to diagnose your issue:

### Website Not Loading
- [ ] Is it live on Netlify subdomain (e.g., your-site.netlify.app)?
- [ ] Is DNS configured correctly in GoDaddy?
- [ ] Has enough time passed for DNS propagation (1-2 hours)?
- [ ] Have you cleared browser cache?
- [ ] Does DNS checker show correct records?

### SSL/HTTPS Issues
- [ ] Is DNS pointing to Netlify?
- [ ] Has it been 24 hours since DNS configuration?
- [ ] Is certificate showing as "Active" in Netlify?
- [ ] Have you enabled "Force HTTPS"?

### Broken Layout/Images
- [ ] Are file paths relative, not absolute?
- [ ] Are filenames case-sensitive correct?
- [ ] Is index.html in root of repository?
- [ ] Are all files pushed to GitHub?

### Auto-Deploy Not Working
- [ ] Is repository connected to Netlify?
- [ ] Is correct branch being tracked?
- [ ] Is webhook configured in GitHub?
- [ ] Have you pushed to the correct branch?

---

## 💪 Prevention Tips

Avoid common issues:

### Before Deploying
1. ✅ Test website locally (open index.html)
2. ✅ Verify all images load
3. ✅ Check all links work
4. ✅ Push everything to GitHub
5. ✅ No absolute file paths

### During Setup
1. ✅ Write down all settings
2. ✅ Screenshot DNS configuration
3. ✅ Save Netlify site name
4. ✅ Double-check typos in DNS
5. ✅ Note when you made DNS changes

### After Deployment
1. ✅ Test on multiple devices
2. ✅ Test on mobile
3. ✅ Test different browsers
4. ✅ Check HTTPS works
5. ✅ Verify email still works

---

## 🎯 Most Common Issues (Quick Reference)

**1. "DNS not working after 2 hours"**
→ Clear cache, try incognito, check https://dnschecker.org

**2. "Site shows GoDaddy parking page"**
→ Check A record points to 75.2.60.5, not GoDaddy IP

**3. "Images not loading"**
→ Check file paths are relative and case matches exactly

**4. "HTTPS not working"**
→ Wait 24 hours after DNS propagates, then check Netlify HTTPS settings

**5. "Auto-deploy not triggering"**
→ Check webhook in GitHub, verify branch name matches

---

**Still need help?** Go to: [`START_HERE.md`](START_HERE.md) and start fresh!
