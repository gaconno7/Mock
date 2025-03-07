<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>

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
  <link rel="stylesheet" href="<c:url value="/css/style.css" />">
  <style>
    header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 15px 5%;
      border-bottom: 1px solid #eee;
    }

    .logo {
      font-weight: bold;
      font-size: 24px;
    }

    .nav-links {
      display: flex;
      gap: 30px;
    }

    .nav-links a {
      text-decoration: none;
      color: #333;
    }

    .search-container {
      display: flex;
      align-items: center;
      border: 1px solid #ddd;
      border-radius: 20px;
      padding: 5px 15px;
    }

    .search-container input {
      border: none;
      outline: none;
      padding: 5px;
      width: 200px;
    }

    .icons {
      display: flex;
      gap: 15px;
      align-items: center;
    }

    .breadcrumb {
      padding: 20px 5%;
      color: #777;
    }

    .breadcrumb a {
      color: #777;
      text-decoration: none;
    }

    .breadcrumb span {
      margin: 0 5px;
    }
    .ellipsis {
      white-space: nowrap;      /* Không xuống dòng */
      overflow: hidden;         /* Ẩn phần văn bản vượt quá kích thước */
      text-overflow: ellipsis;  /* Hiển thị dấu "..." khi quá dài */
      width: 150px;             /* Đặt kích thước cố định */
    }

  </style>
</head>

<body>
<header>
  <div class="logo">Exclusive</div>
  <div class="nav-links">
    <a href="#">Home</a>
    <a href="#">Contact</a>
    <a href="#">About</a>
    <a href="#">Sign Up</a>
  </div>
  <div class="search-container">
    <input type="text" placeholder="What are you looking for?">
    <span>🔍</span>
  </div>
  <div class="icons">
    <span>❤️</span>
    <span>🛒</span>
    <span>👤</span>
  </div>
