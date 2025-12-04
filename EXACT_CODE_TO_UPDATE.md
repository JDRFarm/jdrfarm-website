# 📝 Exact Code to Update on GitHub

## 🎯 What to Update

Update the `confirmPayment()` function in `script.js` to:
1. Show correct contact info (9150150932 and info@jdrfarm.com) in popup
2. Send WhatsApp message to 9150150932 when order is confirmed

---

## 📋 Step-by-Step: Update on GitHub

### Step 1: Open GitHub Repository
1. Go to: **https://github.com/JDRFarm/jdrfarm-website**
2. Click on: **`script.js`** file
3. Click: **Pencil icon** (Edit) at top right

### Step 2: Find the Function
1. Press **Ctrl+F** to search
2. Search for: `async function confirmPayment()`
3. Find the function (around line 733)

### Step 3: Replace the Function

**DELETE the entire `confirmPayment()` function** and **REPLACE** with this code:

```javascript
// Function to send WhatsApp message
function sendWhatsAppMessage(orderData) {
    const whatsappNumber = '9150150932';
    const orderSummary = orderData.orderDetails.split('\n').join('%0A');
    const message = `New Order Received%0A%0ACustomer: ${encodeURIComponent(orderData.name)}%0AEmail: ${encodeURIComponent(orderData.email)}%0APhone: ${encodeURIComponent(orderData.phone)}%0A%0ADelivery Address:%0A${encodeURIComponent(orderData.address)}%0A%0AOrder Details:%0A${orderSummary}%0A%0ATotal: ₹${orderData.totalAmount.toFixed(2)}%0A%0A${orderData.message ? 'Special Instructions: ' + encodeURIComponent(orderData.message) + '%0A' : ''}Please process this order.`;
    
    const whatsappUrl = `https://wa.me/${whatsappNumber}?text=${message}`;
    window.open(whatsappUrl, '_blank');
}

async function confirmPayment() {
    if (!currentOrderData) return;
    
    const processingMsg = translations[currentLang]?.payment?.processing || 'Processing your order...';
    const errorMsg = translations[currentLang]?.payment?.errorMsg || 'Order received! If email fails, please contact us at info@jdrfarm.com';
    
    // Show processing message
    const successBtn = document.getElementById('paymentSuccessBtn');
    const originalText = successBtn.textContent;
    successBtn.textContent = processingMsg;
    successBtn.disabled = true;
    
    // Send email
    try {
        const emailSent = await sendOrderEmail(currentOrderData);
        
        // Prepare order confirmation message with correct contact info
        const orderDetails = currentOrderData.orderDetails;
        const totalAmount = currentOrderData.totalAmount.toFixed(2);
        const contactPhone = '9150150932';
        const contactEmail = 'info@jdrfarm.com';
        
        const successMsg = `Thank you, ${currentOrderData.name}!\n\nYour order has been received:\n\n${orderDetails}\n\nTotal: ₹${totalAmount}\n\nWe'll contact you at ${contactEmail} or ${contactPhone} to confirm your order and delivery details.`;
        
        // Show success message
        setTimeout(() => {
            alert(successMsg);
            
            // Send WhatsApp message
            sendWhatsAppMessage(currentOrderData);
            
            // Reset form and cart
            const contactForm = document.getElementById('contactForm');
            if (contactForm) {
                contactForm.reset();
            }
            cart = [];
            updateCart();
            
            // Close modal
            closePaymentModal();
            
            // Scroll to top
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }, 1500);
    } catch (error) {
        console.error('Error sending email:', error);
        // Still show success as order is recorded
        alert('Order received! ' + errorMsg);
        successBtn.textContent = originalText;
        successBtn.disabled = false;
    }
}
```

### Step 4: Commit Changes

1. **Scroll down** to "Commit changes" section
2. **Commit message:**
   ```
   Update contact info to 9150150932 and info@jdrfarm.com, add WhatsApp order notification
   ```
3. **Click:** "Commit changes" button (green button)

### Step 5: Netlify Auto-Deploys

- ✅ Netlify **automatically detects** the GitHub push
- ✅ Netlify **automatically deploys** to your domain
- ✅ Takes **1-2 minutes**
- ✅ Your site updates: **https://jdrfarm.com**

---

## ✅ What This Does

### 1. Order Confirmation Popup
Shows:
- Customer name
- Order details
- Total amount
- Contact: **info@jdrfarm.com** or **9150150932**

### 2. WhatsApp Message
When order is confirmed:
- Opens WhatsApp to **9150150932**
- Pre-filled message with:
  - Customer details
  - Delivery address
  - Order details
  - Total amount
  - Special instructions (if any)

---

## 🧪 Test After Deployment

1. Visit: https://jdrfarm.com
2. Add products to cart
3. Fill delivery form
4. Click "Place Order"
5. Complete payment
6. Check popup shows: **9150150932** and **info@jdrfarm.com**
7. Verify WhatsApp opens with order details

---

**Ready to update on GitHub!** 🚀

