<%@ page import="com.banthatlung.Dao.model.ProductCart" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Checkout Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkOut.css">
    <style>
        /* Giữ nguyên CSS cũ + Thêm CSS mới */
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0; padding: 0;
        }
        .checkout-container {
            max-width: 900px;
            margin: 30px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        h2 { text-align: center; margin-bottom: 20px; }
        .checkout-content { display: flex; flex-wrap: wrap; gap: 20px; }
        .order-summary, .payment-form {
            flex: 1; min-width: 300px; padding: 15px;
            background-color: #fafafa; border: 1px solid #ddd; border-radius: 8px;
        }
        .order-summary ul { list-style: none; padding: 0; }
        .order-summary li { padding: 5px 0; font-size: 16px; }
        .order-summary .total { font-weight: bold; font-size: 18px; }
        .payment-form label { display: block; margin: 10px 0 5px; font-weight: bold; }
        .payment-form input, .payment-form select {
            width: 100%; padding: 8px; margin-bottom: 10px;
            border: 1px solid #ccc; border-radius: 4px;
        }
        .payment-form button {
            width: 100%; padding: 10px;
            background-color: #28a745; color: white; border: none;
            border-radius: 4px; font-size: 16px;
        }
        .payment-form button:hover { background-color: #218838; }
        .payment-form p { font-size: 14px; margin: 5px 0; }
    </style>
</head>
<body>
<div class="checkout-container">
    <h2>Thanh toán</h2>
    <div class="checkout-content">
        <div class="order-summary">
            <h3>Các sản phẩm:</h3>
            <ul>
                <c:if test="${cart != null}">
                    <%
                        HashMap<Integer, ProductCart> carts = (HashMap<Integer, ProductCart>) request.getAttribute("cart");
                        for (Map.Entry<Integer, ProductCart> entry : carts.entrySet()) {
                            ProductCart value = entry.getValue();
                    %>
                    <li><%= value.getProduct().getName() %> - <%= value.getProduct().getPrice() %> x <%= value.getQuantity() %></li>
                    <% } %>
                </c:if>
            </ul>
        </div>

        <div class="payment-form">
            <h3>Chi tiết đơn hàng</h3>
            <form method="POST">
                <label>Tên</label>
                <input type="text" name="name" placeholder="Tên">
                <label>SĐT</label>
                <input type="text" name="phone" placeholder="Số điện thoại">
                <label>Tỉnh/Thành phố</label>
                <select id="province" name="province" onchange="loadDistricts();updateShippingFee()"></select>
                <label>Quận/Huyện</label>
                <select id="district" name="district" onchange="loadWards()"></select>
                <label>Phường/Xã</label>
                <select id="ward" name="ward"></select>
                <p>Phí ship: <span id="shippingFee">0</span> VND</p>
                <p>Tổng cộng: <span id="totalAmount"><%= request.getAttribute("total") %></span> VND</p>
                <input type="hidden" name="totalAmount" id="totalAmountInput" value="<%= request.getAttribute("total") %>">
                <button type="submit">Xác nhận</button>
            </form>
        </div>
    </div>
</div>

<script>
    let provinceData = [];
    fetch('<%=request.getContextPath()%>/api/locations')
        .then(res => res.json())
        .then(rawData => {
            provinceData = Object.entries(rawData).map(([code, obj]) => ({
                name: obj.name,
                districts: Object.entries(obj["quan-huyen"]).map(([dCode, dObj]) => ({
                    name: dObj.name,
                    wards: Object.entries(dObj["xa-phuong"]).map(([wCode, wObj]) => ({ name: wObj.name }))
                }))
            }));
            const provinceSelect = document.getElementById("province");
            provinceData.forEach((p, i) => {
                const opt = document.createElement("option"); opt.value = i; opt.text = p.name; provinceSelect.appendChild(opt);
            });
        });

    function loadDistricts() {
        const index = document.getElementById("province").value;
        const district = document.getElementById("district"), ward = document.getElementById("ward");
        district.innerHTML = '<option>Chọn</option>'; ward.innerHTML = '<option>Chọn</option>';
        if (index === "") return;
        provinceData[index].districts.forEach((d, i) => {
            const opt = document.createElement("option"); opt.value = i; opt.text = d.name; district.appendChild(opt);
        });
    }

    function loadWards() {
        const pIndex = document.getElementById("province").value;
        const dIndex = document.getElementById("district").value;
        const ward = document.getElementById("ward"); ward.innerHTML = '<option>Chọn</option>';
        if (pIndex === "" || dIndex === "") return;
        provinceData[pIndex].districts[dIndex].wards.forEach(w => {
            const opt = document.createElement("option"); opt.text = w.name; ward.appendChild(opt);
        });
    }

    function updateShippingFee() {
        const index = document.getElementById("province").value;
        const shippingFee = document.getElementById("shippingFee");
        const totalAmount = document.getElementById("totalAmount");
        const totalInput = document.getElementById("totalAmountInput");
        let baseTotal = parseInt(<%= request.getAttribute("total") %>);
        if (index === "") { shippingFee.innerText = 0; totalAmount.innerText = baseTotal; totalInput.value = baseTotal; return; }
        const province = provinceData[index].name;
        const fees = {"Hà Nội":20000,"Hồ Chí Minh":25000,"default":35000};
        const fee = fees[province] || fees["default"];
        shippingFee.innerText = fee;
        const total = baseTotal + fee;
        totalAmount.innerText = total; totalInput.value = total;
    }
</script>
</body>
</html>
