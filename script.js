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
                desc: "On orders above ₹399"
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
        testimonials: {
            title: "What Our Customers Say"
        },
        about: {
            title: "About JDR Farm",
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
            text1: "At JDR Farm, we're dedicated to promoting health through sustainable farming practices. Our mission is to provide healthy food products and farming services while emphasizing eco-friendly initiatives and empowerment. We believe in the power of real food - food that's grown with care, harvested with respect, and delivered with pride.",
            text2: "Every product you purchase from us supports sustainable agriculture and helps us continue our mission of providing healthy, organic food to our community. Together, we're building a healthier future through sustainable farming practices. Thank you for choosing JDR Farm!"
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
            empty: "Your cart is empty"
        }
    },
    ta: {
        nav: {
            home: "முகப்பு",
            products: "தயாரிப்புகள்",
            about: "எங்களைப் பற்றி",
            contact: "தொடர்பு"
        },
        hero: {
            title: "நிலையான விவசாயத்தின் மூலம் ஆரோக்கியத்தை ஊக்குவித்தல்",
            subtitle: "சுற்றுச்சூழல் நட்பு முன்முயற்சிகளுடன் ஆரோக்கியமான உணவு பொருட்கள் மற்றும் விவசாய சேவைகள்",
            shopNow: "இப்போது வாங்க"
        },
        products: {
            title: "எங்கள் தயாரிப்புகளின் வரம்பை ஆராயுங்கள்",
            addToCart: "கார்ட்டில் சேர்",
            reviews: "மதிப்பீடுகள்",
            coconut: {
                name: "தேங்காய் எண்ணெய்",
                subtitle: "குளிர் அழுத்தம் | கரிம | தூய்மையானது",
                description: "தூய்மையான, குளிர் அழுத்தப்பட்ட கரிம தேங்காய் எண்ணெய். ஆரோக்கியமான கொழுப்புகள் மற்றும் ஊட்டச்சத்துக்கள் நிறைந்தது, சமையல் மற்றும் தோல் பராமரிப்புக்கு சிறந்தது. இதய ஆரோக்கியம் மற்றும் இயற்கை அழகை ஆதரிக்கிறது.",
                benefit1: "இதய ஆரோக்கியம்",
                benefit2: "தோல் பராமரிப்பு"
            },
            moringa: {
                name: "முருங்கை இலை பொடி",
                subtitle: "பிரீமியம் கரிம | தினசரி ஊட்டச்சத்து",
                description: "பிரீமியம் கரிம முருங்கை இலை பொடி. உகந்த ஆரோக்கியத்திற்கான வைட்டமின்கள், தாதுக்கள் மற்றும் ஆக்ஸிஜனேற்ற எதிர்ப்பிகளால் நிரம்பியுள்ளது. இயற்கை புரதம் மற்றும் இரும்பு மூலம்.",
                benefit1: "நோய் எதிர்ப்பு சக்தி",
                benefit2: "இரும்பு நிறைந்த"
            },
            mudavatangilangu: {
                name: "முடவதங்கிலங்கு",
                subtitle: "இயற்கை வேர் | பாரம்பரிய மருத்துவம்",
                description: "பாரம்பரிய மருத்துவ வேர், இயற்கையாக வளர்க்கப்பட்டு கவனமாக பதப்படுத்தப்பட்டது. அதன் சிகிச்சை பண்புகள் மற்றும் பாரம்பரிய குணப்படுத்தும் நன்மைகளுக்கு அறியப்பட்டது.",
                benefit1: "மருத்துவ",
                benefit2: "சிகிச்சை"
            },
            quantity: "அளவு:",
            outOfStock: "ஸ்டாக் இல்லை"
        },
        features: {
            shipping: {
                title: "இலவச ஷிப்பிங்",
                desc: "₹399 க்கு மேல் ஆர்டர்களில்"
            },
            value: {
                title: "பணத்திற்கான மதிப்பு",
                desc: "ஆரோக்கியமானது மட்டும். இரசாயனங்கள் இல்லை"
            },
            preservatives: {
                title: "பூஜ்ஜிய பாதுகாப்பு பொருட்கள்",
                desc: "இயற்கையாக பதப்படுத்தப்பட்டது"
            }
        },
        testimonials: {
            title: "எங்கள் வாடிக்கையாளர்கள் என்ன சொல்கிறார்கள்"
        },
        about: {
            title: "JDR பண்ணை பற்றி",
            organic: {
                title: "100% கரிம",
                desc: "எங்கள் அனைத்து தயாரிப்புகளும் சான்றளிக்கப்பட்ட கரிம, தீங்கு விளைவிக்கும் பூச்சிக்கொல்லிகள் அல்லது இரசாயனங்கள் இல்லாமல் வளர்க்கப்படுகின்றன."
            },
            fresh: {
                title: "பண்ணை புதியது",
                desc: "உச்ச முதிர்ச்சியில் அறுவடை செய்து அதிகபட்ச சுவை மற்றும் ஊட்டச்சத்தை உறுதி செய்ய புதியதாக வழங்கப்படுகிறது."
            },
            sustainable: {
                title: "நிலையான",
                desc: "எதிர்கால தலைமுறைகளுக்காக சுற்றுச்சூழலைப் பாதுகாக்கும் நிலையான விவசாய முறைகளை நாங்கள் பின்பற்றுகிறோம்."
            },
            text1: "JDR பண்ணையில், நிலையான விவசாய நடைமுறைகள் மூலம் ஆரோக்கியத்தை ஊக்குவிப்பதில் நாங்கள் அர்ப்பணிக்கப்பட்டுள்ளோம். சுற்றுச்சூழல் நட்பு முன்முயற்சிகள் மற்றும் அதிகாரமளிப்பதை வலியுறுத்தும் போது ஆரோக்கியமான உணவு பொருட்கள் மற்றும் விவசாய சேவைகளை வழங்குவதே எங்கள் பணி. உண்மையான உணவின் சக்தியில் நாங்கள் நம்புகிறோம் - அக்கறையுடன் வளர்க்கப்பட்ட, மரியாதையுடன் அறுவடை செய்யப்பட்ட மற்றும் பெருமையுடன் வழங்கப்படும் உணவு.",
            text2: "எங்களிடமிருந்து நீங்கள் வாங்கும் ஒவ்வொரு தயாரிப்பும் நிலையான விவசாயத்தை ஆதரிக்கிறது மற்றும் எங்கள் சமூகத்திற்கு ஆரோக்கியமான, கரிம உணவை வழங்கும் எங்கள் பணியைத் தொடர உதவுகிறது. ஒன்றாக, நிலையான விவசாய நடைமுறைகள் மூலம் நாங்கள் ஒரு ஆரோக்கியமான எதிர்காலத்தை உருவாக்குகிறோம். JDR பண்ணையைத் தேர்ந்தெடுத்ததற்கு நன்றி!"
        },
        contact: {
            title: "எங்களைத் தொடர்பு கொள்ளவும் & உங்கள் ஆர்டரை வைக்கவும்",
            getInTouch: "தொடர்பு கொள்ளுங்கள்",
            subscribe: {
                title: "ஆரோக்கியமான புதுப்பிப்புகளுக்கு குழுசேரவும்",
                placeholder: "உங்கள் மின்னஞ்சல் முகவரியை உள்ளிடவும்",
                button: "குழுசேர்"
            },
            orderInfo: "ஆர்டர் தகவல்",
            form: {
                name: "முழு பெயர்",
                namePlaceholder: "உங்கள் முழு பெயரை உள்ளிடவும்",
                email: "மின்னஞ்சல் முகவரி",
                emailPlaceholder: "உங்கள் மின்னஞ்சல் முகவரியை உள்ளிடவும்",
                phone: "தொலைபேசி எண்",
                phonePlaceholder: "உங்கள் தொலைபேசி எண்ணை உள்ளிடவும்",
                address: "விநியோக முகவரி",
                addressPlaceholder: "உங்கள் விநியோக முகவரியை உள்ளிடவும்",
                message: "சிறப்பு வழிமுறைகள் (விருப்பமானது)",
                messagePlaceholder: "எந்த சிறப்பு வழிமுறைகளும்",
                submit: "ஆர்டர் வைக்க"
            }
        },
        cart: {
            title: "உங்கள் கார்ட்",
            total: "மொத்தம்: ₹",
            empty: "உங்கள் கார்ட் காலியாக உள்ளது"
        }
    }
};

