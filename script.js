// Mobile menu toggle
const menuToggle = document.querySelector('.menu-toggle');
const navLinks = document.querySelector('.nav-links');

function setMenuOpen(open) {
    navLinks.classList.toggle('active', open);
    menuToggle.classList.toggle('is-open', open);
    menuToggle.setAttribute('aria-expanded', String(open));
}

menuToggle.addEventListener('click', () => {
    setMenuOpen(!navLinks.classList.contains('active'));
});

// Close mobile menu when clicking on a link
document.querySelectorAll('.nav-links a').forEach(link => {
    link.addEventListener('click', () => {
        setMenuOpen(false);
    });
});

// Smooth scroll for navigation links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        const href = this.getAttribute('href');
        if (!href || !href.startsWith('#') || href === '#') return;
        e.preventDefault();
        const target = document.querySelector(href);
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

// The hero has editorial copy; product availability is confirmed by JDR Farm.

// Add scroll animation for cards
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

if (!reduceMotion) {
    const revealObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('is-in');
                revealObserver.unobserve(entry.target);
            }
        });
    }, observerOptions);
    document.querySelectorAll('.card, .product-card').forEach(el => {
        el.classList.add('reveal');
        revealObserver.observe(el);
    });
}

// Navbar background on scroll
const navbar = document.querySelector('.navbar');

window.addEventListener('scroll', () => {
    navbar.classList.toggle('navbar--scrolled', window.pageYOffset > 24);
}, { passive: true });

const sectionLinks = [...document.querySelectorAll('.nav-links a[href^="#"]')];
const pageSections = sectionLinks
    .map(link => document.querySelector(link.getAttribute('href')))
    .filter(Boolean);

if (pageSections.length) {
    const setActiveLink = (id) => {
        sectionLinks.forEach(link => {
            const on = link.getAttribute('href') === `#${id}`;
            link.classList.toggle('is-active', on);
            if (on) link.setAttribute('aria-current', 'true');
            else link.removeAttribute('aria-current');
        });
    };
    const sectionObserver = new IntersectionObserver((entries) => {
        const visible = entries
            .filter(entry => entry.isIntersecting)
            .sort((a, b) => b.intersectionRatio - a.intersectionRatio)[0];
        if (visible) setActiveLink(visible.target.id);
    }, { rootMargin: '-20% 0px -55% 0px', threshold: [0.15, 0.4, 0.6] });
    pageSections.forEach(section => sectionObserver.observe(section));
    setActiveLink('home');
}

const heroFeature = document.querySelector('.hero-feature');
const heroSlides = [...document.querySelectorAll('.hero-slide')];
const heroDots = [...document.querySelectorAll('.hero-dots button')];
const heroKicker = document.querySelector('.hero-kicker');
const heroCaption = document.querySelector('.hero-caption-text');

if (heroFeature && heroSlides.length) {
    let heroIndex = 0;
    let heroTimer = null;

    const showHero = (next) => {
        heroIndex = (next + heroSlides.length) % heroSlides.length;
        heroSlides.forEach((slide, index) => {
            const on = index === heroIndex;
            slide.classList.toggle('is-active', on);
            slide.setAttribute('aria-hidden', String(!on));
        });
        heroDots.forEach((dot, index) => {
            const on = index === heroIndex;
            dot.classList.toggle('is-active', on);
            dot.setAttribute('aria-selected', String(on));
        });
        const slide = heroSlides[heroIndex];
        if (heroKicker) heroKicker.textContent = slide.dataset.kicker || '';
        if (heroCaption) heroCaption.textContent = slide.dataset.caption || '';
        heroFeature.classList.toggle('is-grove', slide.dataset.fit === 'cover');
    };

    const stopHero = () => {
        if (heroTimer) clearInterval(heroTimer);
        heroTimer = null;
    };

    const playHero = () => {
        if (reduceMotion) return;
        stopHero();
        heroTimer = setInterval(() => showHero(heroIndex + 1), 4500);
    };

    heroDots.forEach((dot, index) => {
        dot.addEventListener('click', () => {
            showHero(index);
            playHero();
        });
    });

    heroFeature.addEventListener('mouseenter', stopHero);
    heroFeature.addEventListener('mouseleave', playHero);
    heroFeature.addEventListener('focusin', stopHero);
    heroFeature.addEventListener('focusout', (event) => {
        if (!heroFeature.contains(event.relatedTarget)) playHero();
    });
    document.addEventListener('visibilitychange', () => {
        if (document.hidden) stopHero();
        else playHero();
    });

    showHero(0);
    playHero();
}

// Each product opens a WhatsApp enquiry with the current pack size prefilled.
document.querySelectorAll('.product-card[data-product]').forEach(card => {
    const select = card.querySelector('select');
    const link = card.querySelector('[data-enquire]');
    if (!select || !link) return;
    const updateLink = () => {
        const product = card.dataset.product;
        const message = `Hello JD, I am interested in ${product}. Quantity: *${select.value}* from your website. Could you please confirm its availability and price? Thank you.`;
        link.href = `https://wa.me/919150150932?text=${encodeURIComponent(message)}`;
        link.setAttribute('aria-label', `Buy Now: ${product}, ${select.value}`);
    };
    select.addEventListener('change', updateLink);
    updateLink();
    link.target = '_blank';
    link.rel = 'noopener noreferrer';
});
