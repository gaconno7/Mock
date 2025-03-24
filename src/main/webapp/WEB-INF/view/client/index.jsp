<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:url value="/api/wishlists" var="APIWishlist"/>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Trang chủ</title>

  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
          integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
          crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js"
          integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
          crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js"
          integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
          crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  <link rel="stylesheet" href="<c:url value="/client/css/index.css" />">
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>

<body>
<%@ include file="header/header.jsp" %>

<section>
  <div class="container">
    <div class="row mt-5">
      <div class="bd-example">
        <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
          <ol class="carousel-indicators">
            <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
            <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
          </ol>
          <div class="carousel-inner" style="height: 60vh;">
            <div class="carousel-item active">
              <img src="https://spillmancrane.com/wp-content/uploads/2023/07/The-Importance-of-Professional-Tax-Planning-for-Small-Businesses.png"
                   class="d-block w-100 rounded object-fit" alt="..." >

            </div>
            <div class="carousel-item">
              <img src="https://media.bizj.us/view/img/10732556/dhl18*1200xx4000-2257-0-0.jpg"
                   class="d-block w-100 rounded object-fit" alt="...">

            </div>
            <div class="carousel-item">
              <img
                      src="https://antimatter.vn/wp-content/uploads/2022/05/thiet-ke-anh-sale.jpg"
                      class="d-block w-100 rounded object-fit" alt="...">

            </div>
          </div>
          <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
          </a>
          <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
          </a>
        </div>
      </div>
    </div>
    <div class="d-flex justify-content-between align-items-center featured mt-5">
      <h2 class="title border-start">Thể loại</h2>
      <div class="d-flex">
        <button id="scrollLeftCategory" class="btn btn-dark mr-3">←</button>
        <button id="scrollRightCategory" class="btn btn-dark">→</button>
    </div>
    </div>

    <div class="row mt-5 scroll-container" id="scrollContainerCategory">
      <div class="row flex-nowrap">
        <c:forEach items="${categories}" var="item">
        <div class="ml-3">
          <div class="card" style="overflow: hidden; width: 20vh;">
            <img src="${item.image}" class="rounded" alt="..." style="object-fit: cover; height: 80px">

              <a href="<c:url value="/product/all"/> " onclick="saveDataToLocalStorage(`${item.id}`)" class="card-title text-center ellipsis p-2 mt-2">${item.name}</a>

          </div>
        </div>
      </c:forEach>
      </div>
    </div>

    <div class="container mt-5">

      <div class="d-flex justify-content-between my-3">
        <button id="scrollLeftNew" class="btn btn-dark">←</button>
        <h2 class="text-center">Sản phẩm mới</h2>
        <button id="scrollRightNew" class="btn btn-dark">→</button>
      </div>

      <div class="scroll-container" id="scrollContainerNew">
        <div class="row flex-nowrap">
          <c:forEach var="item" items="${listTopProductByCreatedDate}">
          <div class="col-md-3">
            <div class="card">
              <c:if test="${not empty item.productImages}">
                <img src="${item.productImages[0].url}" class="card-img-top" alt="Sản phẩm 1">
              </c:if>

              <div class="action-buttons">
                <c:if test="${not empty sessionScope.user}">
                  <button class="action-button" onclick="addItemToWishlist(`${sessionScope.user.id}`, `${item.id}`)">
                    <i class="bi bi-heart"></i>
                  </button>
                </c:if>
                <button class="action-button">
                  <a href="<c:url value="/product/${item.id}"/>"><i class="bi bi-eye"></i></a>
                </button>
              </div>
              <div class="card-body">
                <h5 class="card-title">${item.name}</h5>
                <div class="d-flex justify-content-between">
                  <h4 class="card-text text-warning" style="font-size :18px">${item.price - (item.discountPrice * item.price)/100} đ</h4>
                  <h5 class="card-text text-danger" style="text-decoration: line-through;; font-size :18px">${item.price} đ</h5>
                </div>
                <div><i class="bi bi-star-fill"></i>
                  <i class="bi bi-star-fill"></i>
                  <i class="bi bi-star-fill"></i>
                  <i class="bi bi-star-fill"></i>
                  <i class="bi bi-star-fill"></i>
                </div>
                <div class="d-flex justify-content-between my-3 align-items-center">
                  <button class="btn btn-primary" onclick="addToCart('${item.id}', '${item.productVariants[0].id}')">
                    Thêm vào giỏ hàng   <i class="bi bi-cart"></i>
                  </button>
                </div>
                <a href="<c:url value="/over-view-store/${item.store.id}"/> " class="card-title"><i class="bi bi-shop"></i> ${item.store.name} </a>
              </div>
            </div>
          </div>
          </c:forEach>
        </div>
      </div>

    </div>
    <div class="featured mt-5">
      <h2 class="title border-start">Dành cho bạn</h2>
    </div>
    <div class="banner container p-5 rounded">
      <div class="content">
        <div class="title-banner ellipsis-60">${product.name}</div>
        <div class="information" style="margin-top: 20px;">
          <div class="info-item" style="margin-bottom: 10px;">
            <h4 class="info-label">Giá:&nbsp;&nbsp;
              <span class="info-value text-warning" style="color: orange; font-size :18px">${product.price - (product.discountPrice * product.price)/ 100}</span>
              <span class="info-value text-danger" style="text-decoration: line-through; color: red;; font-size :18px">${product.price}</span>
            </h4>
            </div>
          <div class="info-item" style="margin-bottom: 10px;">
            <h5 class="info-label">Danh mục:&nbsp; ${product.category.name}</h5>
            <h5 class="info-label"><i class="bi bi-shop"></i> ${product.store.name}</h5>
          </div>
        </div>
        <a href="#" class="buy-btn">Mua ngay</a>
        <a href="<c:url value="/product/${product.id}"/>" class="detail-btn">Xem chi tiết</a>
      </div>
      <div class="product-image">
        <img class="rounded" src="${product.image}" alt="JBL Speaker">
      </div>
    </div>
    <div class="featured mt-5">
      <h2 class="title border-start">Đặc biệt</h2>
    </div>
    <div class="products">
      <div class="product large">
        <img src="https://mir-s3-cdn-cf.behance.net/project_modules/1400/cfc06c131557391.61971f5fe8da4.png" alt="Hình ảnh">
        <div class="info">
          <h2>Sản phẩm chất lượng</h2>
        </div>
      </div>
      <div class="product small">
        <img src="https://www.lalamove.com/hs-fs/hubfs/driver%20lalamove%20angkat%20barang%20keluar%20dari%20van.jpeg?width=1800&height=1200&name=driver%20lalamove%20angkat%20barang%20keluar%20dari%20van.jpeg" alt="Hình ảnh">
        <div class="info">
          <h2>Giao hàng nhanh</h2>
        </div>
      </div>
      <div class="product small">
        <img src="https://th.bing.com/th/id/R.9072995a50497d67844d118babed3c62?rik=xQd3v4VWu9PSIA&riu=http%3a%2f%2ftamvuong.com%2fMedia%2fimages%2ftamvuong%2ftin-tuc%2fnhan-vien-cham-soc-khach-hang.jpg&ehk=2kbFgQLbAYKq158b2hb6mqKFnh3C8KNNMhLQmuGXPwM%3d&risl=&pid=ImgRaw&r=0" alt="Hình ảnh">
        <div class="info">
          <h2>Hỗ trợ 24/24</h2>
        </div>
      </div>
      <div class="product small">
        <img src="https://lamvugroup.vn/userfiles/files/cac-thuong-hieu-nhuong-quyen-viet-nam-3.jpg.jpg" alt="Hình ảnh">
        <div class="info">
          <h2>Thương hiệu độc quyền</h2>
        </div>
      </div>
      <div class="product small">
        <img src="https://logodix.com/logo/1764723.jpg" alt="Hình ảnh">
        <div class="info">
          <h2>Giá cả ưu đãi</h2>
        </div>
      </div>
    </div>
    <div class="container mt-5 mb-5">

      <!-- Nút bấm cuộn -->
      <div class="d-flex justify-content-between my-3">
        <button id="scrollLeftSell" class="btn btn-dark">←</button>
        <h2 class="text-center">Bán chạy</h2>
        <button id="scrollRightSell" class="btn btn-dark">→</button>
      </div>

      <!-- Danh sách sản phẩm -->
      <div class="scroll-container" id="scrollContainerSell">
        <div class="row flex-nowrap">
          <c:forEach var="item" items="${listSellingProducts}">
          <div class="col-md-3">
            <div class="card">
              <c:if test="${not empty item.productImages}">
                <img src="${item.productImages[0].url}" class="card-img-top" alt="Sản phẩm 1">
              </c:if>
              <div class="action-buttons">
                <c:if test="${not empty sessionScope.user}">
                  <button class="action-button" onclick="addItemToWishlist('${sessionScope.user.id}', '${item.id}')">
                    <i class="bi bi-heart"></i>
                  </button>
                </c:if>
                <button class="action-button">
                  <a href="<c:url value="/product/${item.id}"/> "><i class="bi bi-eye"></i></a>
                </button>
              </div>
              <div class="card-body">
                <h5 class="card-title">${item.name}</h5>
                <div class="d-flex justify-content-between">
                  <h4 class="card-text text-warning">${item.discountPrice}</h4>
                  <h5 class="card-text text-danger" style="text-decoration: line-through;">${item.price}</h5>
                </div>
                <div><i class="bi bi-star-fill"></i>
                  <i class="bi bi-star-fill"></i>
                  <i class="bi bi-star-fill"></i>
                  <i class="bi bi-star-fill"></i>
                  <i class="bi bi-star-fill"></i>
                </div>
                <div class="d-flex justify-content-between my-3 align-items-center">
                 <button class="btn btn-primary" onclick="addToCart('${item.id}', '${item.productVariants[0].id}')">
                   Thêm vào giỏ hàng   <i class="bi bi-cart"></i>
                   </button>
                </div>
                <a href="<c:url value="/over-view-store/${item.store.id}"/> " class="card-title"><i class="bi bi-shop"></i> ${item.store.name} </a>
              </div>
            </div>
          </div>
          </c:forEach>
        </div>
      </div>

    </div>
  </div>
