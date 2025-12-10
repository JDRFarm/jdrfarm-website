// Language Translations
const translations = {
    en: {
        nav: {
            home: "Home",
            products: "Products",
            about: "About",
            contact: "Contact"
        },
        hero: {
            title: "Promoting Health Through Sustainable Farming",
            subtitle: "Healthy food products and farming services with eco-friendly initiatives",
            shopNow: "Shop Now"
        },
        products: {
            title: "Explore Our Range of Products",
            addToCart: "Add to Cart",
            reviews: "reviews",
            quantity: "Quantity:",
            outOfStock: "Out of Stock",
            coconut: {
                name: "Coconut Oil",
                subtitle: "Cold-Pressed | Organic | Pure",
                description: "Pure, cold-pressed organic coconut oil. Rich in healthy fats and nutrients, perfect for cooking and skincare. Supports heart health and natural beauty.",
                benefit1: "Heart Health",
                benefit2: "Skin Care"
            },
            moringa: {
                name: "Moringa Leaf Powder",
                subtitle: "Premium Organic | Daily Nutrition",
                description: "Premium organic moringa leaf powder. Packed with vitamins, minerals, and antioxidants for optimal health. Natural protein and iron source.",
                benefit1: "Immunity Booster",
                benefit2: "Iron Rich"
            },
            mudavatangilangu: {
                name: "Mudavatangilangu",
                subtitle: "Natural Root | Traditional Medicine",
                description: "Traditional medicinal root, naturally grown and carefully processed. Known for its therapeutic properties and traditional healing benefits.",
                benefit1: "Medicinal",
                benefit2: "Therapeutic"
            },
            quantity: "Quantity:"
        },
        features: {
            shipping: {
                title: "Free Shipping",
                desc: "On orders above ₹599"
            },
            value: {
                title: "Value for Money",
                desc: "Only Healthy. No Chemicals"
            },
            preservatives: {
                title: "Zero Preservatives",
                desc: "Naturally Processed"
            }
        },
        about: {
            title: "About JDR",
            organic: {
                title: "100% Organic",
                desc: "All our products are certified organic, grown without harmful pesticides or chemicals."
            },
            fresh: {
                title: "Farm Fresh",
                desc: "Harvested at peak ripeness and delivered fresh to ensure maximum flavor and nutrition."
            },
            sustainable: {
                title: "Sustainable",
                desc: "We practice sustainable farming methods that protect the environment for future generations."
            },
            text1: "At JDR, we're dedicated to promoting health through sustainable farming practices. Our mission is to provide healthy food products and farming services while emphasizing eco-friendly initiatives and empowerment. We believe in the power of real food - food that's grown with care, harvested with respect, and delivered with pride.",
            text2: "Every product you purchase from us supports sustainable agriculture and helps us continue our mission of providing healthy, organic food to our community. Together, we're building a healthier future through sustainable farming practices. Thank you for choosing JDR!"
        },
        contact: {
            title: "Contact Us & Place Your Order",
            getInTouch: "Get In Touch",
            subscribe: {
                title: "Subscribe for Healthy Updates",
                placeholder: "Enter your email address",
                button: "Subscribe"
            },
            orderInfo: "Order Information",
            form: {
                name: "Full Name",
                namePlaceholder: "Enter your full name",
                email: "Email Address",
                emailPlaceholder: "Enter your email address",
                phone: "Phone Number",
                phonePlaceholder: "Enter your phone number",
                address: "Delivery Address",
                addressPlaceholder: "Enter your delivery address",
                message: "Special Instructions (Optional)",
                messagePlaceholder: "Any special instructions",
                submit: "Place Order"
            }
        },
        cart: {
            title: "Your Cart",
            total: "Total: ₹",
            empty: "Your cart is empty",
            checkout: "Proceed to Checkout"
        },
        payment: {
            title: "Complete Your Payment",
            amount: "Total Amount",
            instructions: "Scan the QR code below using Google Pay, PhonePe, or any UPI app to complete your payment.",
            success: "I Have Completed the Payment",
            cancel: "Cancel",
            processing: "Processing your order...",
            successMsg: "Payment confirmed! Your order has been placed successfully.",
            errorMsg: "Failed to send order. Please contact us directly."
        }
    }
};

// Shopping Cart
let cart = [];

// Mobile menu toggle
const menuToggle = document.querySelector('.menu-toggle');
const navLinks = document.querySelector('.nav-links');

menuToggle.addEventListener('click', () => {
    navLinks.classList.toggle('active');
});

// Close mobile menu when clicking on a link
document.querySelectorAll('.nav-links a').forEach(link => {
    link.addEventListener('click', () => {
        navLinks.classList.remove('active');
    });
});

// Smooth scroll for navigation links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Price is shown in the dropdown options, no separate display needed

