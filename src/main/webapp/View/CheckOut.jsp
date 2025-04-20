<%@ page import="com.banthatlung.Dao.model.ProductCart" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int total = 0;
    HashMap<Integer, ProductCart> carts = (HashMap<Integer, ProductCart>) request.getAttribute("cart");
    if (carts != null) {
        for (Map.Entry<Integer, ProductCart> entry : carts.entrySet()) {
            ProductCart item = entry.getValue();
            total += item.getQuantity() * item.getProduct().getPrice();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Trang Thanh Toán</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</head>
<body>
<<<<<<< HEAD
<div class="container my-5">
    <h2 class="mb-4">Thanh toán</h2>
    <div class="row">
        <!-- Form thông tin giao hàng -->
        <div class="col-md-7">
            <h4>Thông tin giao hàng</h4>
=======
<header>
    <div id="fullscreen-search" class="fullscreen-search">
        <span class="close-btn">&times;</span>
        <div class="search-container">
            <div class="search-box">
                <input type="text" class="search-input" placeholder="Search..">
                <button class="search-icon">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </button>
            </div>
        </div>
    </div>
    <div class="header">
        <a href="home.html"><h1>Trang chủ</h1></a>
        <div class="menu">
            <div class="dropdown">
                <a href="danhmucsp.html">Danh mục sản phẩm</a>
                <div class="dropdown-content">
                    <a href="#">Thắt lưng nam</a>
                    <a href="#">Thắt lưng nữ</a>
                </div>
            </div>
            <a href="#">Giới thiệu</a>
            <a href="#">Chính sách </a>
            <a href="#">Liên hệ</a>
        </div>
        <div class="icons">
            <a href="#" id="open-search"><i class="fa-solid fa-magnifying-glass"></i></a>
            <div class="dropdown-user">
                <a href="profile.html"><i class="fa-solid fa-user"></i></a>
                <div class="dropdown-content-user">
                    <a href="Login.html">Đăng nhập</a>
                </div>
            </div>
            <a href="Cart.html"><i class="fa-solid fa-cart-shopping"></i></a>
        </div>
    </div>
</header>
<script src="../fullscreensearch.js"></script>

<main class="checkout-container">
    <h2>Thanh toán</h2>
    <div class="checkout-content">
        <!-- Order Summary -->
        <div class="order-summary">
            <h3>Các sản phẩm: </h3>
            <ul>
                <c:if test="${cart != null}">
                <%
                    int total = 0;
                    HashMap<Integer, ProductCart> carts = (HashMap<Integer, ProductCart>) request.getAttribute("cart");
                    for (Map.Entry<Integer, ProductCart> entry : carts.entrySet()) {
                        Integer key = entry.getKey();
                        ProductCart value = entry.getValue();
                        total += value.getQuantity() * value.getProduct().getPrice();
                %>
                <li> - <%= value.getProduct().getName()%><span><%= value.getProduct().getPrice()%></span>x <%= value.getQuantity()%></li>

                <% } %>

                <li class="total">Tổng cộng :<span><%=total%></span></li>
            </ul>
        </div>
        </c:if>
        <!-- Payment Form -->
        <div class="payment-form">
            <h3>Chi tiết đơn hàng </h3>
>>>>>>> 992599882de8e023a8645083283aba6d10675d56
            <form method="POST">
                <div class="mb-3">
                    <label for="name" class="form-label">Họ và tên</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Nhập họ và tên">
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Nhập email">
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Số điện thoại</label>
                    <input type="text" class="form-control" id="phone" name="phone" placeholder="Nhập số điện thoại">
                </div>
<<<<<<< HEAD
                <div class="mb-3">
                    <label for="address" class="form-label">Địa chỉ</label>
                    <input type="text" class="form-control" id="address" name="address" placeholder="Nhập địa chỉ">
                </div>
                <div class="mb-4">
                    <label class="form-label">Phương thức thanh toán</label><br>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="cod" value="COD" checked>
                        <label class="form-check-label" for="cod">
                            Thanh toán khi nhận hàng (COD)
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="vnpay" value="VNPay">
                        <label class="form-check-label" for="vnpay">
                            Thanh toán bằng VNPay
                        </label>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary">Xác nhận thanh toán</button>
=======
                <div class="form-group">
                    <label for="province">Tỉnh/Thành phố</label>
                    <select id="province" class="form-control" onchange="loadDistricts()"></select>
                </div>

                <div class="form-group">
                    <label for="district">Quận/Huyện</label>
                    <select id="district" class="form-control" onchange="loadWards()"></select>
                </div>

                <div class="form-group">
                    <label for="ward">Phường/Xã</label>
                    <select id="ward" class="form-control"></select>
                </div>

                <button type="submit" class="btn btn-primary">Submit</button>
>>>>>>> 992599882de8e023a8645083283aba6d10675d56
            </form>
        </div>

        <!-- Tóm tắt đơn hàng -->
        <div class="col-md-5">
            <h4>Đơn hàng của bạn</h4>
            <ul class="list-group mb-3">
                <c:if test="${cart != null}">
                    <%
                        for (Map.Entry<Integer, ProductCart> entry : carts.entrySet()) {
                            ProductCart item = entry.getValue();
                            int price = item.getProduct().getPrice();
                            int quantity = item.getQuantity();
                    %>
                    <li class="list-group-item d-flex justify-content-between lh-sm">
                        <div>
                            <h6 class="my-0"><%= item.getProduct().getName() %></h6>
                            <small class="text-muted">x <%= quantity %></small>
                        </div>
                        <span class="text-muted"><%= String.format("%,d", price * quantity) %>đ</span>
                    </li>
                    <% } %>
                </c:if>

                <li class="list-group-item d-flex justify-content-between">
                    <span><strong>Tổng cộng</strong></span>
                    <strong><%= String.format("%,d", total) %>đ</strong>
                </li>
            </ul>
        </div>
    </div>
<<<<<<< HEAD
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
=======
    <div class="footer-bottom">
        <p>&copy; 2024 Chuyên cung cấp thắt lưng các loại. Hotline: <a href="tel:0397526965">0397526965</a></p>
    </div>
</footer>
<script>
    let provinceData = [];

    fetch('<%=request.getContextPath()%>/api/locations')
        .then(res => res.json())
        .then(rawData => {
            // Convert object to array
            provinceData = Object.entries(rawData).map(([provinceCode, provinceObj]) => ({
                code: provinceCode,
                name: provinceObj.name,
                districts: Object.entries(provinceObj["quan-huyen"]).map(([districtCode, districtObj]) => ({
                    code: districtCode,
                    name: districtObj.name,
                    wards: Object.entries(districtObj["xa-phuong"]).map(([wardCode, wardObj]) => ({
                        code: wardCode,
                        name: wardObj.name
                    }))
                }))
            }));

            // Load tỉnh
            const provinceSelect = document.getElementById("province");
            provinceData.forEach((province, i) => {
                const opt = document.createElement("option");
                opt.value = i;
                opt.text = province.name;
                provinceSelect.appendChild(opt);
            });
        })
        .catch(err => {
            console.error("Lỗi tải JSON:", err);
            alert("Không thể tải dữ liệu địa phương!");
        });

    function loadDistricts() {
        const provinceIndex = document.getElementById("province").value;

        // Debug dữ liệu:
        console.log("provinceIndex =", provinceIndex);
        console.log("provinceData =", provinceData);
        console.log("provinceData[provinceIndex] =", provinceData[provinceIndex]);

        const districtSelect = document.getElementById("district");
        const wardSelect = document.getElementById("ward");

        districtSelect.innerHTML = '<option value="">Chọn quận/huyện</option>';
        wardSelect.innerHTML = '<option value="">Chọn phường/xã</option>';

        if (provinceIndex === "") return;

        const province = provinceData[provinceIndex];
        if (!province || !province.districts) {
            alert("Không có dữ liệu quận/huyện cho tỉnh được chọn");
            return;
        }

        province.districts.forEach((district, i) => {
            const opt = document.createElement("option");
            opt.value = i;
            opt.text = district.name;
            districtSelect.appendChild(opt);
        });
    }

    function loadWards() {
        const provinceIndex = document.getElementById("province").value;
        const districtIndex = document.getElementById("district").value;
        const wardSelect = document.getElementById("ward");

        wardSelect.innerHTML = '<option value="">Chọn phường/xã</option>';

        if (provinceIndex === "" || districtIndex === "") return;

        const wards = provinceData[provinceIndex].districts[districtIndex].wards;
        wards.forEach((ward) => {
            const opt = document.createElement("option");
            opt.value = ward.code;
            opt.text = ward.name;
            wardSelect.appendChild(opt);
        });
    }
</script>
>>>>>>> 992599882de8e023a8645083283aba6d10675d56
</body>
</html>