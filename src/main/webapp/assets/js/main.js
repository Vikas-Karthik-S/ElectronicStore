document.addEventListener('DOMContentLoaded', () => {
    console.log('ElectronicStore Loaded');
    
    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });

    setupScrollFloatIn();

});

function navigateWithTransition(url, options = {}) {
    const { replace = false } = options;
    if (replace) {
        window.location.replace(url);
        return;
    }
    window.location.href = url;
}

function reloadWithTransition() {
    window.location.reload();
}

function setupScrollFloatIn() {
    const selectors = [
        'main section',
        '.product-card',
        '.category-card',
        '.cart-container',
        '.cart-item',
        '.order-summary',
        '.address-card',
        '.order-card',
        '.profile-card',
        '#checkoutForm > div',
        '#checkoutForm > div > div'
    ];

    const elements = Array.from(new Set(
        selectors.flatMap(selector => Array.from(document.querySelectorAll(selector)))
    ));

    if (!elements.length) return;

    if (!('IntersectionObserver' in window)) {
        elements.forEach(el => {
            el.classList.add('scroll-float', 'is-visible');
        });
        return;
    }

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (!entry.isIntersecting) return;
            requestAnimationFrame(() => {
                entry.target.classList.add('is-visible');
            });
            observer.unobserve(entry.target);
        });
    }, {
        threshold: 0.05,
        rootMargin: '0px 0px -18% 0px'
    });

    elements.forEach(el => {
        const top = el.getBoundingClientRect().top;
        const inInitialView = top < window.innerHeight * 0.9;

        el.classList.add('scroll-float');
        if (inInitialView) {
            el.classList.add('is-visible');
            return;
        }

        observer.observe(el);
    });
}

function showToast(message, type = 'success') {
    const toast = document.createElement('div');
    toast.className = `alert alert-${type} toast`;
    toast.style.position = 'fixed';
    toast.style.top = '20px';
    toast.style.right = '20px';
    toast.style.zIndex = '9999';
    toast.textContent = message;
    
    document.body.appendChild(toast);
    
    setTimeout(() => {
        toast.style.opacity = '0';
        setTimeout(() => toast.remove(), 500);
    }, 3000);
}