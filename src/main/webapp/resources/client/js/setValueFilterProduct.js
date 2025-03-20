let categoryId, sortBy, minPrice, maxPrice, searchValue;
if(categoryId === null && localStorage.getItem('categoryId') !== null) {
    categoryId = localStorage.getItem('categoryId');
    alert(categoryId);
    localStorage.removeItem('categoryId');
}
function setCategory(value) {
    categoryId = value;
    $(".category").removeClass("active-element-a")
    $("#category-id-" + categoryId).removeClass("active-element-a").addClass("active-element-a");
    loadProducts(0);
}

function setSortBy(value) {
    sortBy = value;
    loadProducts(0);
}

function setPrice() {
    minPrice = $("#min-price-value").val();
    maxPrice = $("#max-price-value").val();
    loadProducts(0);
}

function setSearchValue() {
    searchValue = $("#search-value").val();
    loadProducts(0);
}