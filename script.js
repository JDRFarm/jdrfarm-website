// Shopping Cart

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
        const checkoutButton = document.getElementById('checkoutButton');
        const checkoutNote = document.getElementById('checkoutNote');
        if (checkoutButton) checkoutButton.style.display = 'none';
        if (checkoutNote) checkoutNote.style.display = 'none';
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
    
    // Show/hide checkout button based on cart items
    const checkoutButton = document.getElementById('checkoutButton');
    const checkoutNote = document.getElementById('checkoutNote');
    
    if (checkoutButton) {
        if (cart.length > 0) {
            checkoutButton.style.display = 'block';
            if (checkoutNote) checkoutNote.style.display = 'block';
            // Check if form fields are filled to enable checkout
            checkFormCompletion();
        } else {
            checkoutButton.style.display = 'none';
            if (checkoutNote) checkoutNote.style.display = 'none';
        }
    }
    
    // Add remove functionality
    document.querySelectorAll('.remove-item').forEach(button => {
        button.addEventListener('click', (e) => {
            const index = parseInt(e.target.getAttribute('data-index'));
            cart.splice(index, 1);
            updateCart();
        });
    });
}

// Function to check if all required form fields are filled
function checkFormCompletion() {
    const checkoutButton = document.getElementById('checkoutButton');
    if (!checkoutButton) return;
    
    // Get form field values
    const name = document.getElementById('name')?.value.trim() || '';
    const email = document.getElementById('email')?.value.trim() || '';
    const phone = document.getElementById('phone')?.value.trim() || '';
    const address = document.getElementById('address')?.value.trim() || '';
    
    // Check if all required fields are filled
    const allFieldsFilled = name && email && phone && address;
    
    // Enable/disable checkout button
    if (allFieldsFilled && cart.length > 0) {
        checkoutButton.disabled = false;
        checkoutButton.style.opacity = '1';
        checkoutButton.style.cursor = 'pointer';
        checkoutButton.title = '';
    } else {
        checkoutButton.disabled = true;
        checkoutButton.style.opacity = '0.5';
        checkoutButton.style.cursor = 'not-allowed';
        const missingFields = [];
        if (!name) missingFields.push('Full Name');
        if (!email) missingFields.push('Email');
        if (!phone) missingFields.push('Phone');
        if (!address) missingFields.push('Delivery Address');
        checkoutButton.title = `Please fill: ${missingFields.join(', ')}`;
    }
}

// Checkout button functionality
document.addEventListener('DOMContentLoaded', () => {
    const checkoutButton = document.getElementById('checkoutButton');
    if (checkoutButton) {
        checkoutButton.addEventListener('click', () => {
            // Only proceed if button is enabled
            if (checkoutButton.disabled) {
                // Scroll to form to show what's missing
                const contactSection = document.getElementById('contact');
                if (contactSection) {
                    contactSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }
                return;
            }
            
            // Scroll to contact form
            const contactSection = document.getElementById('contact');
            if (contactSection) {
                contactSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
                // Focus on first empty field after a short delay
                setTimeout(() => {
                    const name = document.getElementById('name');
                    const email = document.getElementById('email');
                    const phone = document.getElementById('phone');
                    const address = document.getElementById('address');
                    
                    if (!name.value.trim()) name.focus();
                    else if (!email.value.trim()) email.focus();
                    else if (!phone.value.trim()) phone.focus();
                    else if (!address.value.trim()) address.focus();
                }, 500);
            }
        });
    }
    
    // Add event listeners to form fields for real-time validation
    const formFields = ['name', 'email', 'phone', 'address'];
    formFields.forEach(fieldId => {
        const field = document.getElementById(fieldId);
        if (field) {
            field.addEventListener('input', checkFormCompletion);
            field.addEventListener('blur', checkFormCompletion);
        }
    });
    
    // Initial check
    checkFormCompletion();
});

// Order form handling
const contactForm = document.getElementById('contactForm');

contactForm.addEventListener('submit', (e) => {
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
        
        const orderDetails = cart.map(item => {
            const quantityDisplay = item.quantity ? ` (${item.quantity})` : '';
            return `${item.product}${quantityDisplay} - ₹${item.price.toFixed(2)}`;
        }).join('\n');
        
        // Here you would typically send the data to a server
        const thankYouMsg = `Thank you, ${name}!\n\nYour order has been received:\n\n${orderDetails}\n\nTotal: ₹${totalAmount.toFixed(2)}\n\nWe'll contact you at ${email} or ${phone} to confirm your order and delivery details.`;
        alert(thankYouMsg);
        
        // Reset form and cart
        contactForm.reset();
        cart = [];
        updateCart();
        
        // Scroll to top
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }
});

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

