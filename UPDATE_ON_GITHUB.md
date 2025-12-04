# 🚀 Quick Guide: Update on GitHub & Auto-Deploy to Netlify

## ✅ What's Changed

1. **Order confirmation popup** now shows:
   - Contact: **9150150932**
   - Email: **info@jdrfarm.com**

2. **WhatsApp notification** sent to **9150150932** when order is confirmed

---

## 📝 Update on GitHub (3 Steps)

### Step 1: Open GitHub
**Go to:** https://github.com/JDRFarm/jdrfarm-website

### Step 2: Edit script.js
1. Click **`script.js`** file
2. Click **Pencil icon** (Edit) at top right
3. Find: `async function confirmPayment()` (around line 733)
4. **Replace entire function** with code from `EXACT_CODE_TO_UPDATE.md`

### Step 3: Commit
1. **Commit message:**
   ```
   Update contact info to 9150150932 and info@jdrfarm.com, add WhatsApp order notification
   ```
2. Click **"Commit changes"**

**Done!** Netlify auto-deploys in 1-2 minutes.

---

## 📋 Files to Update

- ✅ `script.js` - Order confirmation and WhatsApp function

---

## ✅ After Deployment

1. **Check Netlify:** https://app.netlify.com → Deploys tab
2. **Test site:** https://jdrfarm.com
3. **Place test order** and verify:
   - Popup shows correct contact info
   - WhatsApp opens with order details

---

**See `EXACT_CODE_TO_UPDATE.md` for the exact code to copy!**

