# 🚀 Push Latest Changes to Domain

## Changes Ready to Push

✅ **Updated Files:**
- `index.html` - Phone number updated: `9150150932` → `9150830025`
- `CNAME` - Merge conflict fixed, now contains: `jdrfarm.com`

## 📤 Method 1: Using GitHub Desktop (Easiest)

### Steps:
1. **Open GitHub Desktop** (or run `push-latest-changes.bat`)
2. **Select repository:** `jdrfarm-website`
3. **Check "Changes" tab:**
   - You should see:
     - `index.html` (modified)
     - `CNAME` (modified)
4. **Commit message:**
   ```
   Update phone number to 9150830025 and fix CNAME
   ```
5. **Click:** "Commit to main"
6. **Click:** "Push origin" (top right button)
7. **Wait** for push to complete (shows "Pushed to origin/main")

### After Push:
- ✅ Changes are on GitHub
- ✅ Netlify will auto-deploy (if connected)
- ✅ Site updates in 1-2 minutes

---

## 📤 Method 2: Using GitHub Website

### Steps:
1. **Go to:** https://github.com/JDRFarm/jdrfarm-website
2. **Click on:** `index.html`
3. **Click:** Pencil icon (✏️) to edit
4. **Update phone number:**
   - Find: `9150150932` or `919150150932`
   - Replace with: `9150830025` or `919150830025`
   - In these locations:
     - Line ~181: Phone link
     - Line ~185: WhatsApp link
     - Line ~251: Floating WhatsApp button
5. **Scroll down** → Commit message:
   ```
   Update phone number to 9150830025
   ```
6. **Click:** "Commit changes"
7. **Repeat for CNAME:**
   - Click on: `CNAME`
   - Edit icon (✏️)
   - Ensure it only contains: `jdrfarm.com` (no merge conflict markers)
   - Commit message: `Fix CNAME merge conflict`
   - Commit changes

---

## 📤 Method 3: Using Git Command Line

If you have Git installed:

```bash
cd D:\AI\web\jdrfarm-website
git add index.html CNAME
git commit -m "Update phone number to 9150830025 and fix CNAME"
git push origin main
```

---

## ✅ Verify Push Was Successful

### Check GitHub:
1. Go to: https://github.com/JDRFarm/jdrfarm-website
2. Check latest commit:
   - Should see: "Update phone number to 9150830025 and fix CNAME"
   - Should see: `index.html` and `CNAME` in commit

### Check Netlify Deployment:
1. Go to: https://app.netlify.com
2. Click on your site
3. Go to: **Deploys** tab
4. Should see new deployment starting automatically
5. Wait 1-2 minutes for "Published" status

### Check Live Site:
1. Wait 2-3 minutes after Netlify deployment
2. Visit: https://jdrfarm.com
3. Check contact section:
   - Phone should show: `+91 9150830025`
   - WhatsApp links should use: `919150830025`

---

## 🔍 What Changed

### Phone Number Updates:
- **Old:** `9150150932` / `919150150932`
- **New:** `9150830025` / `919150830025`

### Updated Locations:
1. **Contact Section Phone Link:**
   ```html
   <a href="tel:+919150830025">+91 9150830025</a>
   ```

2. **Contact Section WhatsApp Link:**
   ```html
   <a href="https://wa.me/919150830025" target="_blank">Chat with us on WhatsApp</a>
   ```

3. **Floating WhatsApp Button:**
   ```html
   <a href="https://wa.me/919150830025" target="_blank" class="whatsapp-float">
   ```

### CNAME File:
- **Before:** Had merge conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
- **After:** Clean file with just `jdrfarm.com`

---

## 🚨 If Netlify Doesn't Auto-Deploy

### Check:
1. **Is GitHub connected?**
   - Netlify → Site settings → Build & deploy → Continuous Deployment
   - Should show: ✅ GitHub connected

2. **Is auto-publish enabled?**
   - Toggle should be ON

3. **Manual trigger:**
   - Netlify → Deploys tab
   - Click: "Trigger deploy" → "Deploy site"

---

## 📞 Need Help?

If push fails:
- Check: `QUICK_FIX_DEPLOYMENT.md`
- Check: `FIX_DEPLOYMENT_ISSUE.md`
- Or use GitHub Desktop (easiest method)

---

**Ready to push? Run `push-latest-changes.bat` or use GitHub Desktop! 🚀**

