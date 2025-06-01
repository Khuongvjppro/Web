<%@ page import="java.util.HashMap" %>
<%@ page import="com.banthatlung.Dao.model.ProductCart" %>
<%@ page import="java.util.Map" %><%--
  Created by IntelliJ IDEA.
  User: BAO ANH
  Date: 12/20/2024
  Time: 3:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Shopping Cart</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%--  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">--%>
    <%--  <link rel="stylesheet" href="asset/css/bootstrap.css">--%>
    <%--  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">--%>
    <%--  <link rel="stylesheet" href="asset/css/style.css">--%>
    <%--  <link rel="stylesheet" href="header.css">--%>
    <%--  <link rel="stylesheet" href="asset/fontawsome/fontawsome/css/all.css">--%>
    <%--  <link rel="stylesheet" href="footer.css">--%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        <%@include file="/asset/css/style.css" %>
    </style>

    <style>
        <%@include file="../css/footer.css" %>
    </style>
    <style>
        <%@include file="/css/header.css" %>
    </style>
    <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<!--Header-->
<header class="bg-dark text-white py-3">
    <div class="container d-flex justify-content-between align-items-center">
        <!-- Logo và Trang chủ -->
        <a href="${pageContext.request.contextPath}/home" class="text-white">
            <h1 class="m-0">Trang chủ</h1>
        </a>

        <!-- Menu điều hướng -->
        <div class="menu d-flex">
            <a href="${pageContext.request.contextPath}/home" class="text-white mx-3">Danh mục sản phẩm</a>
            <a href="#" class="text-white mx-3">Giới thiệu</a>
            <a href="#" class="text-white mx-3">Chính sách</a>
            <a href="#" class="text-white mx-3">Liên hệ</a>
        </div>


        <div class="icons d-flex pt-1"  >

            <div class="dropdown pt-1">
                <a href="#" class="text-white mx-2" id="user-dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fa-solid fa-user"></i>
                </a>
                <ul class="dropdown-menu" aria-labelledby="user-dropdown-toggle">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/change-password">Đổi mật khẩu</a></li>
                </ul>
            </div>

            <div class="search-container me-4">
                <form action="${pageContext.request.contextPath}/search" method="get">
                    <div class="input-group input-group-sm">
                        <input type="text" class="form-control" name="search" placeholder="Tìm kiếm...">
                        <button class="btn btn-sm btn-outline-secondary" type="submit">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </div>
                </form>
            </div>

            <a href="<%=request.getContextPath()%>/Cart?action=showCart" class="text-white mx-2 pt-1"><i class="fa-solid fa-cart-shopping fa-lg"></i></a>
        </div>

    </div>