// Add to cart functionality
document.querySelectorAll('.add-to-cart:not([disabled])').forEach(button => {
    button.addEventListener('click', (e) => {
        // Don't add if button is disabled
        if (e.target.disabled) {
            return;
        }
        
        const product = e.target.getAttribute('data-product');
        const productType = e.target.getAttribute('data-product-type');
        
        // Find the quantity selector for this product
        const productCard = e.target.closest('.product-card');
        const quantitySelector = productCard.querySelector('.product-quantity');
        
        if (!quantitySelector || quantitySelector.disabled) {
            return;
        }
        
        const selectedOption = quantitySelector.options[quantitySelector.selectedIndex];
        const quantity = quantitySelector.value;
        
        // Get price from selected option for oil products, or from data attribute
        let price;
        if (productType === 'oil') {
            price = parseFloat(selectedOption.getAttribute('data-price'));
        } else {
            price = parseFloat(e.target.getAttribute('data-price')) || 0;
        }
        
        if (!price || isNaN(price)) {
            console.error('Invalid price for product:', product);
            return;
        }
        
        // Add to cart with quantity
        cart.push({ product, price, quantity, productType });
        updateCart();
        
        // Show feedback
        const originalText = e.target.textContent;
        e.target.textContent = 'Added!';
        e.target.style.background = 'var(--secondary-color)';
        
        setTimeout(() => {
            e.target.textContent = 'Add to Cart';
            e.target.style.background = '';
        }, 1000);
    });
});

// Update cart display
function updateCart() {
    const cartItems = document.getElementById('cartItems');
    
    if (cart.length === 0) {
        cartItems.innerHTML = `<div class="empty-cart">Your cart is empty</div>`;
        return;
    }
    
    cartItems.innerHTML = '';
    
    cart.forEach((item, index) => {
        // Ensure price is a valid number
        const itemPrice = parseFloat(item.price) || 0;
        const cartItem = document.createElement('div');
        cartItem.className = 'cart-item';
        const quantityDisplay = item.quantity ? ` (${item.quantity})` : '';
        cartItem.innerHTML = `
            <span class="cart-item-name">${item.product}${quantityDisplay}</span>
            <span class="cart-item-price">₹${itemPrice.toFixed(2)}</span>
            <button class="remove-item" data-index="${index}">Remove</button>
        `;
        cartItems.appendChild(cartItem);
    });
    
    
    // Add remove functionality
    document.querySelectorAll('.remove-item').forEach(button => {
        button.addEventListener('click', (e) => {
            const index = parseInt(e.target.getAttribute('data-index'));
            cart.splice(index, 1);
            updateCart();
        });
    });
}


// Order form handling
async function sendOrderEmail(orderData) {
    const emailData = {
        to_email: 'info@jdrfarm.com',
        subject: `New Order from ${orderData.name}`,
        customer_name: orderData.name,
        customer_email: orderData.email,
        customer_phone: orderData.phone,
        delivery_address: orderData.address,
        special_instructions: orderData.message || 'None',
        order_details: orderData.orderDetails,
        total_amount: `₹${orderData.totalAmount.toFixed(2)}`,
        order_date: new Date().toLocaleString('en-IN', { 
            timeZone: 'Asia/Kolkata',
            dateStyle: 'full',
            timeStyle: 'medium'
        })
    };

    // Try EmailJS first (if configured)
    if (typeof emailjs !== 'undefined' && window.EMAILJS_SERVICE_ID && window.EMAILJS_TEMPLATE_ID) {
        try {
            await emailjs.send(
                window.EMAILJS_SERVICE_ID,
                window.EMAILJS_TEMPLATE_ID,
                {
                    to_email: emailData.to_email,
                    subject: emailData.subject,
                    customer_name: emailData.customer_name,
                    customer_email: emailData.customer_email,
                    customer_phone: emailData.customer_phone,
                    delivery_address: emailData.delivery_address,
                    special_instructions: emailData.special_instructions,
                    order_details: emailData.order_details,
                    total_amount: emailData.total_amount,
                    order_date: emailData.order_date
                }
            );
            console.log('Email sent successfully via EmailJS');
            return true;
        } catch (error) {
            console.error('EmailJS error:', error);
            // Fallback to Formspree or mailto
        }
    }

    // Try Formspree (free email service)
    try {
        const formspreeResponse = await fetch('https://formspree.io/f/YOUR_FORM_ID', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                _to: emailData.to_email,
                _subject: emailData.subject,
                _format: 'plain',
                name: emailData.customer_name,
                email: emailData.customer_email,
                phone: emailData.customer_phone,
                address: emailData.delivery_address,
                instructions: emailData.special_instructions,
                order: emailData.order_details,
                total: emailData.total_amount,
                date: emailData.order_date
            })
        });

        if (formspreeResponse.ok) {
            console.log('Email sent successfully via Formspree');
            return true;
        }
    } catch (error) {
        console.error('Formspree error:', error);
    }

    // Fallback: Use mailto link (opens email client)
    const subject = encodeURIComponent(emailData.subject);
    const body = encodeURIComponent(`New Order Received

Customer Details:
Name: ${emailData.customer_name}
Email: ${emailData.customer_email}
Phone: ${emailData.customer_phone}
Delivery Address: ${emailData.delivery_address}
Special Instructions: ${emailData.special_instructions}

Order Details:
${emailData.order_details}

Total Amount: ${emailData.total_amount}
Order Date: ${emailData.order_date}

Please process this order and arrange delivery.`);

    // Open mailto link
    window.location.href = `mailto:${emailData.to_email}?subject=${subject}&body=${body}`;
    return true;
}