</section>

<%@ include file="footer/footer.jsp" %>

<script>
  document.querySelectorAll('.action-button:first-child').forEach(button => {
    button.addEventListener('click', function () {
      const svg = this.querySelector('svg');
      if (svg.getAttribute('fill') === 'none') {
        svg.setAttribute('fill', '#e74c3c');
        svg.setAttribute('stroke', '#e74c3c');
      } else {
        svg.setAttribute('fill', 'none');
        svg.setAttribute('stroke', 'currentColor');
      }
    });
  });

</script>
<script>
  function saveDataToLocalStorage(value) {
    localStorage.setItem('categoryId', value);
  }

</script>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const scrollContainerNew = document.getElementById("scrollContainerNew");
    const btnLeftNew = document.getElementById("scrollLeftNew");
    const btnRightNew = document.getElementById("scrollRightNew");

    btnLeftNew.addEventListener("click", () => {
      scrollContainerNew.scrollBy({ left: -300, behavior: "smooth" });
    });

    btnRightNew.addEventListener("click", () => {
      scrollContainerNew.scrollBy({ left: 300, behavior: "smooth" });
    });

    const scrollContainerSell = document.getElementById("scrollContainerSell");
    const btnLeftSell = document.getElementById("scrollLeftSell");
    const btnRightSell = document.getElementById("scrollRightSell");

    btnLeftSell.addEventListener("click", () => {
      scrollContainerSell.scrollBy({ left: -300, behavior: "smooth" });
    });

    btnRightSell.addEventListener("click", () => {
      scrollContainerSell.scrollBy({ left: 300, behavior: "smooth" });
    });

    const scrollContainerCategory = document.getElementById("scrollContainerCategory");
    const btnLeftCategory = document.getElementById("scrollLeftCategory");
    const btnRightCategory = document.getElementById("scrollRightCategory");

    btnLeftCategory.addEventListener("click", () => {
      scrollContainerCategory.scrollBy({ left: -300, behavior: "smooth" });
    });

    btnRightCategory.addEventListener("click", () => {
      scrollContainerCategory.scrollBy({ left: 300, behavior: "smooth" });
    });
  });

  function addItemToWishlist(userId, productId) {
    const data = {
      userId : userId,
      productId : productId
    };
    console.log(data);
    $.ajax({
      url: `${APIWishlist}`,
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

  function addToCart(productId, selectedVariantId) {
    $.ajax({
      url: "/user/cart/add",
      type: "POST",
      data: {
        productId: productId,
        productVariantId: selectedVariantId,
        quantity: 1
      },
      success: function (response) {
        alert(response.message);
      },
      error: function () {
        alert("Lỗi khi thêm vào giỏ hàng!");
      }
    });
  }
</script>

<script src="<c:url value="/client/js/addWishlist.js"/> " type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>

</html>