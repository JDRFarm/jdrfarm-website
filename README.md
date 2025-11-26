# JDR Farm - Food Products E-Commerce Website

A beautiful, responsive e-commerce website for JDR Farm (jdrfarm.com) to sell fresh organic food products.

## 🚀 Deployment Guides

- **[⭐ START HERE]** [Deploy to GoDaddy - Quick Start](DEPLOY_TO_GODADDY.md) - **Deploy your site to GoDaddy now!**
- [Detailed GoDaddy Setup Guide](GODADDY_SETUP.md) - Complete GoDaddy deployment options
- [Auto-Deploy Setup](AUTO_DEPLOY_SETUP.md) - For automatic GitHub syncing
- [Verify Netlify](verify-netlify-connection.md) - If using Netlify

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

## Next Steps for Production

1. **Backend Integration**: Connect the order form to a server/email service
2. **Payment Processing**: Integrate payment gateway (Stripe, PayPal, etc.)
3. **Product Images**: Replace emojis with actual product photos
4. **Inventory Management**: Add product quantities and stock tracking
5. **User Accounts**: Add login/registration for returning customers
6. **Order Tracking**: Implement order status and tracking system

## Browser Support

Works on all modern browsers:
- Chrome
- Firefox
- Safari
- Edge

## License

Free to use and modify for your projects.

