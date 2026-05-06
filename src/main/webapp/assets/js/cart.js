function addToCart(productId, quantity = 1) {
    const formData = new URLSearchParams();
    formData.append('action', 'add');
    formData.append('productId', productId);
    formData.append('quantity', quantity);

    fetch('cart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: formData
    })
    .then(response => {
        if (response.ok) {
            showToast('Added to cart!');
        } else if (response.status === 401) {
            navigateWithTransition('auth/login.jsp');
        } else {
            showToast('Failed to add to cart', 'error');
        }
    })
    .catch(err => console.error(err));
}

function updateCartQuantity(itemId, quantity) {
    const formData = new URLSearchParams();
    formData.append('action', 'update');
    formData.append('itemId', itemId);
    formData.append('quantity', quantity);

    fetch('cart', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: formData
    })
    .then(response => {
        if (response.ok) {
            reloadWithTransition();
        } else {
            showToast('Update failed', 'error');
        }
    });
}

function removeFromCart(itemId) {
    showRemoveItemModal(() => {
        const formData = new URLSearchParams();
        formData.append('action', 'remove');
        formData.append('itemId', itemId);

        fetch('cart', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: formData
        })
        .then(response => {
            if (response.ok) {
                reloadWithTransition();
            } else {
                showToast('Failed to remove item', 'error');
            }
        });
    });
}

function showRemoveItemModal(onConfirm) {
    const modalId = 'removeCartItemModal';
    let modal = document.getElementById(modalId);

    if (!modal) {
        modal = document.createElement('div');
        modal.id = modalId;
        modal.className = 'modal-overlay';
        modal.innerHTML = `
            <div class="modal-content">
                <div class="modal-icon">&#9888;</div>
                <h2 class="modal-title">Remove item?</h2>
                <p class="modal-text">Are you sure you want to remove this item from cart?</p>
                <div class="modal-buttons">
                    <button type="button" class="btn btn-outline" id="removeCartNoBtn">No, Keep it</button>
                    <button type="button" class="btn" id="removeCartYesBtn" style="background: #ef4444; color: white;">Yes, Remove</button>
                </div>
            </div>
        `;
        document.body.appendChild(modal);
    }

    const closeModal = () => {
        modal.classList.remove('active');
    };

    const noBtn = modal.querySelector('#removeCartNoBtn');
    const yesBtn = modal.querySelector('#removeCartYesBtn');

    noBtn.onclick = closeModal;
    yesBtn.onclick = () => {
        closeModal();
        onConfirm();
    };

    modal.onclick = (event) => {
        if (event.target === modal) {
            closeModal();
        }
    };

    modal.classList.add('active');
}