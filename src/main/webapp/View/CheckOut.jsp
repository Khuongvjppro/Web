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
<div class="container my-5">
    <h2 class="mb-4">Thanh toán</h2>
    <div class="row">
        <!-- Form thông tin giao hàng -->
        <div class="col-md-7">
            <h4>Thông tin giao hàng</h4>
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
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