// Current language
let currentLang = localStorage.getItem('language') || 'en';

// Language switching function
function switchLanguage(lang) {
    if (!lang || !translations[lang]) {
        console.error('Invalid language:', lang);
        return;
    }
    
    currentLang = lang;
    localStorage.setItem('language', lang);
    
    // Update language buttons
    document.querySelectorAll('.lang-btn').forEach(btn => {
        btn.classList.remove('active');
        if (btn.getAttribute('data-lang') === lang) {
            btn.classList.add('active');
        }
    });
    
    // Update HTML lang attribute
    document.documentElement.lang = lang;
    
    console.log('Switching to language:', lang);
    
    // Translate all elements with data-translate attribute
    document.querySelectorAll('[data-translate]').forEach(element => {
        const key = element.getAttribute('data-translate');
        const keys = key.split('.');
        let translation = translations[lang];
        
        for (const k of keys) {
            translation = translation?.[k];
        }
        
        if (translation) {
            element.textContent = translation;
        }
    });
    
    // Translate placeholders
    document.querySelectorAll('[data-translate-placeholder]').forEach(element => {
        const key = element.getAttribute('data-translate-placeholder');
        const keys = key.split('.');
        let translation = translations[lang];
        
        for (const k of keys) {
            translation = translation?.[k];
        }
        
        if (translation) {
            element.placeholder = translation;
        }
    });
    
    // Translate labels (for quantity selector labels)
    document.querySelectorAll('.quantity-selector label[data-translate]').forEach(element => {
        const key = element.getAttribute('data-translate');
        const keys = key.split('.');
        let translation = translations[lang];
        
        for (const k of keys) {
            translation = translation?.[k];
        }
        
        if (translation) {
            element.textContent = translation;
        }
    });
    
    // Update cart display if needed
    updateCart();
}