// Initialize contact form handler (with DOMContentLoaded fallback)
let contactFormInitialized = false;

function initializeContactForm() {
    // Prevent duplicate initialization
    if (contactFormInitialized) return;
    
    const contactForm = document.getElementById('contactForm');
    
    if (contactForm) {
        contactFormInitialized = true;
        contactForm.addEventListener('submit', async (e) => {
        e.preventDefault();
        
        if (cart.length === 0) {
            alert('Please add items to your cart before placing an order.');
            return;
        }
        
        // Get form values
        const name = document.getElementById('name').value;
        const email = document.getElementById('email').value;
        const phone = document.getElementById('phone').value;
        const address = document.getElementById('address').value;
        const message = document.getElementById('message').value;
        
        // Simple validation
        if (name && email && phone && address) {
            // Calculate total amount
            const totalAmount = cart.reduce((sum, item) => sum + (parseFloat(item.price) || 0), 0);
            
            // Prepare order details
            const orderDetails = cart.map(item => {
                const quantityDisplay = item.quantity ? ` (${item.quantity})` : '';
                return `${item.product}${quantityDisplay} - ₹${item.price.toFixed(2)}`;
            }).join('\n');
            
            // Prepare order data
            const orderData = {
                name,
                email,
                phone,
                address,
                message: message || 'None',
                orderDetails,
                totalAmount,
                orderDate: new Date().toLocaleString('en-IN', { 
                    timeZone: 'Asia/Kolkata',
                    dateStyle: 'full',
                    timeStyle: 'medium'
                })
            };
            
            // Show processing message
            const submitButton = e.target.querySelector('button[type="submit"]');
            const originalText = submitButton.textContent;
            submitButton.textContent = 'Processing Order...';
            submitButton.disabled = true;
            
            // Send email to info@jdrfarm.com
            try {
                await sendOrderEmail(orderData);
                
                // Show success message with customer's contact info
                const successMsg = `Thank you, ${name}!\n\nYour order has been received:\n\n${orderDetails}\n\nTotal: ₹${totalAmount.toFixed(2)}\n\nWe'll contact you at ${email} or ${phone} to confirm your order and delivery details.`;
                alert(successMsg);
            
                // Reset form and cart
                contactForm.reset();
                cart = [];
                updateCart();
                
                // Scroll to top
                window.scrollTo({ top: 0, behavior: 'smooth' });
            } catch (error) {
                console.error('Error sending email:', error);
                alert(`Order received! We will contact you shortly at ${email} or ${phone}.`);
                
                // Still reset form
                contactForm.reset();
                cart = [];
                updateCart();
            } finally {
                submitButton.textContent = originalText;
                submitButton.disabled = false;
            }
        } else {
            // Show validation error
            alert('Please fill in all required fields.');
        }
    });
    }
}

// Try to initialize immediately (if DOM is ready)
initializeContactForm();

// Also initialize on DOMContentLoaded (fallback)
document.addEventListener('DOMContentLoaded', initializeContactForm);

// CTA button click handler
const ctaButton = document.querySelector('.cta-button');

ctaButton.addEventListener('click', () => {
    document.querySelector('#products').scrollIntoView({
        behavior: 'smooth',
        block: 'start'
    });
});

// Add scroll animation for cards
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observe cards and product cards
document.querySelectorAll('.card, .product-card').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(20px)';
    el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    observer.observe(el);
});

// Navbar background on scroll
const navbar = document.querySelector('.navbar');
let lastScroll = 0;

window.addEventListener('scroll', () => {
    const currentScroll = window.pageYOffset;
    
    if (currentScroll > 100) {
        navbar.style.boxShadow = '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)';
    } else {
        navbar.style.boxShadow = '0 2px 4px rgba(0, 0, 0, 0.05)';
    }
    
    lastScroll = currentScroll;
});

// Subscribe form handling
const subscribeForm = document.getElementById('subscribeForm');

if (subscribeForm) {
    subscribeForm.addEventListener('submit', (e) => {
        e.preventDefault();
        
        const email = document.getElementById('subscribeEmail').value;
        
        if (email) {
            alert(`Thank you for subscribing! We'll send healthy updates to ${email}.`);
            subscribeForm.reset();
        }
    });
}

// Initialize cart display
updateCart();

