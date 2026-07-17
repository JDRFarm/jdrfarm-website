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

function formatProductNameList(names) {
    if (names.length === 0) return '';
    if (names.length === 1) return names[0];
    if (names.length === 2) return `${names[0]} and ${names[1]}`;
    return `${names.slice(0, -1).join(', ')}, and ${names[names.length - 1]}`;
}

/** Hero copy lists in-stock items and “coming soon” products from the product grid. */
function updateHeroFromAvailableProducts() {
    const hero = document.querySelector('.hero');
    const heroSubtitle = document.querySelector('.hero-subtitle');
    if (!heroSubtitle) return;

    const inStockCards = document.querySelectorAll(
        '#products .products-grid > .product-card:not(.out-of-stock):not(.coming-soon)'
    );
    const names = Array.from(inStockCards)
        .map((card) => {
            const h3 = card.querySelector('h3');
            return h3 ? h3.textContent.trim() : '';
        })
        .filter(Boolean);

    const comingSoonCards = document.querySelectorAll(
        '#products .products-grid > .product-card.coming-soon'
    );
    const comingSoonNames = Array.from(comingSoonCards)
        .map((card) => {
            const h3 = card.querySelector('h3');
            return h3 ? h3.textContent.trim() : '';
        })
        .filter(Boolean);

    const defaultSubtitle = 'Healthy food products and farming services with eco-friendly initiatives';

    hero?.classList.toggle('hero--has-stock', names.length > 0);
    hero?.classList.toggle('hero--has-coming-soon', comingSoonNames.length > 0);

    const availablePart =
        names.length > 0 ? `Now available: ${formatProductNameList(names)}.` : '';
    const comingSoonPart =
        comingSoonNames.length > 0
            ? ` Coming soon: ${formatProductNameList(comingSoonNames)}.`
            : '';

    if (names.length === 0 && comingSoonNames.length === 0) {
        heroSubtitle.textContent = `${defaultSubtitle}. Contact us on WhatsApp for availability and restock updates.`;
        return;
    }

    if (names.length === 0 && comingSoonNames.length > 0) {
        heroSubtitle.textContent = `${comingSoonPart.trim()} ${defaultSubtitle}.`;
        return;
    }

    heroSubtitle.textContent = `${availablePart}${comingSoonPart} ${defaultSubtitle}.`.replace(/\s+/g, ' ').trim();
}

document.addEventListener('DOMContentLoaded', () => {
    updateHeroFromAvailableProducts();
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