// Initialize language on page load
document.addEventListener('DOMContentLoaded', () => {
    // Initialize language first
    switchLanguage(currentLang);
    
    // Function to handle language button clicks
    function handleLangButtonClick(e) {
        e.preventDefault();
        e.stopPropagation();
        const lang = this.getAttribute('data-lang');
        if (lang) {
            console.log('Language button clicked:', lang);
            switchLanguage(lang);
        }
    }
    
    // Add event listeners to language buttons
    function setupLanguageButtons() {
        const langButtons = document.querySelectorAll('.lang-btn');
        console.log('Setting up language buttons:', langButtons.length);
        
        langButtons.forEach(btn => {
            // Remove old listeners by cloning
            const newBtn = btn.cloneNode(true);
            if (btn.parentNode) {
                btn.parentNode.replaceChild(newBtn, btn);
            }
            
            // Add click event listener
            newBtn.addEventListener('click', handleLangButtonClick, false);
            newBtn.addEventListener('touchstart', handleLangButtonClick, false);
        });
    }
    
    // Setup buttons immediately
    setupLanguageButtons();
    
    // Also setup after a short delay to ensure DOM is ready
    setTimeout(setupLanguageButtons, 100);
    setTimeout(setupLanguageButtons, 500);
    
    // Use event delegation as backup (capture phase)
    document.addEventListener('click', function(e) {
        const langBtn = e.target.closest('.lang-btn');
        if (langBtn) {
            e.preventDefault();
            e.stopPropagation();
            const lang = langBtn.getAttribute('data-lang');
            if (lang && lang !== currentLang) {
                console.log('Language switch via delegation:', lang);
                switchLanguage(lang);
            }
        }
    }, true);
    
    // Price is shown in dropdown options, no initialization needed
});

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
        const addedText = currentLang === 'ta' ? 'சேர்க்கப்பட்டது!' : 'Added!';
        e.target.textContent = addedText;
        e.target.style.background = 'var(--secondary-color)';
        
        setTimeout(() => {
            const addToCartText = translations[currentLang]?.products?.addToCart || 'Add to Cart';
            e.target.textContent = addToCartText;
            e.target.style.background = '';
        }, 1000);
    });
});

