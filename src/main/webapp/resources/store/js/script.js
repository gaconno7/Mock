
// Modal Functions
function openModal(modalId) {
    document.getElementById(modalId).style.display = 'flex';
}

function closeModal(modalId) {
    document.getElementById(modalId).style.display = 'none';
}

// Add Product Button
document.getElementById('addProductBtn').addEventListener('click', function () {
    openModal('addProductModal');
});

// Product Image Preview for Add Product
document.getElementById('productImage').addEventListener('change', function (e) {
    const file = e.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function (event) {
            const imagePreview = document.getElementById('imagePreview');
            imagePreview.innerHTML = `<img src="${event.target.result}" alt="Product Image">`;
            imagePreview.classList.add('has-image');
        };
        reader.readAsDataURL(file);
    }
});

// Product Image Preview for Edit Product
document.getElementById('editProductImage').addEventListener('change', function (e) {
    const file = e.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function (event) {
            document.getElementById('editProductImagePreview').src = event.target.result;
        };
        reader.readAsDataURL(file);
    }
});

// Sample product data for demo
const products = [
    {
        id: 1,
        name: 'The north coat',
        category: 'clothing',
        price: 260,
        discountPrice: 360,
        stock: 15,
        status: 'active',
        description: 'High-quality winter coat with thermal insulation.',
        image: '/placeholder.svg?height=200&width=200&text=North+Coat'
    },
    {
        id: 2,
        name: 'Gucci duffle bag',
        category: 'accessories',
        price: 960,
        discountPrice: 1160,
        stock: 8,
        status: 'active',
        description: 'Luxury duffle bag with signature Gucci pattern.',
        image: '/placeholder.svg?height=200&width=200&text=Gucci+Bag'
    },
    {
        id: 3,
        name: 'RGB liquid CPU Cooler',
        category: 'electronics',
        price: 160,
        discountPrice: 170,
        stock: 0,
        status: 'out-of-stock',
        description: 'Advanced liquid cooling system with RGB lighting for gaming PCs.',
        image: '/placeholder.svg?height=200&width=200&text=CPU+Cooler'
    },
    {
        id: 4,
        name: 'Small Bookshelf',
        category: 'furniture',
        price: 360,
        discountPrice: null,
        stock: 12,
        status: 'active',
        description: 'Compact wooden bookshelf, perfect for small spaces.',
        image: '/placeholder.svg?height=200&width=200&text=Bookshelf'
    },
    {
        id: 5,
        name: 'Wireless Headphones',
        category: 'electronics',
        price: 120,
        discountPrice: 150,
        stock: 0,
        status: 'draft',
        description: 'Noise-cancelling wireless headphones with long battery life.',
        image: '/placeholder.svg?height=200&width=200&text=Headphones'
    }
];

// Open Edit Modal with product data
function openEditModal(productId) {
    const product = products.find(p => p.id === productId);
    if (product) {
        document.getElementById('editProductId').value = product.id;
        document.getElementById('editProductName').value = product.name;
        document.getElementById('editProductCategory').value = product.category;
        document.getElementById('editProductPrice').value = product.price;
        document.getElementById('editProductDiscountPrice').value = product.discountPrice || '';
        document.getElementById('editProductStock').value = product.stock;
        document.getElementById('editProductStatus').value = product.status;
        document.getElementById('editProductDescription').value = product.description;
        document.getElementById('editProductImagePreview').src = product.image;

        openModal('editProductModal');
    }
}

// Open Delete Modal
function openDeleteModal(productId) {
    document.getElementById('deleteProductId').value = productId;
    openModal('deleteProductModal');
}

// Add Product Function
function addProduct() {
    // Get form values
    const name = document.getElementById('productName').value;
    const category = document.getElementById('productCategory').value;
    const price = document.getElementById('productPrice').value;
    const discountPrice = document.getElementById('productDiscountPrice').value;
    const stock = document.getElementById('productStock').value;
    const status = document.getElementById('productStatus').value;
    const description = document.getElementById('productDescription').value;

    // Validate form
    if (!name || !category || !price || !stock) {
        alert('Please fill in all required fields');
        return;
    }

    // In a real application, you would send this data to a server
    alert(`Product "${name}" has been added successfully!`);

    // Close modal and reset form
    document.getElementById('addProductForm').reset();
    document.getElementById('imagePreview').innerHTML = `
        <div class="placeholder">
            <i class="fas fa-cloud-upload-alt"></i>
            <p>Click to upload image</p>
        </div>
        `;
    document.getElementById('imagePreview').classList.remove('has-image');
    closeModal('addProductModal');

    // In a real application, you would refresh the product list
}

// Update Product Function
function updateProduct() {
    const productId = document.getElementById('editProductId').value;
    const name = document.getElementById('editProductName').value;
    const category = document.getElementById('editProductCategory').value;
    const price = document.getElementById('editProductPrice').value;
    const discountPrice = document.getElementById('editProductDiscountPrice').value;
    const stock = document.getElementById('editProductStock').value;
    const status = document.getElementById('editProductStatus').value;
    const description = document.getElementById('editProductDescription').value;

    // Validate form
    if (!name || !category || !price || !stock) {
        alert('Please fill in all required fields');
        return;
    }

    // In a real application, you would send this data to a server
    alert(`Product "${name}" has been updated successfully!`);

    // Close modal
    closeModal('editProductModal');

    // In a real application, you would refresh the product list
}

// Delete Product Function
function deleteProduct() {
    const productId = document.getElementById('deleteProductId').value;
    const product = products.find(p => p.id === parseInt(productId));

    if (product) {
        // In a real application, you would send this data to a server
        alert(`Product "${product.name}" has been deleted successfully!`);

        // Close modal
        closeModal('deleteProductModal');

        // In a real application, you would refresh the product list
    }
}
