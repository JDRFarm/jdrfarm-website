# 📝 Update on GitHub & Deploy to Netlify

## ✅ Changes to Make

### 1. Update Order Confirmation Popup
- Contact number: **9150150932**
- Contact email: **info@jdrfarm.com**

### 2. Add WhatsApp Message
- Send WhatsApp message to **9150150932** when order is confirmed
- Include delivery details and order information

---

## 🚀 Update on GitHub (Online)

### Step 1: Go to GitHub Repository

1. **Open:** https://github.com/JDRFarm/jdrfarm-website
2. **Navigate to:** `script.js` file
3. **Click:** Pencil icon (Edit) at top right

### Step 2: Update the Code

**Find this function** (around line 733):
```javascript
async function confirmPayment() {
```

**Replace the entire function** with the updated code that includes:
- Correct contact info in popup (9150150932 and info@jdrfarm.com)
- WhatsApp message sending functionality

### Step 3: Commit Changes

1. **Scroll down** to commit section
2. **Commit message:**
   ```
   Update contact info to 9150150932 and info@jdrfarm.com, add WhatsApp order notification
   ```
3. **Click:** "Commit changes" button

### Step 4: Netlify Auto-Deploys

- ✅ Netlify will **automatically detect** the GitHub push
- ✅ Netlify will **automatically deploy** to your domain
- ✅ Takes **1-2 minutes**

---

## 📋 Code Changes Summary

### Updated Files:
- `script.js` - Order confirmation and WhatsApp functionality

### Changes:
1. ✅ Order popup shows: **9150150932** and **info@jdrfarm.com**
2. ✅ WhatsApp message sent to **9150150932** on order confirmation
3. ✅ WhatsApp includes: Customer details, delivery address, order details

---

## ✅ Verify Deployment

### Check Netlify:
1. Go to: https://app.netlify.com
2. Check "Deploys" tab
3. Look for green checkmark ✅

### Test Live Site:
1. Visit: https://jdrfarm.com
2. Place a test order
3. Complete payment
4. Check popup shows correct contact info
5. Verify WhatsApp message opens

---

## 📱 WhatsApp Message Format

When order is confirmed, WhatsApp message sent to **9150150932** includes:

```
New Order Received

Customer: [Name]
Email: [Email]
Phone: [Phone]

Delivery Address:
[Address]

Order Details:
[Product List]

Total: ₹[Amount]

Special Instructions: [If any]

Please process this order.
```

---

**Ready to update on GitHub!** 🚀