// Update cart display
function updateCart() {
    const cartItems = document.getElementById('cartItems');
    const cartTotal = document.getElementById('cartTotal');
    
    if (cart.length === 0) {
        const emptyText = translations[currentLang]?.cart?.empty || 'Your cart is empty';
        cartItems.innerHTML = `<div class="empty-cart">${emptyText}</div>`;
        cartTotal.textContent = '0.00';
        return;
    }
    
    let total = 0;
    cartItems.innerHTML = '';
    
    cart.forEach((item, index) => {
        total += item.price;
        const cartItem = document.createElement('div');
        cartItem.className = 'cart-item';
        const quantityDisplay = item.quantity ? ` (${item.quantity})` : '';
        cartItem.innerHTML = `
            <span class="cart-item-name">${item.product}${quantityDisplay}</span>
            <span class="cart-item-price">₹${item.price.toFixed(2)}</span>
            <button class="remove-item" data-index="${index}">${currentLang === 'ta' ? 'நீக்கு' : 'Remove'}</button>
        `;
        cartItems.appendChild(cartItem);
    });
    
    cartTotal.textContent = total.toFixed(2);
    
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
const contactForm = document.getElementById('contactForm');

contactForm.addEventListener('submit', (e) => {
    e.preventDefault();
    
    if (cart.length === 0) {
        const alertMsg = currentLang === 'ta' 
            ? 'தயவுசெய்து ஆர்டர் செய்வதற்கு முன் உங்கள் கார்ட்டில் பொருட்களைச் சேர்க்கவும்.'
            : 'Please add items to your cart before placing an order.';
        alert(alertMsg);
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
        const total = cart.reduce((sum, item) => sum + item.price, 0);
        const orderDetails = cart.map(item => {
            const quantityDisplay = item.quantity ? ` (${item.quantity})` : '';
            return `${item.product}${quantityDisplay} - ₹${item.price.toFixed(2)}`;
        }).join('\n');
        
        // Here you would typically send the data to a server
        const thankYouMsg = currentLang === 'ta'
            ? `நன்றி, ${name}!\n\nஉங்கள் ஆர்டர் பெறப்பட்டது:\n\n${orderDetails}\n\nமொத்தம்: ₹${total.toFixed(2)}\n\nஉங்கள் ஆர்டர் மற்றும் விநியோக விவரங்களை உறுதிப்படுத்த எங்கள் ${email} அல்லது ${phone} இல் தொடர்பு கொள்வோம்.`
            : `Thank you, ${name}!\n\nYour order has been received:\n\n${orderDetails}\n\nTotal: ₹${total.toFixed(2)}\n\nWe'll contact you at ${email} or ${phone} to confirm your order and delivery details.`;
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
            const subscribeMsg = currentLang === 'ta'
                ? `குழுசேர்ந்ததற்கு நன்றி! ${email} க்கு ஆரோக்கியமான புதுப்பிப்புகளை அனுப்புவோம்.`
                : `Thank you for subscribing! We'll send healthy updates to ${email}.`;
            alert(subscribeMsg);
            subscribeForm.reset();
        }
    });
}

// Initialize cart display
updateCart();