</header>
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
          <div class="carousel-inner" style="height: 50vh;">
            <div class="carousel-item active">
              <img src="https://www.sliderrevolution.com/wp-content/uploads/2023/03/sr-avada-slider.jpg"
                   class="d-block w-100 rounded" alt="...">
              <div class="carousel-caption d-none d-md-block">
                <h5>First slide label</h5>
                <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
              </div>
            </div>
            <div class="carousel-item">
              <img src="https://www.sliderrevolution.com/wp-content/uploads/2020/05/sroverviewthumb.jpg"
                   class="d-block w-100 rounded" alt="...">
              <div class="carousel-caption d-none d-md-block">
                <h5>Second slide label</h5>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
              </div>
            </div>
            <div class="carousel-item">
              <img
                      src="https://dt2sdf0db8zob.cloudfront.net/wp-content/uploads/2018/07/Best-REALLY-FREE-Landing-Page-Builders-image10.png"
                      class="d-block w-100 rounded" alt="...">
              <div class="carousel-caption d-none d-md-block">
                <h5>Third slide label</h5>
                <p>Praesent commodo cursus magna, vel scelerisque nisl consectetur.</p>
              </div>
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
    <div class="featured mt-5">
      <h2 class="title border-start">Category</h2>
    </div>
    <div class="row mt-5">
      <c:forEach items="${categories}" var="item">
      <div class="col-2 mt-2">
        <div class="card" style="overflow: hidden;">
          <img
                  src="${item.image}"
                  class="rounded" alt="...">
          <div class="card-body">
            <a href="" class="card-title text-center ellipsis">${item.name}</a>
          </div>
        </div>
      </div>
      </c:forEach>
    </div>

    <div class="container mt-5">

      <!-- Nút bấm cuộn -->
      <div class="d-flex justify-content-between my-3">
        <button id="scrollLeft" class="btn btn-dark">←</button>
        <h2 class="text-center">Sản phẩm mới</h2>
        <button id="scrollRight" class="btn btn-dark">→</button>
      </div>

      <!-- Danh sách sản phẩm -->
      <div class="scroll-container" id="scrollContainer">
        <div class="row flex-nowrap">
          <c:forEach var="item" items="${listTopProductByCreatedDate}">
          <div class="col-md-3">
            <div class="card">
              <c:if test="${not empty item.productImages}">
                <img src="${item.productImages[0].url}" class="card-img-top" alt="Sản phẩm 1">
              </c:if>

              <div class="action-buttons">
                <button class="action-button">
                  <i class="bi bi-heart"></i>
                </button>
                <button class="action-button">
                  <a href="<c:url value="/product/${item.id}"/>"><i class="bi bi-eye"></i></a>
                </button>
              </div>
              <div class="card-body">
                <h5 class="card-title">${item.name}</h5>
                <div class="d-flex justify-content-between">
                  <h4 class="card-text text-warning">${item.price}</h4>
                  <h5 class="card-text text-danger" style="text-decoration: line-through;">${item.discountPrice}</h5>
                </div>
                <div><i class="bi bi-star-fill"></i>
                  <i class="bi bi-star-fill"></i>
                  <i class="bi bi-star-fill"></i>
                  <i class="bi bi-star-fill"></i>
                  <i class="bi bi-star-fill"></i>
                </div>
                <div class="d-flex justify-content-between my-3 align-items-center">
                  <a href="#" class="btn btn-primary">Thêm vào giỏ</a>
                </div>
              </div>
            </div>
          </div>
          </c:forEach>
        </div>
      </div>

    </div>
    <div class="featured mt-5">
      <h2 class="title border-start">Feature</h2>
    </div>
    <div class="banner container p-5 rounded">
      <div class="content">
        <div class="title-banner">Enhance Your Music Experience</div>
        <div class="countdown">
          <div>23 <br> Hours</div>
          <div>05 <br> Days</div>
          <div>59 <br> Minutes</div>
          <div>35 <br> Seconds</div>
        </div>
        <a href="#" class="buy-btn">Buy Now!</a>
      </div>
      <div class="product-image">
        <img class="rounded" src="https://www.insidehook.com/wp-content/uploads/2023/08/Hero-End-clothing-summer-sale.jpg?w=1200" alt="JBL Speaker">
      </div>
    </div>
    <div class="featured mt-5">
      <h2 class="title border-start">Feature</h2>
    </div>
    <div class="products">
      <div class="product large">
        <img src="https://www.insidehook.com/wp-content/uploads/2023/08/Hero-End-clothing-summer-sale.jpg?w=1200" alt="PlayStation 5">
        <div class="info">
          <h2>PlayStation 5</h2>
          <a href="#">Shop Now</a>
        </div>
      </div>
      <div class="product small">
        <img src="https://www.insidehook.com/wp-content/uploads/2023/08/Hero-End-clothing-summer-sale.jpg?w=1200" alt="Women's Collections">
        <div class="info">
          <h2>Women's Collections</h2>
          <a href="#">Shop Now</a>
        </div>
      </div>
      <div class="product small">
        <img src="https://www.insidehook.com/wp-content/uploads/2023/08/Hero-End-clothing-summer-sale.jpg?w=1200" alt="Speakers">
        <div class="info">
          <h2>Speakers</h2>
          <a href="#">Shop Now</a>
        </div>
      </div>
      <div class="product small">
        <img src="https://www.insidehook.com/wp-content/uploads/2023/08/Hero-End-clothing-summer-sale.jpg?w=1200" alt="Gucci Perfume">
        <div class="info">
          <h2>Gucci Perfume</h2>
          <a href="#">Shop Now</a>
        </div>
      </div>
      <div class="product small">
        <img src="https://www.insidehook.com/wp-content/uploads/2023/08/Hero-End-clothing-summer-sale.jpg?w=1200" alt="Gucci Perfume">
        <div class="info">
          <h2>Gucci Perfume</h2>
          <a href="#">Shop Now</a>
        </div>
      </div>
    </div>
    <div class="container mt-5">

      <!-- Nút bấm cuộn -->
      <div class="d-flex justify-content-between my-3">
        <button id="scrollLeft" class="btn btn-dark">←</button>
        <h2 class="text-center">Sản phẩm mới</h2>
        <button id="scrollRight" class="btn btn-dark">→</button>
      </div>

      <!-- Danh sách sản phẩm -->
      <div class="scroll-container" id="scrollContainer">
        <div class="row flex-nowrap">
          <c:forEach var="item" items="${listSellingProducts}">
          <div class="col-md-3">
            <div class="card">
              <c:if test="${not empty item.productImages}">
                <img src="${item.productImages[0].url}" class="card-img-top" alt="Sản phẩm 1">
              </c:if>
              <div class="action-buttons">
                <button class="action-button">
                  <i class="bi bi-heart"></i>
                </button>
                <button class="action-button">
                  <a href="<c:url value="/product/${item.id}"/> "><i class="bi bi-eye"></i></a>
                </button>
              </div>
              <div class="card-body">
                <h5 class="card-title">${item.name}</h5>
                <div class="d-flex justify-content-between">
                  <h4 class="card-text text-warning">${item.price}</h4>
                  <h5 class="card-text text-danger" style="text-decoration: line-through;">${item.discountPrice}</h5>
                </div>
                <div><i class="bi bi-star-fill"></i>
                  <i class="bi bi-star-fill"></i>
                  <i class="bi bi-star-fill"></i>
                  <i class="bi bi-star-fill"></i>
                  <i class="bi bi-star-fill"></i>
                </div>
                <div class="d-flex justify-content-between my-3 align-items-center">
                  <a href="#" class="btn btn-primary">Thêm vào giỏ</a>
                </div>
              </div>
            </div>
          </div>
          </c:forEach>
        </div>
      </div>

    </div>
  </div>
</section>


</div>

<script>
  // Add heart favorite functionality
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

  // Add view functionality (just for demonstration)
  document.querySelectorAll('.action-button:nth-child(2)').forEach(button => {
    button.addEventListener('click', function () {
      const productTitle = this.closest('.product-card').querySelector('.product-title').textContent;
      alert(`Quick view for: ${productTitle}`);
    });
  });

  // View All button
  document.querySelector('.view-all').addEventListener('click', function () {
    alert('View All Products clicked');
  });
</script>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const scrollContainer = document.getElementById("scrollContainer");
    const btnLeft = document.getElementById("scrollLeft");
    const btnRight = document.getElementById("scrollRight");

    btnLeft.addEventListener("click", () => {
      scrollContainer.scrollBy({ left: -300, behavior: "smooth" });
    });

    btnRight.addEventListener("click", () => {
      scrollContainer.scrollBy({ left: 300, behavior: "smooth" });
    });
  });


</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>

</html>