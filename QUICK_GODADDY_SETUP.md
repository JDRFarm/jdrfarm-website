# ⚡ Quick Setup: GitHub → Netlify → GoDaddy Domain

**Fastest way to get jdrfarm.com live in 15 minutes!**

---

## 🎯 Step 1: Deploy to Netlify (5 minutes)

1. **Go to:** https://app.netlify.com
2. **Sign up/Login** with GitHub
3. Click **"Add new site"** → **"Import an existing project"**
4. Choose **"Deploy with GitHub"**
5. Select your repository (search for it if not listed)
6. Build settings:
   - Build command: *(leave empty)*
   - Publish directory: `/`
7. Click **"Deploy site"**
8. ⏳ Wait 1-2 minutes for deployment

**Result:** Your site is now at `https://random-name-123.netlify.app`

---

## 🌐 Step 2: Add Your Domain (2 minutes)

1. In Netlify, go to: **"Domain settings"**
2. Click **"Add custom domain"**
3. Enter: `jdrfarm.com`
4. Click **"Add domain"**
5. Also add: `www.jdrfarm.com` (repeat above for www)

**Result:** Netlify tells you to configure DNS

---

## 🔧 Step 3: Configure GoDaddy DNS (5 minutes)

1. **Login to GoDaddy:** https://account.godaddy.com
2. Go to: **My Products** → **Domains**
3. Find `jdrfarm.com` → Click **"DNS"** or **"Manage DNS"**
4. **Delete existing A records** for @ (if any)
5. **Add new A record:**
   - Type: `A`
   - Name: `@`
   - Value: `75.2.60.5`
   - TTL: `600 seconds`
   - Click **"Save"**

6. **Add/Update CNAME record for www:**
   - Type: `CNAME`
   - Name: `www`
   - Value: `random-name-123.netlify.app` *(use YOUR Netlify subdomain)*
   - TTL: `600 seconds`
   - Click **"Save"**

**Result:** DNS is configured, now wait for propagation

---

## ⏳ Step 4: Wait for DNS Propagation (1-2 hours)

- DNS changes take **1-2 hours** (sometimes up to 24 hours)
- Check progress: https://dnschecker.org
- Enter: `jdrfarm.com` and check if it points to Netlify

---

## 🔒 Step 5: Enable HTTPS (automatic)

1. After DNS propagates, go back to Netlify
2. Go to: **Domain settings** → **HTTPS**
3. Click **"Verify DNS configuration"**
4. Netlify will automatically issue SSL certificate (5-10 minutes)
5. Enable **"Force HTTPS"**

**Result:** Your site has HTTPS! ✅

---

## ✅ Step 6: Test Your Site

Visit these URLs (all should work):
- https://jdrfarm.com
- https://www.jdrfarm.com
- http://jdrfarm.com (should redirect to HTTPS)

**🎉 DONE! Your GitHub repo is now live on jdrfarm.com!**

---

## 🚀 Automatic Updates

Now when you update your site:

1. **Edit files locally** (index.html, styles.css, etc.)
2. **Save changes**
3. **Your auto-deploy script pushes to GitHub**
4. **Netlify auto-deploys in 1-2 minutes**
5. **Your live site updates!** ✨

No FTP, no manual uploads, completely automatic!

---

## 📋 DNS Records Summary

Your GoDaddy DNS should look like this:

| Type  | Name | Value                        | TTL |
|-------|------|------------------------------|-----|
| A     | @    | 75.2.60.5                   | 600 |
| CNAME | www  | your-site.netlify.app       | 600 |

*(Replace `your-site` with your actual Netlify subdomain)*

---

## 🆘 Quick Troubleshooting

**"Site not loading after 2 hours"**
- Check DNS: https://dnschecker.org
- Make sure you used correct Netlify subdomain in CNAME
- Try clearing browser cache (Ctrl+F5)

**"Not secure" warning**
- Wait for SSL certificate (5-24 hours after DNS works)
- Verify DNS is pointing to Netlify correctly

**"Old site still showing"**
- Clear browser cache
- Try incognito/private window
- May be GoDaddy parking page - wait for DNS propagation

**Need more help?**
- See full guide: `GODADDY_DEPLOYMENT_GUIDE.md`
- Netlify support: https://www.netlify.com/support/

---

## 💡 Pro Tips

1. **Custom Netlify subdomain:**
   - Go to: Site settings → Domain management → Options
   - Change from `random-name-123` to `jdrfarm`
   - Makes it cleaner: `jdrfarm.netlify.app`

2. **Deploy notifications:**
   - Settings → Build & deploy → Deploy notifications
   - Get email when site deploys

3. **Build history:**
   - Deploys tab shows all deployments
   - Can roll back to previous version anytime

---

**That's it! Enjoy your live website! 🎉**
