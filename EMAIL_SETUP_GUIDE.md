# 📧 Email Setup Guide - Order Notifications

## Overview

When customers complete payment, order details are automatically sent to **info@jdrfarm.com** with:
- Customer name, email, phone
- Delivery address
- Order details (products and quantities)
- Total amount

---

## 🚀 Setup Options

### Option 1: Formspree (Easiest - Recommended)

**Free tier:** 50 submissions/month

#### Steps:

1. **Go to:** https://formspree.io
2. **Sign up** (free account)
3. **Create new form:**
   - Click "New Form"
   - Form name: "JDR Farm Orders"
4. **Get your form ID:**
   - Copy the form endpoint (e.g., `https://formspree.io/f/YOUR_FORM_ID`)
   - Extract the form ID (the part after `/f/`)

5. **Update script.js:**
   - Find: `'https://formspree.io/f/YOUR_FORM_ID'`
   - Replace `YOUR_FORM_ID` with your actual form ID

6. **Test:**
   - Place a test order
   - Check Formspree dashboard for submissions
   - Check your email: info@jdrfarm.com

---

### Option 2: EmailJS (More Control)

**Free tier:** 200 emails/month

#### Steps:

1. **Go to:** https://www.emailjs.com
2. **Sign up** (free account)
3. **Add Email Service:**
   - Dashboard → Email Services
   - Click "Add New Service"
   - Choose "Gmail" or "Outlook"
   - Connect your email: info@jdrfarm.com
   - Copy **Service ID**

4. **Create Email Template:**
   - Dashboard → Email Templates
   - Click "Create New Template"
   - Template name: "Order Notification"
   - To Email: `info@jdrfarm.com`
   - Subject: `New Order from {{customer_name}}`
   - Content:
   ```
   New Order Received

   Customer Details:
   Name: {{customer_name}}
   Email: {{customer_email}}
   Phone: {{customer_phone}}
   Delivery Address: {{delivery_address}}
   Special Instructions: {{special_instructions}}

   Order Details:
   {{order_details}}

   Total Amount: {{total_amount}}
   Order Date: {{order_date}}

   Please process this order and arrange delivery.
   ```
   - Copy **Template ID**

5. **Get Public Key:**
   - Dashboard → Account → General
   - Copy **Public Key**

6. **Update script.js:**
   - Add before `</script>` tag in index.html:
   ```javascript
   <script>
       window.EMAILJS_SERVICE_ID = 'YOUR_SERVICE_ID';
       window.EMAILJS_TEMPLATE_ID = 'YOUR_TEMPLATE_ID';
       emailjs.init('YOUR_PUBLIC_KEY');
   </script>
   ```
   - Replace with your actual IDs

---

### Option 3: Mailto Fallback (No Setup Required)

**Current setup:** Already works!

- Opens email client with pre-filled order details
- Customer needs to click "Send"
- Works without any service setup

**Note:** This is already implemented as fallback.

---

## ✅ Current Implementation

The system tries in this order:

1. **EmailJS** (if configured)
2. **Formspree** (if form ID added)
3. **Mailto link** (always works as fallback)

---

## 🔧 Quick Setup (Formspree - Recommended)

### Step 1: Create Formspree Account
1. Visit: https://formspree.io
2. Sign up (free)
3. Create new form
4. Copy form ID

### Step 2: Update Code
1. Open: `jdrfarm-website/script.js`
2. Find line with: `'https://formspree.io/f/YOUR_FORM_ID'`
3. Replace `YOUR_FORM_ID` with your actual form ID
4. Save file

### Step 3: Test
1. Deploy to GitHub/Netlify
2. Place a test order
3. Check Formspree dashboard
4. Check email: info@jdrfarm.com

---

## 📋 Email Content Format

The email sent to info@jdrfarm.com includes:

```
Subject: New Order from [Customer Name]

New Order Received

Customer Details:
Name: [Name]
Email: [Email]
Phone: [Phone]
Delivery Address: [Address]
Special Instructions: [Instructions]

Order Details:
[Product 1] - ₹[Price]
[Product 2] - ₹[Price]

Total Amount: ₹[Total]
Order Date: [Date and Time]
```

---

## 🧪 Testing

### Test Order Flow:

1. **Add products to cart**
2. **Fill delivery form:**
   - Name, Email, Phone, Address
3. **Click "Place Order"**
4. **QR code appears** with UPI: jdmobacc-4@okhdfcback
5. **Click "I Have Completed the Payment"**
6. **Email sent automatically** to info@jdrfarm.com

### Verify Email:

- Check Formspree dashboard (if using Formspree)
- Check EmailJS dashboard (if using EmailJS)
- Check info@jdrfarm.com inbox
- Check spam folder if not received

---

## 🆘 Troubleshooting

### Email Not Received?

1. **Check spam folder**
2. **Verify email address:** info@jdrfarm.com
3. **Check service dashboard** (Formspree/EmailJS)
4. **Test with mailto fallback** (should always work)
5. **Check browser console** for errors

### QR Code Not Showing?

1. **Check internet connection** (QR library loads from CDN)
2. **Check browser console** for errors
3. **Verify UPI ID:** jdmobacc-4@okhdfcback
4. **Try manual UPI payment** using the UPI ID

---

## 📞 Support

- **Formspree:** https://help.formspree.io
- **EmailJS:** https://www.emailjs.com/docs
- **UPI Issues:** Verify UPI ID: jdmobacc-4@okhdfcback

---

**Recommended:** Use Formspree for easiest setup! 🚀