</header>
<script src="../fullscreensearch.js"></script>
<!--CONTAINER CART-->
<main class="page">
    <section class="shopping-cart dark">
        <div class="container">
            <div class="block-heading">
                <h2>Giỏ Hàng</h2>

            </div>
            <div class="content">
                <div class="row">
                    <div class="col-md-12 col-lg-8">
                        <div class="items">
                            <div class="product">
                                <c:choose>
                                <c:when test="${cart != null}">
                                <%
                                    int total = 0;
                                    HashMap<Integer, ProductCart> carts = (HashMap<Integer, ProductCart>) request.getAttribute("cart");
                                    for (Map.Entry<Integer, ProductCart> entry : carts.entrySet()) {
                                        Integer key = entry.getKey();
                                        ProductCart value = entry.getValue();
                                        total += value.getQuantity() * value.getProduct().getPrice();
                                %>
                                <div class="row">
                                    <div class="col-md-3">
                                        <img class="img-fluid mx-auto d-block image fix_img_inCart"
                                             src="images/<%= value.getProduct().getImage()%>" alt="">
                                    </div>
                                    <div class="col-md-8">
                                        <div class="info">
                                            <div class="row">
                                                <div class="col-md-5 product-name">
                                                    <div class="product-name">
                                                        <a href="#"><%= value.getProduct().getName()%>
                                                        </a>
                                                        <div class="product-info">
                                                            <div>Loại thắt lưng: <span
                                                                    class="value"><%= value.getProduct().getDescription()%></span>
                                                            </div>
                                                            <div>Màu sắc : <span class="value">Màu đen</span></div>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4 quantity">
                                                        <%--                                                        <p class="quantity"><%= value.getProduct().getId()%>--%>
                                                    </p>
                                                    <div class="quantity-control">
                                                        <a href="<%=request.getContextPath()%>/Cart?action=decrease&id=<%=key%>">
                                                            <button type="button" class="quantity-decrease">-</button>
                                                        </a>
                                                        <input type="text" value="<%= value.getQuantity() %>"
                                                               class="quantity-input"
                                                               data-max-stock="<%= value.getProduct().getQuantity() %>">
                                                        <a href="<%=request.getContextPath()%>/Cart?action=increase&id=<%=key%>">
                                                            <button type="button" class="quantity-increase">+</button>
                                                        </a>
                                                        <span class="available-stock"><%= value.getProduct().getQuantity() %> sản phẩm có sẵn</span>
                                                    </div>
                                                </div>
                                                <div class="col-md-2 price">
                                                    <span><%= value.getProduct().getPrice()%></span>
                                                </div>
                                                <div class="col-md-1 price" style="left: 51px">
                                                    <a href="<%=request.getContextPath()%>/Cart?action=remove&id=<%= value.getProduct().getId()%>"><i
                                                            class="fa-solid fa-x" style="color: red"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% } %>

                            </div>

                        </div>
                    </div>
                    <div class="col-md-12 col-lg-4">
                        <div class="summary">
                            <h3>Thông tin đơn hàng</h3>

                            <div class="summary-item"><span class="text">Tổng cộng </span><span
                                    class="price"> <%= total%></span>
                            </div>
                            <a href="<%=request.getContextPath()%>/Cart?action=checkOut">
                                <button type="button" class="btn btn-primary btn-lg btn-block">Xác nhận</button>
                            </a>
                            <p class="text phivan">Phí vận chuyển sẽ được tính ở trang thanh toán.</p>
                            Để nhận tư vấn hoặc hỗ trợ khi phát sinh khó khăn trong lúc mua hàng, hãy liên hệ Biti's
                            thông qua:
                            <div>
                                <ul class="help">
                                    <li class="help_li">Gọi 0966.158.666 (cho Việt Nam)
                                    </li>
                                    <li class="help_li">chamsocKH@gmail.com.vn</li>
                                </ul>
                            </div>
                        </div>
                    </div>

            </div></c:when>
                <c:otherwise>
                <h1>Bạn không có sản phẩm nào trong giỏ</h1></div>
            </c:otherwise>
            </c:choose>
        </div>
        </div>
    </section>
