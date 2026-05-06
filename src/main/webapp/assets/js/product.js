function getContextPath() {
    return window.location.pathname.substring(0, window.location.pathname.indexOf('/', 1));
}

function filterByCategory(categoryId) {
    const url = new URL(window.location.href);
    if (categoryId) url.searchParams.set('category', categoryId);
    else url.searchParams.delete('category');
    navigateWithTransition(url.toString());
}

function searchProducts() {
    const query = document.getElementById('searchInput').value;
    if (query) {
        navigateWithTransition(getContextPath() + '/products?search=' + encodeURIComponent(query));
    }
}

const priceForm = document.getElementById('priceFilterForm');
if (priceForm) {
    priceForm.addEventListener('submit', function(e) {
        e.preventDefault();
        const min = this.querySelector('[name="minPrice"]').value;
        const max = this.querySelector('[name="maxPrice"]').value;
        
        const url = new URL(window.location.href);
        if (min) url.searchParams.set('minPrice', min);
        else url.searchParams.delete('minPrice');
        
        if (max) url.searchParams.set('maxPrice', max);
        else url.searchParams.delete('maxPrice');
        
        navigateWithTransition(url.toString());
    });
}

const sortSelect = document.getElementById('sortSelect');
if (sortSelect) {
    sortSelect.addEventListener('change', function() {
        const url = new URL(window.location.href);
        url.searchParams.set('sort', this.value);
        navigateWithTransition(url.toString());
    });
}

document.addEventListener('DOMContentLoaded', () => {
    setupFiltersSidebarLock();
});

function setupFiltersSidebarLock() {
    const sidebar = document.querySelector('.filters-sidebar');
    if (!sidebar) return;

    const updateStickyTop = () => {
        const header = document.querySelector('header');
        const headerHeight = header ? header.offsetHeight : 70;
        const minTop = headerHeight + 16;
        const desiredTop = window.innerHeight - sidebar.offsetHeight - 20;
        const stickyTop = Math.min(minTop, desiredTop);
        sidebar.style.setProperty('--filters-sticky-top', `${stickyTop}px`);
    };

    window.addEventListener('resize', updateStickyTop);
    updateStickyTop();
}