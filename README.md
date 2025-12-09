# JDR Farm - Food Products E-Commerce Website

A beautiful, responsive e-commerce website for JDR Farm (jdrfarm.com) to sell fresh organic food products.

## Features

- 🛒 **Shopping Cart System** - Add products to cart and manage orders
- 🎨 **Modern Design** - Elegant gray color scheme with professional look
- 📱 **Fully Responsive** - Works perfectly on mobile, tablet, and desktop
- ⚡ **Smooth Animations** - Engaging user experience with smooth transitions
- 🧭 **Easy Navigation** - Smooth scrolling navigation between sections
- 📝 **Order Form** - Complete order form with cart summary
- 🌾 **Product Showcase** - Beautiful product cards with benefits and ratings
- 💬 **WhatsApp Integration** - Floating WhatsApp button for easy contact
- ⭐ **Customer Testimonials** - Social proof section
- 🚚 **Features Section** - Free shipping, value for money, zero preservatives

## Products Featured

- **Coconut Oil** - Cold-pressed, organic, heart health & skincare
- **Moringa Leaf Powder** - Premium organic, immunity booster, iron rich
- **Mudavatangilangu** - Traditional medicinal root, therapeutic properties

## Getting Started

1. Open `index.html` in your web browser
2. No build process required - works directly!

## File Structure

```
web/
├── index.html          # Main HTML file with product listings
├── styles.css          # Stylesheet with modern design
├── script.js           # JavaScript with shopping cart functionality
├── logo/               # Logo images folder
│   ├── Logo.jpeg
│   └── Logoo.jpeg
├── .gitignore          # Git ignore file
├── GITHUB_SETUP.md     # Instructions for GitHub setup
└── README.md           # This file
```

## Customization

### Products
Edit the product cards in `index.html` to add/remove/modify products:
- Change product names, descriptions, and prices
- Update product emojis/images
- Modify `data-product` and `data-price` attributes

### Colors
Modify CSS variables in `styles.css` (`:root` section):
- `--primary-color`: Main gray color (#6b7280)
- `--primary-dark`: Darker gray for hover states
- `--secondary-color`: Light gray accent color
- `--bg-body`: Background color

### Content
- Update farm story in the About section
- Modify contact/order form fields
- Change footer information

## 🚀 Deployment to Your Domain

**Ready to publish this site on jdrfarm.com?**

👉 **DEPLOY NOW:** [`GITHUB_PAGES_SETUP.md`](GITHUB_PAGES_SETUP.md) - GitHub Pages deployment (15 minutes)

### Quick Links:
- 🎯 **GitHub Pages Setup:** [`GITHUB_PAGES_SETUP.md`](GITHUB_PAGES_SETUP.md) - Step-by-step guide (100% FREE)
- 📋 **DNS Reference:** [`GITHUB_PAGES_DNS_REFERENCE.md`](GITHUB_PAGES_DNS_REFERENCE.md) - Quick copy-paste DNS values
- 📖 **All Options:** [`START_HERE.md`](START_HERE.md) - Compare Netlify, GitHub Pages, GoDaddy
- 🔍 **Comparison:** [`DEPLOYMENT_COMPARISON.md`](DEPLOYMENT_COMPARISON.md) - Feature comparison

**What's Included:**
- ✅ Complete GitHub Pages setup guide
- ✅ Quick DNS reference for copy-paste
- ✅ Alternative options (Netlify, GoDaddy hosting)
- ✅ Automated deployment workflows
- ✅ Troubleshooting guides
- ✅ Visual architecture diagrams

## Netlify Deployment Workflow

- Pushes to `main` automatically run `.github/workflows/netlify-deploy.yml`, which executes `netlify deploy --prod --dir=.` with the configured `NETLIFY_AUTH_TOKEN` and `NETLIFY_SITE_ID` secrets.
- The latest commit `5be2bbc` ("Trigger Netlify deployment") kicked off a deploy at 2025-12-09 10:55 UTC, so the site is currently publishing to Netlify—track it in GitHub → Actions → "Deploy to Netlify".
- To redeploy manually, push to `main` or run `gh workflow run netlify-deploy.yml --ref main` (requires workflow-dispatch access).
- Live domain: https://jdrfarm.com (custom domain mapped inside Netlify Site settings).

## Next Steps for Production

1. **Deploy to Domain**: Follow [`GITHUB_PAGES_SETUP.md`](GITHUB_PAGES_SETUP.md) to get live on jdrfarm.com
2. **Backend Integration**: Connect the order form to a server/email service
3. **Payment Processing**: Integrate payment gateway (Stripe, PayPal, Razorpay)
4. **Product Images**: Continue adding high-quality product photos
5. **Inventory Management**: Add product quantities and stock tracking
6. **User Accounts**: Add login/registration for returning customers
7. **Order Tracking**: Implement order status and tracking system

## Browser Support

Works on all modern browsers:
- Chrome
- Firefox
- Safari
- Edge

## License

Free to use and modify for your projects.