</main>
<footer class="bg-dark text-white py-4">
    <div class="container">
        <!-- Thông tin giới thiệu và các mạng xã hội -->
        <div class="row text-center mb-4">
            <div class="col-12">
                <p>CHUYÊN CUNG CẤP CÁC LOẠI THẮT LƯNG.</p>
                <p>Chất lượng - Uy tín - Tin cậy</p>
            </div>
            <div class="col-12">
                <div class="social-icons">
                    <a href="https://www.facebook.com" target="_blank" class="text-white mx-2">
                        <i class="fa-brands fa-facebook fa-2x"></i>
                    </a>
                    <a href="https://www.instagram.com" target="_blank" class="text-white mx-2">
                        <i class="fa-brands fa-instagram fa-2x"></i>
                    </a>
                    <a href="https://www.youtube.com" target="_blank" class="text-white mx-2">
                        <i class="fa-brands fa-youtube fa-2x"></i>
                    </a>
                    <a href="https://www.twitter.com" target="_blank" class="text-white mx-2">
                        <i class="fa-brands fa-twitter fa-2x"></i>
                    </a>
                </div>
            </div>
        </div>

        <!-- Các liên kết footer (4 mục nằm ngang) -->
        <div class="row mb-4">
            <div class="col-lg-3 col-md-6">
                <h5>Sản phẩm</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-white">Thắt lưng nam</a></li>
                    <li><a href="#" class="text-white">Thắt lưng nữ</a></li>
                    <li><a href="#" class="text-white">Phụ kiện</a></li>
                    <li><a href="#" class="text-white">Khuyến mãi</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5>Chính sách</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-white">Chính sách đổi trả</a></li>
                    <li><a href="#" class="text-white">Chính sách bảo mật</a></li>
                    <li><a href="#" class="text-white">Chính sách vận chuyển</a></li>
                    <li><a href="#" class="text-white">Hướng dẫn thanh toán</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5>Hỗ trợ</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-white">Liên hệ</a></li>
                    <li><a href="#" class="text-white">Hỗ trợ</a></li>
                    <li><a href="#" class="text-white">Tuyển dụng</a></li>
                </ul>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5>Liên hệ</h5>
                <p>Địa chỉ: Số 8, Tam Bình, Thủ Đức</p>
                <p>Điện thoại: 0397526965</p>
                <p>Email: <a href="mailto:storethatlung@gmail.com" class="text-white">storethatlung@gmail.com</a></p>
                <p>Thời gian làm việc: 8:00 - 22:00 (hàng ngày)</p>
            </div>
        </div>

        <!-- Thông tin bản quyền -->
        <div class="footer-bottom text-center">
            <p>&copy; 2024 Chuyên cung cấp thắt lưng các loại. Hotline: <a href="tel:0397526965" class="text-white">0397526965</a></p>
        </div>
    </div>
</footer>




<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Chọn tất cả các phần tử giảm, tăng và nhập số lượng
    // Chọn tất cả các phần tử giảm, tăng và nhập số lượng
    const decreaseButtons = document.querySelectorAll('.quantity-decrease');
    const increaseButtons = document.querySelectorAll('.quantity-increase');
    const quantityInputs = document.querySelectorAll('.quantity-input');

    // Duyệt qua tất cả các nút giảm số lượng
    decreaseButtons.forEach((button, index) => {
        button.addEventListener('click', () => {
            let input = quantityInputs[index];
            let currentQuantity = parseInt(input.value, 10); // Lấy số lượng hiện tại
            if (currentQuantity > 1) {
                input.value = currentQuantity - 1; // Giảm số lượng nếu lớn hơn 1
            }
        });
    });

    // Duyệt qua tất cả các nút tăng số lượng
    increaseButtons.forEach((button, index) => {
        button.addEventListener('click', () => {
            let input = quantityInputs[index];
            let currentQuantity = parseInt(input.value, 10); // Lấy số lượng hiện tại
            let maxStock = parseInt(input.getAttribute('data-max-stock'), 10); // Lấy số lượng tối đa
            if (currentQuantity < maxStock) {
                input.value = currentQuantity + 1; // Tăng số lượng nếu chưa đạt tối đa
            }
        });
    });

    // Duyệt qua tất cả các ô nhập số lượng
    quantityInputs.forEach((input) => {
        input.addEventListener('input', () => {
            let currentValue = parseInt(input.value, 10);
            let maxStock = parseInt(input.getAttribute('data-max-stock'), 10); // Lấy số lượng tối đa

            // Nếu nhập sai hoặc nhỏ hơn 1, tự động đặt về 1
            if (isNaN(currentValue) || currentValue < 1) {
                input.value = 1;
            }

            // Nếu vượt quá số lượng tối đa, đặt về số lượng tối đa
            if (currentValue > maxStock) {
                input.value = maxStock;
            }
        });
    });


</script>
</body>


</html>

}