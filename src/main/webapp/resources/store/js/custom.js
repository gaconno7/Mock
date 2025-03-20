// Modal delete
$('#deleteModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    var userId = button.data('entity-id');
    var userName = button.data('entity-name');

    // Cập nhật giá trị userId vào input ẩn trong modal
    var modal = $(this);
    modal.find('input[name="id"]').val(userId);
    modal.find('span[id="entityName"]').text(userName);
});

// Password show/hide
$(document).ready(function () {
    $("#show_hide_password a").on('click', function (event) {
        event.preventDefault();
        if ($('#show_hide_password input').attr("type") == "text") {
            $('#show_hide_password input').attr('type', 'password');
            $('#show_hide_password i').addClass("fa-eye-slash");
            $('#show_hide_password i').removeClass("fa-eye");
        } else if ($('#show_hide_password input').attr("type") == "password") {
            $('#show_hide_password input').attr('type', 'text');
            $('#show_hide_password i').removeClass("fa-eye-slash");
            $('#show_hide_password i').addClass("fa-eye");
        }
    });
});

// Formating price
$(document).ready(function () {
    var priceValue = $('#price').val();
    if (priceValue) {
        var formattedValue = parseFloat(priceValue).toFixed(2);
        $('#price').val(formattedValue);
    }
});

// Uploading Image
$(document).ready(() => {
    const avatarFile = $("#avatarFile");
    avatarFile.change(function (e) {
        const imgURL = URL.createObjectURL(e.target.files[0]);
        $("#avatarPreview").attr("src", imgURL);
        $("#avatarPreview").css({ "display": "block" });
    });
});
$(document).ready(() => {
    const avatarFile = $("#avatarFile");
    const orgImage = "${currentProduct.image}";
    if (orgImage) {
        const urlImage = "/admin/images/product/" + orgImage;
        $("#avatarPreview").attr("src", urlImage);
        $("#avatarPreview").css({ "display": "block" });
    }

    avatarFile.change(function (e) {
        const imgURL = URL.createObjectURL(e.target.files[0]);
        $("#avatarPreview").attr("src", imgURL);
        $("#avatarPreview").css({ "display": "block" });
    });
});