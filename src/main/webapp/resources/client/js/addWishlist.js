function addItemToWishlist(userId, productId) {
    const data = {
        userId : userId,
        productId : productId
    };
    console.log(data);
    $.ajax({
        url: `/api/wishlists`,
        type: 'POST',
        contentType : 'application/json',
        data: JSON.stringify(data),
        success: function (response) {
            console.log(response);
        },
        error: function (error) {
            console.log(error)
        }
    })
}